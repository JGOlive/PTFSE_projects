IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Source files
SRC_FILES = misr.v
TB_FILE = misr_tb.v
# Simulation target
TARGET = misr_tb
NORMAL_TARGET = normal_tb

sim:
	$(IVERILOG) -o $(TARGET) $(SRC_FILES) $(TB_FILE)
	$(VVP) $(TARGET)
	$(GTKWAVE) $(TARGET).vcd