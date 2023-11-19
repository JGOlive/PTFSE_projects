`timescale 100ps / 1ps 
`include "params.v" 

module counter_control(
    input clk,
    input reset,
    input enable,
    input [3:0] n,
    input [3:0] m,
    output reg n_reset,
    output reg m_reset,
    output reg n_enable,
    output reg m_enable,
    output reg out,
    output reg done);
    
    always @(*) begin
        if (reset == 1) begin
            out = 0;
            done = 0;
            n_reset = 1;
            m_reset = 1;
            n_enable = 0;
            m_enable = 0;
        end
        else if (n == `N_MAX && m == `M_MAX) begin
            out = 0;
            done = 1;
            n_reset = 1;
            m_reset = 1;
            n_enable = 0;
            m_enable = 0;
        end
        else if (enable == 1) begin
            done = 0;
            if (n == `N_MAX) begin
                out = 0;
                n_enable = 0;
                n_reset = 1;
                m_enable = 1; 
                m_reset = 0;
            end
            else begin
                out = 1;
                n_enable = 1;
                n_reset = 0;
                m_enable = 0;
                m_reset = 0;
            end
        end
        else begin
            out = 0;
            done = 0;
            n_enable = 0;
            m_enable = 0;
        end
    end

endmodule