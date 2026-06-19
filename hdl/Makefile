VHDL_FILES=$(wildcard *.vhdl) $(wildcard *.vhd)

../src/tt_um_emiliopeju_lightscan.v: $(VHDL_FILES)
	mkdir -p build
	cat $^ > build/top.vhdl && \
    ghdl synth -Wno-binding --std=08 --out=verilog build/top.vhdl -e tt_um_emiliopeju_lightscan > $@
