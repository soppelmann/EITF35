module keyboard_ctrl (
                      input            clk,
                      input            rst,
                      input            valid_code,
                      input [7:0]      scan_code_in,
                      output reg [7:0] code_to_display,
                      output reg [3:0] seg_en
                      );

   reg state, next_state;
   reg [31:0] scanCodes;
   reg [ 1:0] seg_counter;






   // maybe add initial begin with rst to avoid latches
   // comment out not popular lines for a somewhat working keyboard



   always @(posedge clk, negedge rst)
     // Setup if reset
     if (~rst) begin
        state <= 0;
        next_state <= 0;  //not popular
        scanCodes <= 0;  //not popular
        seg_counter <= 0;

        code_to_display <= scanCodes[31:24];  //vivado hates this line
        seg_en <= "1111";  //also not popular


        //logic to loop through segment driver
     end else if (seg_counter == 2'b11) begin
        seg_counter <= 0;
        state <= next_state;

     end else begin
        seg_counter <= seg_counter + 1;
        //update state on every clock cycle
        state   <= next_state;
     end



// valid code looks at something,
   always @(next_state or valid_code or negedge valid_code) begin
      if (valid_code) begin
         case (state)
           0: begin
              if (scan_code_in == 240) begin //next scan code will be a make code and sent to the display
                 scanCodes = scanCodes << 8;
                 next_state <= 1;

              end
           end

           1: begin //only enter here if prev scan code was 240 == break
              scanCodes[7:0] <= scan_code_in;
              next_state <= 0;

           end
           default: begin
              //do nothing
           end
         endcase  // case (state)

      end  // if (valid_code)
      else if (~valid_code) begin
         // run immedately after a valid code has finished
         // good place to put scan_code_in to scan code buffer
         scanCodes[7:0] <= scan_code_in;

      end
      else begin
         next_state <= 0;

      end
   end







   // Block to send a scancode and flash one of the lights
   // then flash next light
   always @(clk) begin
      case (seg_counter)
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
        default: begin
           seg_en <= "0000";
           code_to_display <= scanCodes[7:0];
        end

      endcase  // case (seg_counter)
   end





endmodule
