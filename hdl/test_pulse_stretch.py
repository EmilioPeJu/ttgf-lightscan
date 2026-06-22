#!/usr/bin/env python
import cocotb

from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

from common import top_path, run_test, assert_value_ticks


async def reset(dut):
    dut.rst_i.value = 1
    dut.trig_i.value = 0
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0
    await RisingEdge(dut.clk_i)


@cocotb.test()
async def can_run(dut):
    cocotb.start_soon(Clock(dut.clk_i, 1, 'ns').start(start_high=False))
    await reset(dut)


@cocotb.test()
@cocotb.parametrize(width=[0, 1, 3, 7])
async def gen_trigger(dut, width):
    cocotb.start_soon(Clock(dut.clk_i, 1, 'ns').start(start_high=False))
    await reset(dut)
    dut.width_i.value = width
    await RisingEdge(dut.clk_i)
    assert dut.pulse_o.value == 0
    dut.trig_i.value = 1
    await RisingEdge(dut.clk_i)
    dut.trig_i.value = 0
    await RisingEdge(dut.clk_i)
    await assert_value_ticks(dut.clk_i, dut.pulse_o,
        [(1, width + 1), (0, width + 1)])


def test_trigger_generator():
    run_test('test_pulse_stretch', 'pulse_stretch', [
        top_path / 'hdl' / 'pulse_stretch.vhd',
    ])
