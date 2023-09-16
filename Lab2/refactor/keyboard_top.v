module keyboard_top(
    input clk,
    input reset_n,
    input keyboard_clk,
    input keyboard_data,
    output [7:0] led_scancode_debug,
    output [7:0] seven_segment_number,
    output [7:0] seven_segment_enable
);

    wire keyboard_clk_synched;
    wire keyboard_data_synched;

    wire keyboard_clk_edge_found;

    wire valid_scan_code;
    wire [7:0] scan_code;
    wire [31:0] scan_codes;


   //Implemented
    synchronizer kb_clk_synchronizer(
        .clk(clk),
        .reset_n(reset_n),
        .unsynched(keyboard_clk),
        .synched(keyboard_clk_synched)
    );

    synchronizer kb_data_synchronizer(
        .clk(clk),
        .reset_n(reset_n),
        .unsynched(keyboard_data),
        .synched(keyboard_data_synched)
    );

   //Implemented
    falling_edge_detector kb_clk_edge_detector(
        .clk(clk),
        .reset_n(reset_n),
        .in(keyboard_clk_synched),
        .edge_found(keyboard_clk_edge_found)
    );

    serial_to_scancode serial_to_scancode_converter(
        .clk(clk),
        .reset_n(reset_n),
        .sample_ready(keyboard_clk_edge_found),
        .serial_data(keyboard_data_synched),
        .valid_scan_code(valid_scan_code),
        .scan_code(scan_code)
    );

    keyboard_controller inst_keyboard_controller(
        .clk(clk),
        .reset_n(reset_n),
        .valid_scan_code(valid_scan_code),
        .scan_code(scan_code),
        .scan_codes(scan_codes)
    );

    seven_segment_controller inst_seven_segment_controller(
        .clk(clk),
        .reset_n(reset_n),
        .scan_codes(scan_codes),
        .seven_segment_number(seven_segment_number),
        .seven_segment_enable(seven_segment_enable)
    );

    assign led_scancode_debug = scan_code;

endmodule
