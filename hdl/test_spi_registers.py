#!/usr/bin/env python
import cocotb

from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles

from common import top_path, run_test


async def reset(dut):
    dut.rst_i.value = 1
    dut.trig_i.value = 0
    await RisingEdge(dut.clk_i)
    dut.rst_i.value = 0
    await RisingEdge(dut.clk_i)


@cocotb.test()
async def stable_outputs_after_reset(dut):
    cocotb.start_soon(Clock(dut.clk_i, 1, 'ns').start(start_high=False))
    await reset(dut)
    await ClockCycles(dut.clk_i, 1)
    for name in ['trig_period_o', 'ntrig_o', 'width_o',
                 'bissc_half_clk_period_o', 'bissc_n_rising_edges_o',
                 'pos_req_o', 'acq_start_o', 'io_dir_o', 'io_out_o']:
        assert getattr(dut, name).value == 0, \
            f"{name} is not stable after reset"


def test_spi_registers():
    run_test('test_spi_registers', 'spi_registers', [
        top_path / 'hdl' / 'spi_registers.vhd',
    ])
