module serial_to_scancode(
    input clk,
    input reset_n,
    input sample_ready,
    input serial_data,
    output reg valid_scan_code,
    output reg [7:0] scan_code
);

   reg [9:0] scan_code_int;

   reg [3:0] counter;

   always @ (posedge clk, negedge reset_n)
   if (~reset_n) begin
    scan_code <= 0;
      scan_code_int <= 0;

    valid_scan_code <= 0;
    counter <= 0;
   end else if(sample_ready & (counter == 10)) begin
    scan_code[7:0] <= scan_code_int[8:1];
    scan_code_int[8:0] <= scan_code_int[9:1];
    scan_code_int[9] <= serial_data;
    counter <= 0;
    valid_scan_code <= 1;

   end else if (sample_ready) begin
    scan_code[7:0] <= scan_code_int[8:1];
    scan_code_int[8:0] <= scan_code_int[9:1];
    scan_code_int[9] <= serial_data;
    counter <= counter + 1;
    valid_scan_code <= 0;
   end else begin
    //do nothing
   end



endmodule
