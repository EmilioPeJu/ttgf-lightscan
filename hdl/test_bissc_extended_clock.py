#!/usr/bin/env python
import cocotb

from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles, Timer
from cocotb_tools.runner import get_runner
from cocotb.utils import get_sim_time


async def reset(dut):
    dut.rst_i.value = 1
    dut.go_i.value = 0
    dut.data_i.value = 1
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0
    await RisingEdge(dut.clk_i)


@cocotb.test(skip=True)
async def can_run(dut):
    cocotb.start_soon(Clock(dut.clk_i, 1, 'ns').start(start_high=False))
    await reset(dut)


@cocotb.test(skip=True)
@cocotb.parametrize(npulses=[0, 1, 2, 4], half_clk_period=[0, 1, 2, 4])
async def gen_clock(dut, npulses, half_clk_period):
    cocotb.start_soon(Clock(dut.clk_i, 1, 'ns').start(start_high=False))
    await reset(dut)
    dut.n_rising_edges_i.value = npulses
    dut.half_clk_period_i.value = half_clk_period
    dut.go_i.value = 1
    await RisingEdge(dut.clk_i)
    dut.go_i.value = 0
    expected_clk = 0
    for _ in range(npulses):
        for _ in range(2):
            for _ in range(half_clk_period + 1):
                await RisingEdge(dut.clk_i)
                assert dut.clk_o.value == expected_clk
            expected_clk = 1 - expected_clk

    for _ in range(half_clk_period + 1):
        await RisingEdge(dut.clk_i)
        assert dut.clk_o.value == 0

    for _ in range(2):
        await RisingEdge(dut.clk_i)
        assert dut.clk_o.value == 1


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
    await reset(dut)
    # Test point
    #   Raw: d0821e00 t: 28.1 turns 1, pos 16, extra: 1111000000000
    cocotb.start_soon(send_test_pos(dut, 0xd0821e00, 26))
    dut.n_rising_edges_i.value = 24
    dut.half_clk_period_i.value = 5
    dut.go_i.value = 1
    await RisingEdge(dut.clk_i)
    dut.go_i.value = 0
    await ClockCycles(dut.clk_i, 512)


def test_bissc_extended_clock():
    runner = get_runner('ghdl')
    runner.build(sources=[
                        'bissc_extended_clock.vhd',
                 ],
                 build_args=[
                     '--std=08',
                     '-frelaxed',
                 ],
                 build_dir='sim_build',
                 hdl_toplevel='bissc_extended_clock',
                 always=True,
                 verbose=True)
    runner.test(hdl_toplevel='bissc_extended_clock',
                test_args=[
                    '--std=08',
                    #'-frelaxed',
                 ],
                plusargs = [
                    '--fst=test_bissc_extended_clock.fst',
                ],
                verbose=True,
                test_module='test_bissc_extended_clock')
