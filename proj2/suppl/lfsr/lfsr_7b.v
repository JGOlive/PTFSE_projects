

module lfsr_7b(
        input clk,
        input reset,
        input enable,
        output reg [6:0] x
    );


    always @(posedge clk) begin
        if (reset == 1) begin
            x <= 8;
        end
        else if (enable == 1) begin
            x[0] <= x[1];
            x[1] <= x[2];
            x[2] <= x[3];
            x[3] <= x[4];
            x[4] <= x[5];
            x[5] <= x[6];
            x[6] <= x[0] ^ x[1];
        end
        else begin
        
        end
    end

endmodule