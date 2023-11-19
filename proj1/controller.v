`timescale 100ps / 1ps 

////////////////////////////////////////////////////////////////////////////////// 
//
// Company: Instituto Superior Técnico de Lisboa 
// Module Name: pulseproj
// Description: pulse generator
// 
////////////////////////////////////////////////////////////////////////////////// 
// 0.1 us clock

module controller(
    input clk,
    input start,
    input reset,
    output reg out,
    output reg bist_end,
    output reg running);

    // State Flip-flops
    reg [2:0] state, n_state;
    
    // State coding
    localparam [2:0] IDLE = 0, RUN = 1, COMPLETED = 2;

    // M and N 
    localparam [3:0] N_MAX = 8;
    localparam [3:0] M_MAX = 9;

    // Regs
    reg pos_start;
    wire [3:0] n, m;

    // wires
    wire n_en, n_rst;
    wire m_en, m_rst;
    reg cnt_ctrl_en, cnt_ctrl_rst; 
    wire cnt_ctrl_out, cnt_ctrl_done;




    always @(posedge clk) begin

        if (reset == 1)
            state = IDLE;
        else
            state = n_state;

    end

    always @(*) begin
    
        case (state)
        IDLE: begin
            // Outputs
            out = 0;
            bist_end = 0;
            running = 0;
            // module regs
            /*n = 0;
            m = 0;*/
            // Counter control
            cnt_ctrl_rst = 1;
            cnt_ctrl_en = 0;

            // Defining the next state
            if (pos_start == 1) begin
                n_state = RUN;
                pos_start = 0;
                /*
                n_en = 1;
                n_rst = 0;*/
            end
            else
                n_state = state;
        end

        RUN: begin

            if (cnt_ctrl_done == 0) begin
                cnt_ctrl_rst = 0;
                cnt_ctrl_en = 1;
            end
            else begin
                cnt_ctrl_en = 0;
                cnt_ctrl_rst = 1;
            end

            /*if (n == N_MAX-1 && m == M_MAX)
                n_state = COMPLETED;
            else if (n == N_MAX) begin
                out = 0;

                n_rst = 1;

                m_en = 1;
                m_rst = 0;

                n_state = state;
            end
            else begin
                out = 1;

                n_rst = 0;
                n_en = 1;

                m_en = 0;
                m_rst = 1;

                n_state = state;
            end */
        end
        
        COMPLETED: begin

        end

        default: n_state = IDLE;
        endcase
    end

    // Detects L to H transition on START input
    always @(posedge start) begin
        pos_start = 1;
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

    // Counter control
    counter_control counter_control(
        .clk(clk),
        .reset(cnt_ctrl_rst),
        .enable(cnt_ctrl_en),
        .n(n),
        .m(m),
        .n_reset(n_rst),
        .m_reset(m_rst),
        .n_enable(n_en),
        .m_enable(m_en),
        .out(cnt_ctrl_out),
        .done(cnt_ctrl_done)
    );

endmodule