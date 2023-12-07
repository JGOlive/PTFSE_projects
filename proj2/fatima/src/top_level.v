`timescale 1ns / 1ps

module top_level (
        input reset,
        input clock,
        input bist_start,
        output reg bist_end,
        output reg pass_nfail
    );

    // Regs
    reg p_bist_start;

    // Additions needes from 1st project
    // detects bist_start
    always @(posedge clock) begin

        if (p_bist_start == 0 && bist_start == 1)
            pos_bist_start <= 1;
        else
            pos_bist_start <= 0;

        p_bist_start <= bist_start;
    end

endmodule