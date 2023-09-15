module keyboard_ctrl
(input            clk,
 input            rst,
 input            valid_code,
 input [7:0]      scan_code_in,
 output reg [7:0] code_to_display,
 output reg [3:0] seg_en);

   reg state, next_state;
   reg [31:0] scanCodes;
   reg [1:0]  seg_counter;
   reg [17:0] counter;
   reg [17:0] state_counter, valid_counter;
   //reg [3:0] seg_en;
   //reg [7:0] code_to_display;

   // maybe add initial begin with rst to avoid latches
   // comment out not popular lines for a somewhat working keyboard

   always @ (posedge clk, negedge rst)
     if (~rst) begin
        state <= 0;
        next_state <= 0; //not popular
        scanCodes <= 0; //not popular
        counter <= 0;
        seg_counter <= 0;
        code_to_display <= scanCodes[31:24]; //vivado hates this line
        seg_en <= "1111"; //also not popular
        state_counter <= 0;
        valid_counter <= 0;
     end else if (counter == 4)begin
        counter <= 0;
        seg_counter <= seg_counter + 1;
        state <= next_state;
     end else begin
        counter <= counter + 1;
        state <= next_state;
     end

   always @(state, counter, valid_code, valid_counter)
     begin
        if (valid_code)begin
           case(state)
             0: begin
                if(scan_code_in == 240)begin
                   next_state <= 1;
                end else begin
                   //do nothin
                   valid_counter <= valid_counter + 1;
                end
             end
             1: begin
                if(scan_code_in == 240) begin
                   scanCodes = scanCodes << 8;
                end else if(scanCodes[31:24] == 0)begin
                   scanCodes[31:24] <= scan_code_in;
                end
             end
             default:begin
                //do nothing
                //valid_counter <= valid_counter + 1;
             end
           endcase
        end
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
