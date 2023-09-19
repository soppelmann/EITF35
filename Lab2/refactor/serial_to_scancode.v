module serial_to_scancode(
    input clk,
    input reset_n,
    input sample_ready,
    input serial_data,
    output reg valid_scan_code,
    output reg [7:0] scan_code
);


reg [3:0] counter = 4'b0000;
reg [3:0] next_counter = 4'b0000;

always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
        counter <= 4'b0000;
       //scan_code <= 0;

    end else if (sample_ready) begin
        counter <= next_counter;
    end
end

always @(counter) begin
    scan_code[6:0] <= scan_code[7:1];
    scan_code[7] <= serial_data;
    valid_scan_code = 1'b0;
    if (counter == 4'b1010) begin
        valid_scan_code = 1'b1;
    end
end

always @(counter) begin
    next_counter = counter + 1;
    if (counter == 4'b1010) begin
        next_counter = 4'b0000;
    end
end


endmodule
