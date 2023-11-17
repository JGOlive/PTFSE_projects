# Makefile for Verilog simulation with GTKWave

# Compiler and simulator
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Source files
SRC_FILES = filelist.txt


# Simulation target
COMP_TARGET = controller_tb

all:
	$(IVERILOG) -o $(COMP_TARGET) -c $(SRC_FILES)

sim: all
	$(VVP) $(COMP_TARGET)
	$(GTKWAVE) $(COMP_TARGET).vcd
clean:
	rm -f $(COMP_TARGET) $(COMP_TARGET).vcd
.PHONY: all clean