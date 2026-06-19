ENTITY = tt_um_emiliopeju_lightscan
VHDL_FILES=$(wildcard *.vhdl) $(wildcard *.vhd)

../src/tt_um_emiliopeju_lightscan.v: $(VHDL_FILES)
	yosys -p "ghdl --std=08 $(VHDL_FILES) -e $(ENTITY); write_verilog $@"
