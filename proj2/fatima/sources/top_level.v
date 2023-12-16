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

    // Regs, wires LFSR
    // 7b
    reg reset_lfsr_7b, en_lfsr_7b;
    reg reset_lfsr_9b, en_lfsr_9b;
    wire [6:0] out_lfsr_7b;
    wire [8:0] out_lfsr_9b;
    
    // Regs, wires for circuit09
    // inputs
    reg reset_circuito09;
    reg emptyID1_circuito09; 
    reg emptyID2_circuito09; 
    reg emptyID1_prev_circuit09; 
    reg emptyID2_prev_circuito09; 
    reg start_test_circuito09; 
    reg end_test_circuit09; 
    reg end_test_global_circuito09; 
    // outputs
    wire clearID1_circuito09;
    wire clearID2_circuito09;
    wire restart_col_select_circuito09;
    wire loadID1_circuito09;
    wire loadID2_circuito09;
    wire resetID1_circuito09;
    wire resetID2_circuito09;
    wire clearID1_prev_circuito09;
    wire clearID2_prev_circuito09;
    // scan stuff
    reg scan_en_circuito09;
    reg scan_in_circuito09;
    wire scan_out_circuito09;
 
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

    // LFSRs
    lfsr_7b lfsr_7b(
        .reset(reset_lfsr_7b),
        .clk(clk),
        .enable(en_lfsr_7b),
        .x(out_lfsr_7b)
    );

    lfsr_9b lfsr_9b(
        .reset(reset_lfsr_9b),
        .clk(clk),
        .enable(en_lfsr_9b),
        .x(out_lfsr_9b)
    );

    circuito09_scan_syn circuito09(
        .reset(reset_circuito09),
        .clk(clk),
        .emptyID1(emptyID1_circuito09), 
        .emptyID2(emptyID2_circuito09), 
        .emptyID1_prev(emptyID1_prev_circuit09),
        .emptyID2_prev(emptyID2_prev_circuito09),
        .start_test(start_test_circuito09),
        .end_test(end_test_circuit09),
        .end_test_global(end_test_global_circuito09),
        .clearID1(clearID1_circuito09),
        .clearID2(clearID2_circuito09),
        .restart_col_select(restart_col_select_circuito09),
        .loadID1(loadID1_circuito09),
        .loadID2(loadID2_circuito09),
        .resetID1(resetID1_circuito09),
        .resetID2(resetID2_circuito09),
        .clearID1_prev(clearID1_prev_circuito09),
        .clearID2_prev(clearID2_prev_circuito09),
        .scan_en(scan_en_circuito09),
        .scan_in(scan_in_circuito09),
        .scan_out(scan_out_circuito09)
    );

endmodule