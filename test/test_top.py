#!/usr/bin/env python
import cocotb

from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

from common import run_test


@cocotb.test()
async def can_run(dut):
    cocotb.start_soon(Clock(dut.clk, 1, 'ns').start(start_high=False))
    await RisingEdge(dut.clk)


def test_top():
    run_test('test_top')
