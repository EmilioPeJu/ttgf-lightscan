#!/usr/bin/env python
import cocotb

from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles

from common import top_path, run_test, assert_value_ticks


async def reset(dut):
    dut.rst_i.value = 1
    dut.go_i.value = 0
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0
    await RisingEdge(dut.clk_i)


@cocotb.test()
async def can_run(dut):
    cocotb.start_soon(Clock(dut.clk_i, 1, 'ns').start(start_high=False))
    await reset(dut)


@cocotb.test()
async def gen_trigger(dut):
    cocotb.start_soon(Clock(dut.clk_i, 1, 'ns').start(start_high=False))
    await reset(dut)
    dut.ntrig_i.value = 2
    dut.trig_period_i.value = 6
    dut.width_i.value = 3
    dut.go_i.value = 1
    await RisingEdge(dut.clk_i)
    dut.go_i.value = 0
    await ClockCycles(dut.clk_i, 2)
    await assert_value_ticks(
        dut.clk_i, dut.pulse_o,
        [(0, 6), (1, 5), (0, 2), (1, 5), (0, 2), (1, 5), (0, 6)])


def test_pulsed_trigger():
    run_test('test_pulsed_trigger', 'pulsed_trigger', [
        top_path / 'src' / 'pulsed_trigger.vhdl',
    ])
