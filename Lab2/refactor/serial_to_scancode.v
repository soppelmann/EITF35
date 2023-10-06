module serial_to_scancode(
    input clk,
    input reset_n,
    input sample_ready,
    input serial_data,
    output wire valid_scan_code,
    output [7:0] scan_code
);

   reg [9:0] scan_code_int;
   reg [7:0] scan_code_d;
   reg [7:0] scan_code_dd; 

   reg [3:0] counter;
   reg valid_scan_code_d;
   reg valid_scan_code_dd;

   always @ (posedge clk)begin
   
   //if(valid_scan_code_dd == 1)begin 
   // valid_scan_code_dd <= 0;
   //end
   
   if (~reset_n) begin
    scan_code_int <= 0;
    scan_code_d <= 0;
    scan_code_dd <= 0;
    counter <= 0;
    //valid_scan_code_d <= 0;
   end else if(sample_ready && (counter == 10)) begin
    scan_code_int[7:0] <= scan_code_int[8:1];
    scan_code_int[8:0] <= scan_code_int[9:1];
    scan_code_int[9] <= serial_data;
    counter <= 0;
    valid_scan_code_d <= 1;
    valid_scan_code_dd <= valid_scan_code_d;
    

   end else if (sample_ready) begin
    scan_code_int[7:0] <= scan_code_int[8:1];
    scan_code_int[8:0] <= scan_code_int[9:1];
    scan_code_int[9] <= serial_data;
    counter <= counter + 1;
    valid_scan_code_d <= 0;
    valid_scan_code_dd <= valid_scan_code_d;
   end else begin
    //do nothing
   end
   scan_code_d <= scan_code_int[7:0]; 
   scan_code_dd <= scan_code_d;
end

assign scan_code = scan_code_dd;
assign valid_scan_code = valid_scan_code_d;

endmodule