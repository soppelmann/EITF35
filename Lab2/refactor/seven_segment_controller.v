
module seven_segment_controller(
    input clk,
    input reset_n,
    input [31:0] scan_codes,
    output reg [7:0] seven_segment_number,
    output reg [7:0] seven_segment_enable
);


localparam SCAN_CODE_0 = 8'h45;
localparam SCAN_CODE_1 = 8'h16;
localparam SCAN_CODE_2 = 8'h1e;
localparam SCAN_CODE_3 = 8'h26;
localparam SCAN_CODE_4 = 8'h25;
localparam SCAN_CODE_5 = 8'h2e;
localparam SCAN_CODE_6 = 8'h36;
localparam SCAN_CODE_7 = 8'h3d;
localparam SCAN_CODE_8 = 8'h3e;
localparam SCAN_CODE_9 = 8'h46;
localparam SCAN_CODE_RESET = 8'h0;

localparam SEVEN_SEGMENT_0 = 8'b1100_0000;
localparam SEVEN_SEGMENT_1 = 8'b1111_1001;
localparam SEVEN_SEGMENT_2 = 8'b1010_0100;
localparam SEVEN_SEGMENT_3 = 8'b1011_0000;
localparam SEVEN_SEGMENT_4 = 8'b1001_1001;
localparam SEVEN_SEGMENT_5 = 8'b1001_0010;
localparam SEVEN_SEGMENT_6 = 8'b1000_0010;
localparam SEVEN_SEGMENT_7 = 8'b1111_1000;
localparam SEVEN_SEGMENT_8 = 8'b1000_0000;
localparam SEVEN_SEGMENT_9 = 8'b1001_0000;
localparam SEVEN_SEGMENT_F = 8'b1000_1110;
localparam SEVEN_SEGMENT_EMPTY = 8'b1111_1111;






endmodule
