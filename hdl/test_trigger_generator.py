#!/usr/bin/env python
import cocotb

from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles

from common import top_path, run_test, assert_value_ticks


async def reset(dut):
    dut.rst_i.value = 1
    dut.go_i.value = 0
    dut.ntrig_i.value = 0
    dut.trig_period_i.value = 0
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0
    await RisingEdge(dut.clk_i)


@cocotb.test()
async def can_run(dut):
    cocotb.start_soon(Clock(dut.clk_i, 1, 'ns').start(start_high=False))
    await reset(dut)


@cocotb.test()
@cocotb.parametrize(ntrig=[0, 1, 3, 7], trig_period=[0, 1, 3, 7])
async def gen_trig(dut, ntrig, trig_period):
    cocotb.start_soon(Clock(dut.clk_i, 1, 'ns').start(start_high=False))
    await reset(dut)
    dut.ntrig_i.value = ntrig
    dut.trig_period_i.value = trig_period
    dut.go_i.value = 1
    await RisingEdge(dut.clk_i)
    dut.go_i.value = 0
    await ClockCycles(dut.clk_i, 2)
    for _ in range(ntrig + 1):
        await assert_value_ticks(dut.clk_i, dut.trig_o, [
            (0, trig_period), (1, 1)])


def test_trig_generator():
    run_test('test_trigger_generator', 'trigger_generator', [
        top_path / 'src' / 'trigger_generator.vhdl',
    ])
