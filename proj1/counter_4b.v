`timescale 100ps / 1ps 

module counter_4b(input clk, input reset, input enable, output reg [3:0] count);
    
    always @(posedge clk or posedge reset) begin
        if (reset == 1)
            count <= 4'd0;
        else if (enable == 1)
            count <= count + 4'd1;
    end

endmodule