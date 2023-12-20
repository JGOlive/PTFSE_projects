`timescale 1ns / 1ps
//`timescale 10ns / 1ns delete this one
////////////////////////////////////////////////////////////////////////////////

module lfsr_7b_tb;

	reg clk, enable, reset;
	wire [6:0] lfsr_out;
	
	lfsr_7b lfsr (
			.clk(clk),
			.enable(enable),
			.reset(reset),
			.x(lfsr_out)
			);

	initial 
		begin
		 $dumpfile("lfsr_7b.vcd");
		 $dumpvars(0,lfsr_7b_tb);

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
		 #100 enable=1;
		 #100 enable=1; 
		 wait (lfsr_out == 8)
		 $finish;	
		end 
   			
endmodule