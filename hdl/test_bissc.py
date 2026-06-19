#!/usr/bin/env python
import cocotb

from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles, Timer
from cocotb_tools.runner import get_runner
from cocotb.utils import get_sim_time

from common import top_path, run_test


async def reset(dut):
    dut.rst_i.value = 1
    dut.data_i.value = 1
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0
    await RisingEdge(dut.clk_i)


def iter_dw_top_bits(value, nbits):
    for i in range(nbits):
        yield (value >> (31 - i)) & 1


async def send_test_pos(dut, raw_data, nbits):
    for bit in iter_dw_top_bits(raw_data, nbits):
        await RisingEdge(dut.clk_o)
        await Timer(3, 'ns')
        print(f'{get_sim_time('ns')} Sending bit {bit}')
        dut.data_i.value = bit

    dut.data_i.value = 0
    await Timer(60, 'ns')
    dut.data_i.value = 1
    await RisingEdge(dut.clk_i)


@cocotb.test()
async def delay_timer(dut):
    cocotb.start_soon(Clock(dut.clk_i, 1, 'ns').start(start_high=False))
    # latch, ack, start, cds, 22 bits, back to idle
    dut.n_rising_edges_i.value = 26
    dut.half_clk_period_i.value = 5
    await reset(dut)
    
    # Test point
    #   Raw: d0821e00 t: 28.1 turns 1, pos 16, extra: 1111000000000
    cocotb.start_soon(send_test_pos(dut, 0xd0821e00, 26))
    dut.go_i.value = 1
    await RisingEdge(dut.clk_i)
    dut.go_i.value = 0
    await ClockCycles(dut.clk_i, 512)


def test_bissc():
    run_test('test_bissc', 'bissc', [
        top_path / 'src' / 'bissc.vhdl',
        top_path / 'src' / 'bissc_clock.vhdl',
        top_path / 'src' / 'bissc_extended_clock.vhdl',
        top_path / 'src' / 'bissc_capture.vhdl',
    ])
