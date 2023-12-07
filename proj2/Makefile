IVERILOG = iverilog
VVP = vvp

# Source files
SRC_FILES = filelist.txt
BIST_TB_FILE = fatima/tbs/bist_tb.v
# Simulation target
BIST_TARGET = bist_tb
NORMAL_TARGET = normal_tb

bist:
	$(IVERILOG) -o $(BIST_TARGET)  $(BIST_TB_FILE) -c $(SRC_FILES)
	$(VVP) $(BIST_TARGET)