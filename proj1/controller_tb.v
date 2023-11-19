`timescale 1ns / 1ps
//`timescale 10ns / 1ns delete this one
////////////////////////////////////////////////////////////////////////////////

module controller_tb;

	reg clk, start, reset;
	wire out, bist_end, running;
	
	controller controller (
			.clk(clk),
			.start(start),
			.reset(reset),
			.out(out),
			.bist_end(bist_end),
			.running(running)
			);

	initial 
		begin
		 $dumpfile("controller_tb.vcd");
		 $dumpvars(0,controller_tb);

		 clk=0;
		 start=0;
		 reset=0;
		end
   
	always
//		#50 clk = !clk; 
		#10 clk = !clk; 

	initial
	  	begin
		 #200 reset=1; // Test reset
		 #200 reset=0;
		 #100 start=1; // test start
		 #50  start=0;
		 #2000 $finish;	
		end 
   			
endmodule