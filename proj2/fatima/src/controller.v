`timescale 100ps / 1ps 

////////////////////////////////////////////////////////////////////////////////// 
//
// Company: Instituto Superior Técnico de Lisboa 
// Module Name: pulseproj
// Description: pulse generator
// 
////////////////////////////////////////////////////////////////////////////////// 
// 0.1 us clock
//`include "params.v" 
`define N_MAX 8
`define M_MAX 9

module controller(
    input clk,
    input start,
    input reset,
    output reg out,
    output reg bist_end,
    output reg running);

    // State Flip-flops
    reg [2:0] state, n_state;
    reg p_start;
    
    // State coding
    localparam [2:0] IDLE = 0, RUN_H = 1, RUN_L = 2, COMPLETED = 3;

    // M and N 
    localparam [3:0] N_MAX = 8;
    localparam [3:0] M_MAX = 9;

    // Regs
    reg pos_start;
    wire [3:0] n, m;

    // wires
    reg n_en, n_rst;
    reg m_en, m_rst;




    always @(posedge clk) begin

        if (reset == 1)
            state <= IDLE;
        else
            state <= n_state;

    end

    // Detects L to H transition on START input
    always @(posedge clk) begin
        if (p_start == 0 && start == 1)
            pos_start <= 1;
        else
            pos_start <= 0;

        p_start <= start;
    end

    always @(*) begin
    
        case (state)
        IDLE: begin
            // Outputs
            out = 0;
            bist_end = 0;
            running = 0;
            // M Counter
            m_en = 0;
            m_rst = 1;
            // N Counter
            n_en = 0;
            n_rst = 1;
            
            if (pos_start == 1) begin
                n_state = RUN_H; 
            end
            else
                n_state = state;
        end

        RUN_H: begin
            // Outputs
            out = 1;
            running = 1;
            bist_end = 0;
            // N Counter
            n_en = 1;
            n_rst = 0;
            // M Counter
            m_en = 0;
            m_rst = 0;

            // Defining the next state
            if (n == `N_MAX-1 && m == `M_MAX) begin
                n_state = COMPLETED;
            end
            else if (n == `N_MAX-1) begin
                n_state = RUN_L;
            end
            else
                n_state = state;
        end

        RUN_L: begin
            // Outputs
            out = 0;
            running = 1;
            bist_end = 0;

            // N Counter
            n_en = 0;
            n_rst = 1;
            // M Counter
            m_en = 1;
            m_rst = 0; 

            // Defining the next state
            n_state = RUN_H;
        end
        
        COMPLETED: begin
            // Outputs
            out = 0;
            running = 0;
            bist_end = 1;

            // M Counter
            m_rst = 1;
            m_en = 0;
            // N Counter
            n_rst = 1;
            n_en = 0;

            if (pos_start == 1) begin
                n_state = RUN_H;
            end
            else begin
                n_state = state;
            end
        end

        default: begin
            // Outputs
            out = 0;
            bist_end = 0;
            running = 0;
            // M Counter
            m_en = 0;
            m_rst = 1;
            // N Counter
            n_en = 0;
            n_rst = 1;

            n_state = IDLE;
        end
        endcase
    end

    // Counters
    counter_4b n_counter (
        .clk(clk),
        .reset(n_rst),
        .enable(n_en),
        .count(n)
    );
    counter_4b m_counter (
        .clk(clk),
        .reset(m_rst),
        .enable(m_en),
        .count(m)
    );

endmodule