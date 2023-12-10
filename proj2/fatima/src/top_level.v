`timescale 1ns / 1ps

module top_level (
        input reset,
        input clk,
        input bist_start,
        output bist_end,
        output reg pass_nfail
    );

    // Regs, wires
    reg prev_bist_start, pos_bist_start;

    // Regs, wires proj1 controller
    reg reset_proj1_ctrl;
    wire running_proj1_ctrl, out_proj1_ctrl;
    
    // RESET
    always @(posedge clk) begin
        if (reset == 1)
            reset_proj1_ctrl <= 1;
        else
            reset_proj1_ctrl <= 0;
    end

    // Additions needes from 1st project
    // detects bist_start and controller
    always @(posedge clk) begin

        // BIST start detection
        if (prev_bist_start == 0 && bist_start == 1)
            pos_bist_start <= 1;
        else
            pos_bist_start <= 0;

        prev_bist_start <= bist_start;

        // controller BIST end detection
    end

    // controller from proj1
    controller bist_controller (
        .reset(reset_proj1_ctrl),
        .clk(clk),
        .start(bist_start),
        .out(out_proj1_ctrl),
        .bist_end(bist_end),
        .running(running_proj1_ctrl)
    );

endmodule