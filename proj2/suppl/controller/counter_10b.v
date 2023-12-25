`timescale 100ps / 1ps 

module counter_10b(input clk, input reset, input enable, output reg [9:0] count);
    
    always @(posedge clk) begin
        if (reset == 1)
            count <= 10'd0;
        else if (enable == 1)
            count <= count + 10'd1;
    end

endmodule