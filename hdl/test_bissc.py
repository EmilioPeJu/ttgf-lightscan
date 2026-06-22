#!/usr/bin/env python
import cocotb

from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles
from enum import Enum

from common import top_path, run_test


async def wait_for_pos_ready(dut):
    while True:
        await RisingEdge(dut.clk_i)
        if dut.valid_o.value:
            break


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
        self.clk = dut.clk_i
        self.pos = 0
        self.pos_nbits = 14
        self.deadtime = 10
        self.bissc_data = 1

    @property
    def bissc_clk(self):
        return 1 if self.dut.clk_o.value else 0

    @property
    def bissc_data(self):
        return 1 if self.dut.data_i.value else 0

    @bissc_data.setter
    def bissc_data(self, value):
        self.dut.data_i.value = 1 if value else 0

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


async def reset(dut):
    dut.rst_i.value = 1
    dut.data_i.value = 1
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0
    await RisingEdge(dut.clk_i)


@cocotb.test()
async def single_position(dut):
    cocotb.start_soon(Clock(dut.clk_i, 1, 'ns').start(start_high=False))
    # latch, ack, start, cds, 22 bits, back to idle
    dut.n_rising_edges_i.value = 26
    dut.half_clk_period_i.value = 5
    await reset(dut)
    await ClockCycles(dut.clk_i, 2)
    bissc = BISSCSlave(dut)
    bissc.start()
    # Test position
    bissc.pos = 0x410
    dut.go_i.value = 1
    await RisingEdge(dut.clk_i)
    dut.go_i.value = 0
    await wait_for_pos_ready(dut)
    assert dut.pos_o.value == 0x410, \
        f"Expected position {bissc.pos}, got {dut.pos_o.value}"


def test_bissc():
    run_test('test_bissc', 'bissc', [
        top_path / 'hdl' / 'bissc.vhd',
        top_path / 'hdl' / 'bissc_clock.vhd',
        top_path / 'hdl' / 'bissc_extended_clock.vhd',
        top_path / 'hdl' / 'bissc_capture.vhd',
    ])
