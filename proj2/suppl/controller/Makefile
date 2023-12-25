IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Source files
SRC_FILES = controller.v counter_5b.v counter_10b.v
TB_FILE = controller_tb.v
# Simulation target
TARGET = controller_tb
NORMAL_TARGET = normal_tb

sim:
	$(IVERILOG) -o $(TARGET) $(SRC_FILES) $(TB_FILE)
	$(VVP) $(TARGET)
	$(GTKWAVE) $(TARGET).vcd