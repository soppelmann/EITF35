module convert_scancode
  (input            clk,
   input            rst,
   input            edge_found,
   input            serial_data,
   output reg       valid_scan_code,
   output reg [7:0] scan_code_out);

   reg [9:0] scan_code = 0;

   reg [3:0] counter;

   always @ (posedge clk or negedge rst)
     if (~rst) begin
        scan_code_out <= 0;
        valid_scan_code <= 0;
        counter <= 0;
     end else if(edge_found & (counter == 12)) begin
        // this can cause glitches because same priority
        scan_code[9:1] <= scan_code[8:0];
        scan_code[0] <= serial_data;
        scan_code_out[7:0] <= scan_code[9:2];
        counter <= 0;
        valid_scan_code <= 1; //send valid scan code if F0

     end else if (edge_found) begin
        scan_code[9:1] <= scan_code[8:0];
        scan_code[0] <= serial_data;
        scan_code_out[7:0] <= scan_code[9:2];
        counter <= counter + 1;
        valid_scan_code <= 0;
     end else begin
        //do nothing
     end

endmodule
