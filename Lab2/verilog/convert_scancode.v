module convert_scancode
  (input  clk,
   input  rst,
   input  edge_found,
   input  serial_data,
   output valid_scan_code,
   output [7:0] scan_code_out);

   reg [9:0] scan_code;
   reg [7:0] scan_code_out;
   reg valid_scan_code;

   reg [3:0] current_counter, next_counter;

   always @ (posedge clk, negedge rst)
   if (~rst) begin
    scan_code_out <= 0;
    valid_scan_code <= 0;
    current_counter <= 0;
    next_counter <= 0;
   end else if(edge_found & (current_counter == "1010")) begin
    scan_code[8:0] <= scan_code[9:1];
    scan_code[9] <= serial_data;
    scan_code_out[7:0] <= scan_code[7:0];
    next_counter <= "0000";
    valid_scan_code <= 1;

   end else if (edge_found) begin
    scan_code[8:0] <= scan_code[9:1];
    scan_code[9] <= serial_data;
    scan_code_out[7:0] <= scan_code[7:0];
    next_counter <= current_counter + 1;
    valid_scan_code <= 0;
   end else begin
    //do nothing
   end

endmodule
