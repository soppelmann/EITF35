`timescale 1ns / 1ps


module keyboard_controller(
    input clk,
    input reset_n,
    input valid_scan_code,
    input [7:0] scan_code,
    output [31:0] scan_codes,
    output [7:0] curr_state
);


   reg state, next_state;
   reg [31:0] int_scan_codes;
   reg [31:0] w_scan_codes;
   // Debug variables
   reg [7:0]  TEST_CTRL_1;
   reg [7:0]  TEST_CTRL_2;
   reg [8:0]  TEST_CTRL_3 = 0;
   reg [8:0]  TEST_CTRL_4 = 0;

//Multiplexing circuit below


always @ (posedge clk or negedge reset_n)
 begin
  if (~reset_n) 
    begin
   state <= 0;
    end
  else if (valid_scan_code != 0) 
    begin
   state <= next_state;
    end
 end

reg [7:0] sc1;
reg [7:0] sc2;
reg [7:0] sc3;
reg [7:0] sc4;

always @(posedge clk)
 begin
  
//only for sim
    if (~reset_n) 
    begin
    w_scan_codes = 32'b0;
    sc1 <= 8'b0;
    sc2 <= 8'b0;
    sc3 <= 8'b0;
    sc4 <= 8'b0;
    end

{sc4,sc3,sc2,sc1} <= w_scan_codes;


  case(state)
      
   1'b0 : 
    begin
        if (valid_scan_code && scan_code == 8'hF0)
        begin
            w_scan_codes = {sc3,sc2,sc1,8'b0};
            next_state <= 1;
        end else 
            begin 
            next_state <= 0;
            w_scan_codes = {sc4,sc3,sc2,sc1};
            end
    end
   
   1'b1:
    begin
        if (valid_scan_code && scan_code != 8'hF0)
        begin
            w_scan_codes = {sc4,sc3,sc2,{1'b0,scan_code[7:1]}};
            next_state <= 0;        
        end else 
            begin 
            next_state <= 1;
             w_scan_codes = {sc4,sc3,sc2,sc1};
            end
    end
  endcase
 end


   assign scan_codes = w_scan_codes;
   assign curr_state = TEST_CTRL_1;


endmodule
