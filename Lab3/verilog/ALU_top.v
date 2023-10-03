module ALU_top(
               input        clk,
               input        rst_n,
               input        b_enter,
               input        b_sign,
               input [7:0]  sw_in,
               output [7:0] sev_seg,
               output [7:0] anode
               );


   wire d_enter;
   wire d_sign;
   wire w_sign;
   wire w_overflow;
   wire [9:0] w_bcd_digit;
   wire [1:0] w_reg_ctrl;
   wire [3:0] w_func;
   wire [7:0] w_result;
   wire [7:0] A,B;



   // .modport(topport)
   debouncer enter_debouncer(
                             // Inputs
                             .clk        (clk),
                             .rst_n      (rst_n),
                             .button_in  (b_enter),
                             // Outputs
                             .button_out (d_enter)
                             );

   debouncer sign_debouncer(
                            // Inputs
                            .clk        (clk),
                            .rst_n      (rst_n),
                            .button_in  (b_sign),
                            // Outputs
                            .button_out (d_sign)
                            );

   ALU_ctrl I_ALU_CTRL(
                       // Inputs
                       .clk      (clk),
                       .rst_n    (rst_n),
                       .enter    (b_enter), //d_enter for IRL
                       .sign     (b_sign), //b_enter for SIM
                       // Outputs
                       .func     (w_func),
                       .reg_ctrl (w_reg_ctrl)
                       );

   reg_updater I_REG_UPDATER(
                             // Inputs
                             .clk      (clk),
                             .rst_n    (rst_n),
                             .reg_ctrl (w_reg_ctrl),
                             .sw_input (sw_in),
                             // Outputs
                             .A        (A),
                             .B        (B)
                             );

   ALU I_ALU (
              // Inputs
              .A        (A),
              .B        (B),
              .FN       (w_func),
              // Outputs
              .result   (w_result),
              .overflow (w_overflow),
              .sign     (w_sign)
              );


   binary_to_bcd I_BINARY_TO_BCD (
                                  // Inputs
                                  .binary_in (w_result),
                                  // Outputs
                                  .bcd_out   (w_bcd_digit)
                                  );


   seven_segment_driver I_SEVEN_SEGMENT_DRIVER (
                                                // Inputs
                                                .clk         (clk),
                                                .rst_n       (rst_n),
                                                .BCD_digit   (w_bcd_digit),
                                                .sign        (w_sign),
                                                .overflow    (w_overflow),
                                                // Outputs
                                                .digit_anode (anode),
                                                .segment     (sev_seg)
                                                );





endmodule
