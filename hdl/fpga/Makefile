VHDL_FILES=$(wildcard ../*.vhdl) $(wildcard ../*.vhd) tt_fpga_top.vhdl
ENTITY=tt_fpga_top
PCF=fabricfox.pcf
SDC=fabricfox.sdc
TARGET=build/tt_um_emiliopeju_lightscan.bin
JSON=build/tt_um_emiliopeju_lightscan.json

$(TARGET):  $(VHDL_FILES) $(PCF) $(SDC)
	mkdir -p build
	yosys -p "ghdl --std=08 $(VHDL_FILES) -e $(ENTITY); synth_ice40 -json $(JSON)" && \
	nextpnr-ice40 --pcf-allow-unconstrained \
        --up5k --package sg48 --freq 12 \
        --pcf $(PCF) --sdc $(SDC) --json $(JSON) --asc $@.asc && \
        icepack $@.asc $@

synth_show: $(VHDL_FILES)
	yosys -p "ghdl --std=08 $(VHDL_FILES) -e $(ENTITY); proc; opt; show -colors 2 -width -signed -format dot -viewer xdot"

synth_stat: $(VHDL_FILES)
	yosys -p "ghdl --std=08 $(VHDL_FILES) -e $(ENTITY); proc; opt; stat -tech xilinx -json"

flash: $(TARGET)
	mpremote cp $< :bitstreams

clean:
	rm -rf build/*
