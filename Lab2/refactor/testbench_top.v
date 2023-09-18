`timescale 1ns / 1ps


module testbench_top();
    localparam INPUT_FILE = "input.txt";

    localparam INIT = 3'b000;
    localparam SHIFT = 3'b001;
    localparam WAIT = 3'b010;
    localparam WAIT2 = 3'b011;
    localparam FINISH = 3'b100;

    localparam NUM_KEYS = 12;

    reg [2:0] state;

    reg [7:0] memory [0:NUM_KEYS-1]; // 8 bit memory with 16 entries
    integer memory_index = 0;

    reg clk = 1'b0;
    reg reset_n = 1'b0;

    reg clk_slow = 1'b0;
    reg clk_keyboard = 1'b1;
    reg data_keyboard = 1'b0;

    wire [7:0] scan_code_debug;
    wire [7:0] seven_segment_number;
    wire [7:0] seven_segment_enable;

    reg [32:0] key_all;
    reg start_shifting = 1'b0;
    integer bit_index = 0;


    keyboard_top inst_keyboard_top(
        .clk(clk),
        .reset_n(reset_n),
        .keyboard_clk(clk_keyboard),
        .keyboard_data(data_keyboard),
        .led_scancode_debug(scan_code_debug),
        .seven_segment_number(seven_segment_number),
        .seven_segment_enable(seven_segment_enable)
    );


    always #10 clk = ~clk;
    always #100 clk_slow = ~clk_slow;


    initial begin
        $readmemh(INPUT_FILE, memory);
           $dumpfile("test.vcd");
           $dumpvars(0,testbench_top);


        reset_n = 1'b0;
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        reset_n = 1'b1;
    end


    always @(posedge clk or negedge reset_n)
    begin
        if (!reset_n) begin
            data_keyboard <= 1'b0;
            key_all <= 0;
            memory_index <= 0;
            start_shifting <= 1'b0;
            bit_index <= 0;
            clk_keyboard <= 1'b1;
            state <= INIT;
        end else begin
            case (state)
                INIT:
                begin
                    key_all <= {1'b1, memory[memory_index], 2'b00, 1'b1, 8'hf0, 2'b00, 1'b1, memory[memory_index], 2'b00};
                    memory_index <= memory_index + 1;
                    state <= SHIFT;
                    bit_index <= 0;
                end

                SHIFT:
                begin
                    data_keyboard <= key_all[bit_index];
                    bit_index <= bit_index + 1;
                    state <= WAIT;
                end

                WAIT:
                begin
                    if (!clk_slow) begin
                        clk_keyboard <= 1'b0;
                        state <= WAIT2;
                    end
                end

                WAIT2:
                begin
                    if (clk_slow) begin
                        clk_keyboard <= 1'b1;
                        state <= SHIFT;
                        if (bit_index == 33) begin
                            state <= INIT;
                            if (memory_index == NUM_KEYS) begin
                                state <= FINISH;
                            end
                        end
                    end
                end

                FINISH:
                begin
                    $display("Finished!");
                   $finish;

                    $stop;
                end
            endcase
        end
    end


    always @(posedge clk_keyboard)
    begin
        if (bit_index == 10 & scan_code_debug != memory[memory_index-1]) begin
            $display("Failure!");
            $display("DUT Scan code = %x is not equal to expected = %x!", scan_code_debug, memory[memory_index-1]);
           //        $finish;
           // $stop;
        end
        else if (bit_index == 10 & scan_code_debug == memory[memory_index-1]) begin
            $display("Sucess!");
            $display("DUT Scan code = %x is equal to expected = %x!", scan_code_debug, memory[memory_index-1]);
           //        $finish;
           // $stop;
        end
    end

endmodule
