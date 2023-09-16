/* Generated by Yosys 0.19+20 (git sha1 a82eff2e2, x86_64-conda-linux-gnu-cc 11.2.0 -fvisibility-inlines-hidden -fmessage-length=0 -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -fdebug-prefix-map=/home/runner/work/conda-eda/conda-eda/workdir/conda-env/conda-bld/yosys_1658304998991/work=/usr/local/src/conda/yosys-0.19_21_ga82eff2e2 -fdebug-prefix-map=/usr/local/envs/xc7=/usr/local/src/conda-prefix -fPIC -Os -fno-merge-constants) */

(* hdlname = "\\keyboard_top" *)
(* top =  1  *)
(* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:1.1-69.10" *)
module keyboard_top(clk, reset_n, keyboard_clk, keyboard_data, led_scancode_debug, seven_segment_number, seven_segment_enable);
  (* CLASS = "clock" *)
  (* CLOCK_SIGNAL = "yes" *)
  (* IS_PROPAGATED = 32'd1 *)
  (* NAME = "\\$iopadmap\\$clk" *)
  (* PERIOD = "10.000000" *)
  (* SOURCE_WIRES = "\\$iopadmap\\$clk" *)
  (* WAVEFORM = "0.000000 5.000000" *)
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire [7:0] _04_;
  wire [7:0] _05_;
  (* CLASS = "clock" *)
  (* CLOCK_SIGNAL = "yes" *)
  (* IS_EXPLICIT = 32'd1 *)
  (* NAME = "sys_clk_pin" *)
  (* PERIOD = "10.000000" *)
  (* SOURCE_WIRES = "clk" *)
  (* WAVEFORM = "0.000000 5.000000" *)
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:2.11-2.14" *)
  input clk;
  wire clk;
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:4.11-4.23" *)
  input keyboard_clk;
  wire keyboard_clk;
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:14.10-14.33" *)
  wire keyboard_clk_edge_found;
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:11.10-11.30" *)
  wire keyboard_clk_synched;
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:5.11-5.24" *)
  input keyboard_data;
  wire keyboard_data;
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:12.10-12.31" *)
  wire keyboard_data_synched;
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:6.18-6.36" *)
  output [7:0] led_scancode_debug;
  wire [7:0] led_scancode_debug;
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:3.11-3.18" *)
  input reset_n;
  wire reset_n;
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:17.16-17.25" *)
  wire [7:0] scan_code;
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:18.17-18.27" *)
  wire [31:0] scan_codes;
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:8.18-8.38" *)
  output [7:0] seven_segment_enable;
  wire [7:0] seven_segment_enable;
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:7.18-7.38" *)
  output [7:0] seven_segment_number;
  wire [7:0] seven_segment_number;
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:16.10-16.25" *)
  wire valid_scan_code;
  (* keep = 32'd1 *)
  IBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("clk:E3")
  ) _06_ (
    .I(clk),
    .O(_00_)
  );
  (* keep = 32'd1 *)
  IBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("keyboard_clk:F4")
  ) _07_ (
    .I(keyboard_clk),
    .O(_01_)
  );
  (* keep = 32'd1 *)
  IBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("keyboard_data:B2")
  ) _08_ (
    .I(keyboard_data),
    .O(_02_)
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("led_scancode_debug[0]:T8")
  ) _09_ (
    .I(scan_code[0]),
    .O(led_scancode_debug[0])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("led_scancode_debug[1]:V9")
  ) _10_ (
    .I(scan_code[1]),
    .O(led_scancode_debug[1])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("led_scancode_debug[2]:R8")
  ) _11_ (
    .I(scan_code[2]),
    .O(led_scancode_debug[2])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("led_scancode_debug[3]:T6")
  ) _12_ (
    .I(scan_code[3]),
    .O(led_scancode_debug[3])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("led_scancode_debug[4]:T5")
  ) _13_ (
    .I(scan_code[4]),
    .O(led_scancode_debug[4])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("led_scancode_debug[5]:T4")
  ) _14_ (
    .I(scan_code[5]),
    .O(led_scancode_debug[5])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("led_scancode_debug[6]:U7")
  ) _15_ (
    .I(scan_code[6]),
    .O(led_scancode_debug[6])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("led_scancode_debug[7]:U6")
  ) _16_ (
    .I(scan_code[7]),
    .O(led_scancode_debug[7])
  );
  (* keep = 32'd1 *)
  IBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("reset_n:C12")
  ) _17_ (
    .I(reset_n),
    .O(_03_)
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_enable[0]:N6")
  ) _18_ (
    .I(_04_[0]),
    .O(seven_segment_enable[0])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_enable[1]:M6")
  ) _19_ (
    .I(_04_[1]),
    .O(seven_segment_enable[1])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_enable[2]:M3")
  ) _20_ (
    .I(_04_[2]),
    .O(seven_segment_enable[2])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_enable[3]:N5")
  ) _21_ (
    .I(_04_[3]),
    .O(seven_segment_enable[3])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_enable[4]:N2")
  ) _22_ (
    .I(_04_[4]),
    .O(seven_segment_enable[4])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_enable[5]:N4")
  ) _23_ (
    .I(_04_[5]),
    .O(seven_segment_enable[5])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_enable[6]:L1")
  ) _24_ (
    .I(_04_[6]),
    .O(seven_segment_enable[6])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_enable[7]:M1")
  ) _25_ (
    .I(_04_[7]),
    .O(seven_segment_enable[7])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_number[0]:L3")
  ) _26_ (
    .I(_05_[0]),
    .O(seven_segment_number[0])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_number[1]:N1")
  ) _27_ (
    .I(_05_[1]),
    .O(seven_segment_number[1])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_number[2]:L5")
  ) _28_ (
    .I(_05_[2]),
    .O(seven_segment_number[2])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_number[3]:L4")
  ) _29_ (
    .I(_05_[3]),
    .O(seven_segment_number[3])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_number[4]:K3")
  ) _30_ (
    .I(_05_[4]),
    .O(seven_segment_number[4])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_number[5]:M2")
  ) _31_ (
    .I(_05_[5]),
    .O(seven_segment_number[5])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_number[6]:L6")
  ) _32_ (
    .I(_05_[6]),
    .O(seven_segment_number[6])
  );
  (* keep = 32'd1 *)
  OBUF #(
    .IOSTANDARD("LVCMOS33"),
    .IO_LOC_PAIRS("seven_segment_number[7]:M4")
  ) _33_ (
    .I(_05_[7]),
    .O(seven_segment_number[7])
  );
  (* module_not_derived = 32'd1 *)
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:51.25-57.6" *)
  keyboard_controller inst_keyboard_controller (
    .clk(_00_),
    .reset_n(_03_),
    .scan_code(scan_code),
    .scan_codes(scan_codes),
    .valid_scan_code(valid_scan_code)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:59.30-65.6" *)
  seven_segment_controller inst_seven_segment_controller (
    .clk(_00_),
    .reset_n(_03_),
    .scan_codes(scan_codes),
    .seven_segment_enable(_04_),
    .seven_segment_number(_05_)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:35.27-40.6" *)
  falling_edge_detector kb_clk_edge_detector (
    .clk(_00_),
    .edge_found(keyboard_clk_edge_found),
    .in(keyboard_clk_synched),
    .reset_n(_03_)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:21.18-26.6" *)
  synchronizer kb_clk_synchronizer (
    .clk(_00_),
    .reset_n(_03_),
    .synched(keyboard_clk_synched),
    .unsynched(_01_)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:28.18-33.6" *)
  synchronizer kb_data_synchronizer (
    .clk(_00_),
    .reset_n(_03_),
    .synched(keyboard_data_synched),
    .unsynched(_02_)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "/mnt/EITF35/Lab2/refactor/keyboard_top.v:42.24-49.6" *)
  serial_to_scancode serial_to_scancode_converter (
    .clk(_00_),
    .reset_n(_03_),
    .sample_ready(keyboard_clk_edge_found),
    .scan_code(scan_code),
    .serial_data(keyboard_data_synched),
    .valid_scan_code(valid_scan_code)
  );
endmodule
