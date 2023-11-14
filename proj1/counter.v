`timescale 100ps / 1ps 

////////////////////////////////////////////////////////////////////////////////// 
//
// Company: Instituto Superior Técnico de Lisboa 
// Module Name: pulseproj
// Description: pulse generator
// 
////////////////////////////////////////////////////////////////////////////////// 
// 0.1 us clock

module counter(
    input clk,
    input init,
    input per,
    output reg pulse
	);

  reg prev_init;
  reg [1:0] state;
  reg [5:0] count;
  reg pulse_reg;

  always @(posedge clk) begin

    // Detects the L to H init transition
    if ((prev_init != init) && (init == 1)) begin
      count = 0;
      if (per == 0)
        state = 2'b10;  // Single pulse_reg
      else
        state = 2'b11;  // Repeated pulses
    end

    // Single pulse
    if (state == 2'b10) begin
      if (count < 10)
        pulse_reg = 0;
      if ((count < 15) && (count >= 10))
        pulse_reg = 1;
      if ((count < 40) && (count >= 15) )
        pulse_reg = 0;
      if (count >= 40) begin
        state = 2'b00;
      end
    end

    // Repated pulses
    if (state == 2'b11) begin
      if (count < 10)
        pulse_reg = 0;
      if ((count < 15) && (count >= 10))
        pulse_reg = 1;
      if ((count < 40) && (count >= 15) )
        pulse_reg = 0;
      if (count >= 40)
        count = 0;
    end

    if (state == 2'b00) begin
      count = 0;
      pulse_reg = 0;
    end

    count = count + 1;
    prev_init <= init;
    pulse = pulse_reg;
  end

endmodule