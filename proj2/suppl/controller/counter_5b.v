`timescale 100ps / 1ps 

module counter_5b(input clk, input reset, input enable, output reg [4:0] count);
    
    always @(posedge clk) begin
        if (reset == 1)
            count <= 5'd0;
        else if (enable == 1)
            count <= count + 5'd1;
    end

endmodule