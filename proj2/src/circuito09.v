`timescale 1ns / 1ps

module circuito09 (clk, reset, emptyID1, emptyID2, emptyID1_prev, emptyID2_prev, start_test, end_test, end_test_global, clearID1, clearID2, restart_col_select, loadID1, loadID2, resetID1, resetID2, clearID1_prev, clearID2_prev);

   input clk; 
   input reset; 
   input emptyID1; 
   input emptyID2; 
   input emptyID1_prev; 
   input emptyID2_prev; 
   input start_test; 
   input end_test; 
   input end_test_global; 
   output clearID1; 
   wire clearID1;
   output clearID2; 
   wire clearID2;
   output restart_col_select; 
   reg restart_col_select;
   output loadID1; 
   reg loadID1;
   output loadID2; 
   reg loadID2;
   output resetID1; 
   reg resetID1;
   output resetID2; 
   reg resetID2;
   output clearID1_prev; 
   reg clearID1_prev;
   output clearID2_prev; 
   reg clearID2_prev;

   localparam [3:0] start_tx = 4'b0100; 
   localparam [3:0] stop_tx = 4'b1110; 
   localparam [3:0] stop_tx_prev = 4'b1010; 
   localparam [1:0] INIT = 0; 
   localparam [1:0] BIST = 1; 
   localparam [1:0] ESPERA = 2; 
   localparam [1:0] RUN = 3; 
   reg[1:0] cur; 
   reg[1:0] nxt; 
   reg[3:0] cntCh1; 
   reg[3:0] cntCh2; 
   reg[3:0] cntCh1_prev; 
   reg[3:0] cntCh2_prev; 
   reg clearID1_i; 
   reg clearID2_i; 

   assign clearID1 = clearID1_i ;
   assign clearID2 = clearID2_i ;

   always @(posedge clk)
   begin 
      if (reset == 1'b1)
         cur <= INIT ;
      else
         cur <= nxt ;
   end 

   always @(*)
   begin 
      case (cur)
         INIT :
                  begin
                     if (start_test == 1'b0)
                     begin
                        nxt = INIT ; 
                     end
                     else
                     begin
                        nxt = BIST ; 
                     end 
                     clearID1_i = 1'b1 ; 
                     clearID2_i = 1'b1 ; 
                     clearID1_prev = 1'b1 ; 
                     clearID2_prev = 1'b1 ; 
                     restart_col_select = 1'b1 ; 
                     loadID1 = 1'b0 ; 
                     loadID2 = 1'b0 ; 
                     resetID1 = 1'b0 ; 
                     resetID2 = 1'b0 ; 
                  end
         BIST :
                  begin
                     if (end_test == 1'b0)
                     begin
                        nxt = BIST ; 
                     end
                     else
                     begin
                        nxt = ESPERA ; 
                     end 
                     restart_col_select = 1'b0 ; 
                     if (cntCh1 == start_tx)
                     begin
                        loadID1 = 1'b1 ; 
                     end
                     else
                     begin
                        loadID1 = 1'b0 ; 
                     end 
                     if (cntCh1 == (stop_tx - 1))
                     begin
                        clearID1_i = 1'b1 ; 
                     end
                     else
                     begin
                        clearID1_i = 1'b0 ; 
                     end 
                     if (cntCh1 == stop_tx)
                     begin
                        resetID1 = 1'b1 ; 
                     end
                     else
                     begin
                        resetID1 = 1'b0 ; 
                     end 
                     if (cntCh1_prev == stop_tx_prev)
                     begin
                        clearID1_prev = 1'b1 ; 
                     end
                     else
                     begin
                        clearID1_prev = 1'b0 ; 
                     end 
                     if (cntCh2 == start_tx)
                     begin
                        loadID2 = 1'b1 ; 
                     end
                     else
                     begin
                        loadID2 = 1'b0 ; 
                     end 
                     if (cntCh2 == (stop_tx - 1))
                     begin
                        clearID2_i = 1'b1 ; 
                     end
                     else
                     begin
                        clearID2_i = 1'b0 ; 
                     end 
                     if (cntCh2 == stop_tx)
                     begin
                        resetID2 = 1'b1 ; 
                     end
                     else
                     begin
                        resetID2 = 1'b0 ; 
                     end 
                     if (cntCh2_prev == stop_tx_prev)
                     begin
                        clearID2_prev = 1'b1 ; 
                     end
                     else
                     begin
                        clearID2_prev = 1'b0 ; 
                     end 
                  end
         ESPERA :
                  begin
                     if (end_test_global == 1'b0)
                     begin
                        nxt = ESPERA ; 
                     end
                     else
                     begin
                        nxt = RUN ; 
                     end 
                     clearID1_i = 1'b1 ; 
                     clearID2_i = 1'b1 ; 
                     clearID1_prev = 1'b1 ; 
                     clearID2_prev = 1'b1 ; 
                     restart_col_select = 1'b1 ; 
                     loadID1 = 1'b0 ; 
                     loadID2 = 1'b0 ; 
                     resetID1 = 1'b0 ; 
                     resetID2 = 1'b0 ; 
                  end
         RUN :
                  begin
                     nxt = RUN ; 
                     restart_col_select = 1'b0 ; 
                     if (cntCh1 == start_tx)
                     begin
                        loadID1 = 1'b1 ; 
                     end
                     else
                     begin
                        loadID1 = 1'b0 ; 
                     end 
                     if (cntCh1 == (stop_tx - 1))
                     begin
                        clearID1_i = 1'b1 ; 
                     end
                     else
                     begin
                        clearID1_i = 1'b0 ; 
                     end 
                     if (cntCh1 == stop_tx)
                     begin
                        resetID1 = 1'b1 ; 
                     end
                     else
                     begin
                        resetID1 = 1'b0 ; 
                     end 
                     if (cntCh1_prev == stop_tx_prev)
                     begin
                        clearID1_prev = 1'b1 ; 
                     end
                     else
                     begin
                        clearID1_prev = 1'b0 ; 
                     end 
                     if (cntCh2 == start_tx)
                     begin
                        loadID2 = 1'b1 ; 
                     end
                     else
                     begin
                        loadID2 = 1'b0 ; 
                     end 
                     if (cntCh2 == (stop_tx - 1))
                     begin
                        clearID2_i = 1'b1 ; 
                     end
                     else
                     begin
                        clearID2_i = 1'b0 ; 
                     end 
                     if (cntCh2 == stop_tx)
                     begin
                        resetID2 = 1'b1 ; 
                     end
                     else
                     begin
                        resetID2 = 1'b0 ; 
                     end 
                     if (cntCh2_prev == stop_tx_prev)
                     begin
                        clearID2_prev = 1'b1 ; 
                     end
                     else
                     begin
                        clearID2_prev = 1'b0 ; 
                     end 
                  end
      endcase 
   end 

   always @(posedge clk)
   begin 
      if (reset == 1'b1)
      begin
         cntCh1 <= {4{1'b0}} ; 
         cntCh2 <= {4{1'b0}} ; 
         cntCh1_prev <= {4{1'b0}} ; 
         cntCh2_prev <= {4{1'b0}} ; 
      end
      else
      begin
         if (emptyID1 == 1'b1)
         begin
            cntCh1 <= {4{1'b0}} ; 
         end
         else
         begin
            cntCh1 <= cntCh1 + 1 ; 
         end 
         if (emptyID2 == 1'b1)
         begin
            cntCh2 <= {4{1'b0}} ; 
         end
         else
         begin
            cntCh2 <= cntCh2 + 1 ; 
         end 
         if (emptyID1_prev == 1'b1)
         begin
            cntCh1_prev <= {4{1'b0}} ; 
         end
         else
         begin
            cntCh1_prev <= cntCh1_prev + 1 ; 
         end 
         if (emptyID2_prev == 1'b1)
         begin
            cntCh2_prev <= {4{1'b0}} ; 
         end
         else
         begin
            cntCh2_prev <= cntCh2_prev + 1 ; 
         end 
      end 
   end 
endmodule
