module convert_scancode(
    input clk,
    input rst,
    input edge_found,
    input serial_data,
    output reg valid_scan_code,
    output reg [7:0] scan_code_out
);

reg [3:0] counter = 4'b0000;
reg [3:0] next_counter = 4'b0000;

always @(posedge clk or negedge rst) begin
    if (~rst) begin
        counter <= 4'b0000;
       scan_code_out <= 0;

    end else if (edge_found) begin
        counter <= next_counter;
    end
end

always @(counter) begin
    scan_code_out[6:0] <= scan_code_out[7:1];
    scan_code_out[7] <= serial_data;
    valid_scan_code = 1'b0;
    if (counter == 4'b1001) begin // might need to tweak this to 4'b1000
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
