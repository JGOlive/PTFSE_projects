

module flsr_scan(
        input clk,
        input reset,
        output reg [3:0] x;
    );

    reg x8;

    always @(posedge clk) begin
        if (reset == 1) begin
            x <= 4b'0011;
            x4 <= 1;
        end
        else begin
            x[0] <= x[1];
            x[1] <= x[2];
            x[2] <= x[3];
            x[3] <= x[4];
            x[4] <= x[5];
            x[5] <= x[6];
            x[7] <= x8;
            x8 <=
        end
    end

endmodule