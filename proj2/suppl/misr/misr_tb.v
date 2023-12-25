`timescale 1ns / 1ps
//`timescale 10ns / 1ns delete this one
////////////////////////////////////////////////////////////////////////////////

module misr_tb;

	reg clk, enable, reset;
    reg [9:0] misr_in;
	wire [6:0] misr_out;
	
	misr scrambler (
			.clk(clk),
			.enable(enable),
			.reset(reset),
            .in_misr(misr_in),
			.out_misr(misr_out)
			);

	initial 
		begin
		 $dumpfile("misr_tb.vcd");
		 $dumpvars(0,misr_tb);

		 clk=0;
		 enable=0;
		 reset=0;
		end
   
	always
//		#50 clk = !clk; 
		#10 clk = !clk; 

	initial
	  	begin
		 #200 reset=1; // Test reset
		 #200 reset=0;
         misr_in = 10'b1000100010;
		 #100 enable=1;
         #100000 enable = 0;
		 $finish;	
		end 
   			
endmodule