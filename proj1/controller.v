`timescale 100ps / 1ps 

////////////////////////////////////////////////////////////////////////////////// 
//
// Company: Instituto Superior Técnico de Lisboa 
// Module Name: pulseproj
// Description: pulse generator
// 
////////////////////////////////////////////////////////////////////////////////// 
// 0.1 us clock

module controller(
    input clk,
    input start,
    input reset,
    output reg out,
    output reg bist_end,
    output reg running);

  // State Flip-flops
  reg [2:0] state, n_state;
  
  // State coding
  localparam [2:0] IDLE = 0, RUN = 1, COMPLETED = 2;

  // M and N 
  localparam [3:0] N_MAX = 8;
  localparam [3:0] M_MAX = 9;

  // Regs
  reg pos_start;
  reg [3:0] n, m;

  always @(posedge clk) begin

    if (reset == 1)
      state = IDLE;
    else
      state = n_state;

  end

  always @(*) begin
  
    case (state)
      IDLE: begin
        // Outputs
        out = 0;
        bist_end = 0;
        running = 0;

        // module regs
        n = 0;
        m = 0;

        // Defining the next state
        if (pos_start == 1) begin
          n_state = RUN;
          pos_start = 0;
        end
        else
          n_state = state;
      end

      RUN:  begin

        if (n == N_MAX-1 && m == M_MAX)
          n_state = COMPLETED;
        else
          n_state = state;
      end
      
      COMPLETED: begin

      end

      default:  n_state = IDLE;
    endcase
  end

  // Detects L to H transition on START input
  always @(posedge start) begin
    pos_start = 1;
  end

endmodule