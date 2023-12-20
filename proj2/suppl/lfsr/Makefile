IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Source files
SRC_FILES = lfsr_7b.v
TB_FILE = lfsr_7b_tb.v
# Simulation target
TARGET = lfsr_7b_tb
NORMAL_TARGET = normal_tb

sim:
	$(IVERILOG) -o $(TARGET) $(SRC_FILES) $(TB_FILE)
	$(VVP) $(TARGET)
	$(GTKWAVE) lfsr_7b.vcd