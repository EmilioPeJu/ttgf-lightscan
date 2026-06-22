# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
import struct

from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge
from enum import Enum

REG_ID = 0
REG_COUNTERS = 1
REG_POS = 2
REG_TRIG_PERIOD = 3
REG_NTRIGGERS = 4
REG_PULSE_WIDTH = 5
REG_BISSC_HPERIOD = 6
REG_BISSC_NEDGES = 7
REG_HIGH_POS = 8
REG_ACTION = 9
ACTION_REQUEST_POS = 1
ACTION_START = 0x2
ACTION_OVERRIDE_TRIG = 0x4
REG_SIO = 0xa
REG_IO = 0xb


async def wait_for_pos_ready(dut):
    while True:
        await RisingEdge(dut.clk)
        if dut.uo_out.value[2] == '1':
            break


class SPIHelper:
    CS_MASK = 0x1
    SCK_MASK = 0x2
    MOSI_MASK = 0x4
    MISO_MASK = 0x8

    def __init__(self, dut):
        self.dut = dut
        self.cached_ui_in = 0x7
        self.dut.ui_in.value = self.cached_ui_in
        self.clk = self.dut.clk

    @property
    def miso(self):
        return 1 if self.dut.uo_out.value[3] == '1' else 0

    @property
    def cs(self):
        return 1 if self.cached_ui_in & self.CS_MASK else 0

    @cs.setter
    def cs(self, value):
        if value:
            self.cached_ui_in |= self.CS_MASK
        else:
            self.cached_ui_in &= ~self.CS_MASK

        self.dut.ui_in.value = self.cached_ui_in

    @property
    def sck(self):
        return 1 if self.cached_ui_in & self.SCK_MASK else 0

    @sck.setter
    def sck(self, value):
        if value:
            self.cached_ui_in |= self.SCK_MASK
        else:
            self.cached_ui_in &= ~self.SCK_MASK

        self.dut.ui_in.value = self.cached_ui_in

    def toggle_sck(self):
        self.cached_ui_in ^= self.SCK_MASK
        self.dut.ui_in.value = self.cached_ui_in

    @property
    def mosi(self):
        return 1 if self.cached_ui_in & self.MOSI_MASK else 0

    @mosi.setter
    def mosi(self, value):
        if value:
            self.cached_ui_in |= self.MOSI_MASK
        else:
            self.cached_ui_in &= ~self.MOSI_MASK

        self.dut.ui_in.value = self.cached_ui_in

    async def transfer(self, write_buf: bytearray, read_buf: bytearray):
        assert len(write_buf) == len(read_buf)
        self.cs = 1
        await ClockCycles(self.clk, 10)
        self.cs = 0
        await ClockCycles(self.clk, 10)
        for byte_index in range(len(write_buf)):
            byte_out = write_buf[byte_index]
            byte_in = 0
            for _ in range(8):
                await ClockCycles(self.clk, 10)
                self.mosi = (byte_out >> 7) & 1
                byte_out <<= 1
                self.toggle_sck()
                await ClockCycles(self.clk, 10)
                self.toggle_sck()
                byte_in <<= 1
                byte_in |= self.miso

            read_buf[byte_index] = byte_in

        await ClockCycles(self.clk, 10)
        self.cs = 1
        await ClockCycles(self.clk, 10)

    async def reg_write(self, reg, value):
        write_buffer = struct.pack('>BI', reg | 0x80, value)
        await self.transfer(write_buffer, bytearray(5))

    async def reg_read(self, reg):
        write_buffer = struct.pack('>BI', reg & 0x7f, 0)
        read_buffer = bytearray(5)
        await self.transfer(write_buffer, read_buffer)
        return struct.unpack('>BI', read_buffer)[1]


def bissc_crc(value, nbits):
    # example: bissc_crc(0b0001_0000010000_11, 16) == 0x30
    crc = 0
    for i in range(nbits-1, -1, -1):
        bit = (value >> i) & 1
        crc <<= 1
        crc |=  bit
        if crc & 0x40:
            crc ^= 0x43

    for i in range(6):
        crc <<= 1
        if crc & 0x40:
            crc ^= 0x43
    return (~crc) & 0x3f


class BISSCState(Enum):
    IDLE = 0
    SENDING = 1
    DEADTIME = 2


class BISSCSlave:
    def __init__(self, dut):
        self.dut = dut
        self.clk = dut.clk
        self.pos = 0
        self.pos_nbits = 14
        self.deadtime = 10
        self.bissc_data = 1

    @property
    def bissc_clk(self):
        return 1 if self.dut.uio_out.value[0] == '1' else 0

    @property
    def bissc_data(self):
        return 1 if self.dut.uio_in.value[1] else 0

    @bissc_data.setter
    def bissc_data(self, value):
        self.dut.uio_in.value = 0x2 if value else 0

    def start(self):
        cocotb.start_soon(self.run())

    async def run(self):
        state = BISSCState.IDLE
        bissc_clk = self.bissc_clk
        bissc_clk_prev = bissc_clk
        index = 0
        while True:
            await RisingEdge(self.clk)
            bissc_clk_prev = bissc_clk
            bissc_clk = self.bissc_clk
            match state:
                case BISSCState.IDLE:
                    index = 0
                    if not self.bissc_clk:
                        state = BISSCState.SENDING
                case BISSCState.SENDING:
                    if not bissc_clk_prev and bissc_clk:
                        match index:
                            case 0:
                                left = self.pos_nbits + 2 + 6
                                pos_with_status = (self.pos << 2) | 0x3
                                data = (pos_with_status << 6) | \
                                        bissc_crc(pos_with_status, self.pos_nbits + 2)
                            case 1:
                                self.bissc_data = 0
                            case 2:
                                self.bissc_data = 1
                            case 3:
                                self.bissc_data = 0
                            case _:
                                self.bissc_data = (data >> (left-1)) & 1
                                left -= 1
                                if left == 0:
                                    state = BISSCState.DEADTIME
                        index += 1

                case BISSCState.DEADTIME:
                    self.bissc_data = 0
                    await ClockCycles(self.clk, self.deadtime)
                    self.bissc_data = 1
                    state = BISSCState.IDLE


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Frequency = 12MHz
    clock = Clock(dut.clk, 83.333, unit="us")
    cocotb.start_soon(clock.start())
    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 4)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 16)
    dut._log.info("Test project behavior")
    spi = SPIHelper(dut)

    # Test a known id register
    dev_id = await spi.reg_read(REG_ID)
    assert dev_id == 0xcafea51c

    # Test writing and reading back a register
    await spi.reg_write(REG_TRIG_PERIOD, 0x12345678)

    readback = await spi.reg_read(REG_TRIG_PERIOD)
    assert readback == 0x12345678

    bissc = BISSCSlave(dut)
    bissc.start()

    # Test requesting a single position
    await spi.reg_write(REG_BISSC_NEDGES, 26)
    await spi.reg_write(REG_BISSC_HPERIOD, 5)

    bissc.pos = 0x410
    await spi.reg_write(REG_ACTION, ACTION_REQUEST_POS)
    await wait_for_pos_ready(dut)
    pos = await spi.reg_read(REG_POS)
    assert pos == bissc.pos

    # Test an acquisition with 16 pulses
    await spi.reg_write(REG_TRIG_PERIOD, 1024)
    await spi.reg_write(REG_NTRIGGERS, 15)
    bissc.pos = 0
    await spi.reg_write(REG_ACTION, ACTION_START)
    for i in range(16):
        await wait_for_pos_ready(dut)
        bissc.pos += 1
        pos = await spi.reg_read(REG_POS)
        assert pos == i 

    # A few extra ticks for courtesy
    await ClockCycles(dut.clk, 16)
