module ALU_top(
               input        clk,
               input        rst_n,
               input        b_enter,
               input        b_sign,
               input [7:0]  sw_in,
               output [6:0] sev_seg,
               output [3:0] anode
               );


   //TODO: currently wrong sizes

   wire d_enter;
   wire d_sign;
   wire w_reg_ctrl;
   wire w_func;
   wire w_sign;
   wire w_overflow;
   wire w_result;
   wire w_bcd_digit;

   wire [7:0] A,B;



   // .modport(topport)
   debouncer enter_debouncer(
                             .clk(clk),
                             .rst_n(rst_n),
                             .button_in(b_enter),
                             .button_out(d_enter)
                             );

   debouncer sign_debouncer(
                            .clk(clk),
                            .rst_n(rst_n),
                            .button_in(b_sign),
                            .button_out(d_sign)
                            );

   ALU_ctrl I_ALU_CTRL(
                       .clk(clk),
                       .rst_n(rst_n),
                       .enter(d_enter),
                       .sign(d_sign),
                       .func(w_func),
                       .reg_ctrl(w_reg_ctrl)
                       );

   reg_updater I_REG_UPDATER(
                             .clk(clk),
                             .rst_n(rst_n),
                             .reg_ctrl(w_reg_ctrl),
                             .A(A),
                             .B (B)
                             );

   ALU I_ALU (
              // Outputs
              .result   (w_result),
              .overflow (w_overflow),
              .sign     (w_sign),
              // Inputs
              .A        (A),
              .B        (B),
              .FN       (w_func)
              );


   binary_to_bcd I_BINARY_TO_BCD (
                                  // Outputs
                                  .bcd_out   (w_bcd_digit),
                                  // Inputs
                                  .binary_in (w_result)
                                  );


   seven_segment_driver I_SEVEN_SEGMENT_DRIVER (
                                                // Outputs
                                                .digit_anode (anode),
                                                .segment     (sev_seg),
                                                // Inputs
                                                .clk         (clk),
                                                .rst_n       (rst_n),
                                                .BCD_digit   (w_bcd_digit),
                                                .sign        (w_sign),
                                                .overflow    (w_overflow)
                                                );





endmodule
