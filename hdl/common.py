import cocotb

from cocotb.triggers import RisingEdge
from cocotb_tools.runner import get_runner
from cocotb.utils import get_sim_time
from pathlib import Path

top_path = Path(__file__).parent.parent.resolve()


def run_test(test_module: str, entity: str, sources: list[str]):
    runner = get_runner('ghdl')
    runner.build(sources=sources,
                 build_args=[
                     '--std=08',
                     '-frelaxed',
                 ],
                 build_dir='sim_build',
                 hdl_toplevel=entity,
                 always=True,
                 verbose=True)
    runner.test(hdl_toplevel=entity,
                test_args=[
                    '--std=08',
                 ],
                plusargs = [
                    f'--fst={test_module}.fst',
                ],
                verbose=True,
                test_module=test_module)


async def assert_value_ticks(clk, signal, value_ticks_list: list[tuple[int, int]]):
    for value, ticks in value_ticks_list:
        for _ in range(ticks):
            assert signal.value == value, \
                f'Expected {value} at {get_sim_time()} ns, got {signal.value}'
            await RisingEdge(clk)
