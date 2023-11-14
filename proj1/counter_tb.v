`timescale 1ns / 1ps
//`timescale 10ns / 1ns delete this one
////////////////////////////////////////////////////////////////////////////////

module counter_tb;

	reg clk, per, init;
	wire pulse;
	
	counter counter (
			.clk(clk),
			.init(init),
			.per(per),
			.pulse(pulse)
			);

	initial 
		begin
		 $dumpfile("counter_tb.vcd");
		 $dumpvars(0,counter_tb);

		 clk=0;
		 init=0;
		 per=0;
		end
   
	always
		#50 clk = !clk; 
//		#10 clk = !clk; 

	initial
	  	begin
		 #300 per=0;
		 #400 init=1; // force known state (single pulse)
		 #800 init=0;
		 #5500 init=1; // test single state
		 #5600 init=0;
		 #9100 per=1;
		 #9600 init=1;	// test repeated mode
		 #9700 init=0;
		 #15600 init=1; // cont pulse while on cont pulse
		 #15700	init=0;
		 #24000 per=0;
		 #25000 init=1;	// single pulse while on cont pulse
		 #25100 init=0;
		 #30000 $finish;	
		end 
   			
endmodule