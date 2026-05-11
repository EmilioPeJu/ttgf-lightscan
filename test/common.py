from cocotb_tools.runner import get_runner
from pathlib import Path

top_path = Path(__file__).parent.parent.resolve()


def run_test(test_module: str):
    runner = get_runner('ghdl')
    runner.build(sources=[
                     top_path / 'src' / 'tt_um_emiliopeju_lightscan_top.vhdl',
                 ],
                 build_args=[
                     '--std=08',
                     '-frelaxed',
                 ],
                 build_dir='sim_build',
                 hdl_toplevel='tt_um_emiliopeju_lightscan_top',
                 always=True,
                 verbose=True)
    runner.test(hdl_toplevel='tt_um_emiliopeju_lightscan_top',
                test_args=[
                    '--std=08',
                    #'-frelaxed',
                 ],
                plusargs = [
                    f'--fst={test_module}.fst',
                ],
                verbose=True,
                test_module=test_module)
