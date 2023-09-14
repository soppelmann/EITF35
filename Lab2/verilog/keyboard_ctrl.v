module keyboard_ctrl
(input            clk,
 input            rst,
 input            valid_code,
 input [7:0]      scan_code_in,
 output reg[7:0] code_to_display,
 output reg [3:0] seg_en);

reg [2:0] state, next_state;
reg [31:0] scanCodes;
reg [1:0] seg_counter;
reg [17:0] counter;
//reg [3:0] seg_en;
//reg [7:0] code_to_display;

   always @ (posedge clk, negedge rst)
     if (~rst) begin
        state <= 0;
        next_state <= 0;
        scanCodes <= 0;
        counter <= 0;
        seg_counter <= 0;
     end else if (counter == "11111111111111110")begin
        counter <= 0;
        seg_counter <= seg_counter + 1;
     end else begin
        counter <= counter + 1;
        state <= next_state;
     end

always @(state)
if (valid_code)begin
case(state)
  0: 
    if(scan_code_in == "11110000")begin
      next_state <= 1;
      
    end else begin
      //do nothin
    end
  1: 
    if(scan_code_in == "11110000") begin
      next_state <= 2;
      scanCodes = scanCodes << 8;
      
    end else if(scanCodes[31:24] == "00000000")begin 
      scanCodes[31:24] <= scan_code_in;
    end
  2: if(scan_code_in == "11110000") begin
      next_state <= 3;
      scanCodes = scanCodes << 8;
      
      end else if(scanCodes[31:24] == "00000000")begin 
      scanCodes[31:24] <= scan_code_in;
      end
  3: if(scan_code_in == "11110000") begin
      next_state <= 4;
      scanCodes = scanCodes << 8;
      end else if(scanCodes[31:24] == "00000000")begin 
      scanCodes[31:24] <= scan_code_in;
      end
  4: if(scan_code_in == "11110000") begin
      scanCodes = scanCodes << 8;
      end else if(scanCodes[31:24] == "00000000")begin 
      scanCodes[31:24] <= scan_code_in;
      end
  default:begin
    //do nothing
  end
endcase
end 

   always @ (seg_counter)
     begin
        case(seg_counter)
          0: begin
             seg_en <= "1110";
             code_to_display <= scanCodes[31:24];
          end
          1: begin
             seg_en <= "1101";
             code_to_display <= scanCodes[23:16];
          end
          2: begin
             seg_en <= "1011";
             code_to_display <= scanCodes[15:8];
          end
          3: begin
             seg_en <= "0111";
             code_to_display <= scanCodes[7:0];
          end
        endcase
     end

endmodule
