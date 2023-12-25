`timescale 100ps / 1ps 

module misr(input clk, input reset, input enable, input [9:0] in_misr, output reg [9:0] out_misr);
    
    reg [9:0] misr_ff;

    always @(posedge clk) begin
        if (reset == 1) begin
            misr_ff <= 9'b000000000;
            out_misr <= 10'b0000000000; 
        end
        else if (enable == 1) begin
            misr_ff[0] <= out_misr[9] ^              in_misr[0];
            misr_ff[1] <= out_misr[9] ^ misr_ff[0] ^ in_misr[1];
            misr_ff[2] <= out_misr[9] ^ misr_ff[1] ^ in_misr[2];
            misr_ff[3] <= out_misr[9] ^ misr_ff[2] ^ in_misr[3];
            misr_ff[4] <= out_misr[9] ^ misr_ff[3] ^ in_misr[4];
            misr_ff[5] <= out_misr[9] ^ misr_ff[4] ^ in_misr[5];
            misr_ff[6] <= out_misr[9] ^ misr_ff[5] ^ in_misr[6];
            misr_ff[7] <= out_misr[9] ^ misr_ff[6] ^ in_misr[7];
            misr_ff[8] <= out_misr[9] ^ misr_ff[7] ^ in_misr[8];
            misr_ff[9] <= out_misr[9] ^ misr_ff[8] ^ in_misr[9];
            out_misr <= misr_ff;
        end
    end

endmodule