# File saved with Nlview 7.0.21  2019-05-29 bk=1.5064 VDI=41 GEI=36 GUI=JA:9.0 TLS
# 
# non-default properties - (restore without -noprops)
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 12
property maxzoom 5
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #ff6666
property objecthighlight4 #0000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #eb591b
property overlapcolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 8
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 12
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 4
property timelimit 1
#
module new tb_pkg work:tb_pkg:NOFILE -nosplit
load symbol keyboard_top work:keyboard_top:NOFILE HIERBOX pin clk input.left pin kb_clk input.left pin kb_data input.left pin rst input.left pinBus num output.right [7:0] pinBus sc output.right [7:0] pinBus seg_en output.right [3:0] pinBus sev_seg output.right [7:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol RTL_INV0 work INV pin I0 input pin O output fillcolor 1
load symbol binary_to_sg work:binary_to_sg:NOFILE HIERBOX pinBus binary_in input.left [3:0] pinBus sev_seg output.right [7:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol convert_scancode work:convert_scancode:NOFILE HIERBOX pin clk input.left pin edge_found input.left pin rst input.left pin serial_data input.left pin valid_scan_code output.right pinBus scan_code_out output.right [7:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol convert_to_binary work:convert_to_binary:NOFILE HIERBOX pinBus binary_out output.right [3:0] pinBus scan_code_in input.left [7:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol edge_detector work:edge_detector:NOFILE HIERBOX pin clk input.left pin edge_found output.right pin kb_clk_sync input.left pin rst input.left boxcolor 1 fillcolor 2 minwidth 13%
load symbol keyboard_ctrl work:keyboard_ctrl:NOFILE HIERBOX pin clk input.left pin rst input.left pin valid_code input.left pinBus code_to_display output.right [7:0] pinBus scan_code_in input.left [7:0] pinBus seg_en output.right [3:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol sync_keyboard work:sync_keyboard:NOFILE HIERBOX pin clk input.left pin kb_clk input.left pin kb_clk_sync output.right pin kb_data input.left pin kb_data_sync output.right boxcolor 1 fillcolor 2 minwidth 13%
load inst DUT keyboard_top work:keyboard_top:NOFILE -autohide -attr @cell(#000000) keyboard_top -attr @fillcolor #fafafa -pinBusAttr num @name num[7:0] -pinBusAttr num @attr n/c -pinBusAttr sc @name sc[7:0] -pinBusAttr sc @attr n/c -pinBusAttr seg_en @name seg_en[3:0] -pinBusAttr seg_en @attr n/c -pinBusAttr sev_seg @name sev_seg[7:0] -pinBusAttr sev_seg @attr n/c -pg 1 -lvl 2 -x 320 -y 84
load inst RTL_INV RTL_INV0 work -attr @cell(#000000) RTL_INV -pg 1 -lvl 1 -x 70 -y 40
load inst RTL_INV__0 RTL_INV0 work -attr @cell(#000000) RTL_INV -pg 1 -lvl 1 -x 70 -y 120
load inst DUT|binary_to_sg_inst binary_to_sg work:binary_to_sg:NOFILE -hier DUT -autohide -attr @cell(#000000) binary_to_sg -attr @name binary_to_sg_inst -pinBusAttr binary_in @name binary_in[3:0] -pinBusAttr sev_seg @name sev_seg[7:0] -pg 1 -lvl 4 -x 1490 -y 314
load inst DUT|convert_scancode_inst convert_scancode work:convert_scancode:NOFILE -hier DUT -autohide -attr @cell(#000000) convert_scancode -attr @name convert_scancode_inst -pinBusAttr scan_code_out @name scan_code_out[7:0] -pg 1 -lvl 3 -x 1110 -y 154
load inst DUT|convert_to_binary_inst convert_to_binary work:convert_to_binary:NOFILE -hier DUT -autohide -attr @cell(#000000) convert_to_binary -attr @name convert_to_binary_inst -pinBusAttr binary_out @name binary_out[3:0] -pinBusAttr scan_code_in @name scan_code_in[7:0] -pg 1 -lvl 3 -x 1110 -y 314
load inst DUT|edge_detector_inst edge_detector work:edge_detector:NOFILE -hier DUT -autohide -attr @cell(#000000) edge_detector -attr @name edge_detector_inst -pg 1 -lvl 2 -x 750 -y 114
load inst DUT|keyboard_ctrl_inst keyboard_ctrl work:keyboard_ctrl:NOFILE -hier DUT -autohide -attr @cell(#000000) keyboard_ctrl -attr @name keyboard_ctrl_inst -pinBusAttr code_to_display @name code_to_display[7:0] -pinBusAttr scan_code_in @name scan_code_in[7:0] -pinBusAttr seg_en @name seg_en[3:0] -pg 1 -lvl 4 -x 1490 -y 134
load inst DUT|sync_keyboard_inst sync_keyboard work:sync_keyboard:NOFILE -hier DUT -autohide -attr @cell(#000000) sync_keyboard -attr @name sync_keyboard_inst -pg 1 -lvl 1 -x 440 -y 134
load net <const0> -ground -pin DUT kb_data
load net <const1> -power -pin DUT rst
load net clk_reg -pin DUT clk -pin RTL_INV I0 -pin RTL_INV O
netloc clk_reg 1 0 2 20 80 190
load net kb_clk_reg -pin DUT kb_clk -pin RTL_INV__0 I0 -pin RTL_INV__0 O
netloc kb_clk_reg 1 0 2 20 160 190
load net DUT|binary_in[0] -attr @rip(#000000) binary_out[0] -attr @name binary_in[0] -pin DUT|binary_to_sg_inst binary_in[0] -pin DUT|convert_to_binary_inst binary_out[0]
load net DUT|binary_in[1] -attr @rip(#000000) binary_out[1] -attr @name binary_in[1] -pin DUT|binary_to_sg_inst binary_in[1] -pin DUT|convert_to_binary_inst binary_out[1]
load net DUT|binary_in[2] -attr @rip(#000000) binary_out[2] -attr @name binary_in[2] -pin DUT|binary_to_sg_inst binary_in[2] -pin DUT|convert_to_binary_inst binary_out[2]
load net DUT|binary_in[3] -attr @rip(#000000) binary_out[3] -attr @name binary_in[3] -pin DUT|binary_to_sg_inst binary_in[3] -pin DUT|convert_to_binary_inst binary_out[3]
load net DUT|clk -attr @name clk -hierPin DUT clk -pin DUT|convert_scancode_inst clk -pin DUT|edge_detector_inst clk -pin DUT|keyboard_ctrl_inst clk -pin DUT|sync_keyboard_inst clk
netloc DUT|clk 1 0 4 350 84 620 64 960 84 1340
load net DUT|code_to_display[0] -attr @rip(#000000) code_to_display[0] -attr @name code_to_display[0] -pin DUT|convert_to_binary_inst scan_code_in[0] -pin DUT|keyboard_ctrl_inst code_to_display[0]
load net DUT|code_to_display[1] -attr @rip(#000000) code_to_display[1] -attr @name code_to_display[1] -pin DUT|convert_to_binary_inst scan_code_in[1] -pin DUT|keyboard_ctrl_inst code_to_display[1]
load net DUT|code_to_display[2] -attr @rip(#000000) code_to_display[2] -attr @name code_to_display[2] -pin DUT|convert_to_binary_inst scan_code_in[2] -pin DUT|keyboard_ctrl_inst code_to_display[2]
load net DUT|code_to_display[3] -attr @rip(#000000) code_to_display[3] -attr @name code_to_display[3] -pin DUT|convert_to_binary_inst scan_code_in[3] -pin DUT|keyboard_ctrl_inst code_to_display[3]
load net DUT|code_to_display[4] -attr @rip(#000000) code_to_display[4] -attr @name code_to_display[4] -pin DUT|convert_to_binary_inst scan_code_in[4] -pin DUT|keyboard_ctrl_inst code_to_display[4]
load net DUT|code_to_display[5] -attr @rip(#000000) code_to_display[5] -attr @name code_to_display[5] -pin DUT|convert_to_binary_inst scan_code_in[5] -pin DUT|keyboard_ctrl_inst code_to_display[5]
load net DUT|code_to_display[6] -attr @rip(#000000) code_to_display[6] -attr @name code_to_display[6] -pin DUT|convert_to_binary_inst scan_code_in[6] -pin DUT|keyboard_ctrl_inst code_to_display[6]
load net DUT|code_to_display[7] -attr @rip(#000000) code_to_display[7] -attr @name code_to_display[7] -pin DUT|convert_to_binary_inst scan_code_in[7] -pin DUT|keyboard_ctrl_inst code_to_display[7]
load net DUT|edge_found -attr @name edge_found -pin DUT|convert_scancode_inst edge_found -pin DUT|edge_detector_inst edge_found
netloc DUT|edge_found 1 2 1 920 144n
load net DUT|kb_clk -attr @name kb_clk -hierPin DUT kb_clk -pin DUT|sync_keyboard_inst kb_clk
netloc DUT|kb_clk 1 0 1 N 164
load net DUT|kb_clk_sync -attr @name kb_clk_sync -pin DUT|edge_detector_inst kb_clk_sync -pin DUT|sync_keyboard_inst kb_clk_sync
netloc DUT|kb_clk_sync 1 1 1 N 144
load net DUT|kb_data -attr @name kb_data -hierPin DUT kb_data -pin DUT|sync_keyboard_inst kb_data
netloc DUT|kb_data 1 0 1 N 184
load net DUT|kb_data_sync -attr @name kb_data_sync -pin DUT|convert_scancode_inst serial_data -pin DUT|sync_keyboard_inst kb_data_sync
netloc DUT|kb_data_sync 1 1 2 620 224 NJ
load net DUT|rst -attr @name rst -hierPin DUT rst -pin DUT|convert_scancode_inst rst -pin DUT|edge_detector_inst rst -pin DUT|keyboard_ctrl_inst rst
netloc DUT|rst 1 0 4 NJ 224 640 204 940 104 1320
load net DUT|scan_code_out[0] -attr @rip(#000000) scan_code_out[0] -attr @name scan_code_out[0] -pin DUT|convert_scancode_inst scan_code_out[0] -pin DUT|keyboard_ctrl_inst scan_code_in[0]
load net DUT|scan_code_out[1] -attr @rip(#000000) scan_code_out[1] -attr @name scan_code_out[1] -pin DUT|convert_scancode_inst scan_code_out[1] -pin DUT|keyboard_ctrl_inst scan_code_in[1]
load net DUT|scan_code_out[2] -attr @rip(#000000) scan_code_out[2] -attr @name scan_code_out[2] -pin DUT|convert_scancode_inst scan_code_out[2] -pin DUT|keyboard_ctrl_inst scan_code_in[2]
load net DUT|scan_code_out[3] -attr @rip(#000000) scan_code_out[3] -attr @name scan_code_out[3] -pin DUT|convert_scancode_inst scan_code_out[3] -pin DUT|keyboard_ctrl_inst scan_code_in[3]
load net DUT|scan_code_out[4] -attr @rip(#000000) scan_code_out[4] -attr @name scan_code_out[4] -pin DUT|convert_scancode_inst scan_code_out[4] -pin DUT|keyboard_ctrl_inst scan_code_in[4]
load net DUT|scan_code_out[5] -attr @rip(#000000) scan_code_out[5] -attr @name scan_code_out[5] -pin DUT|convert_scancode_inst scan_code_out[5] -pin DUT|keyboard_ctrl_inst scan_code_in[5]
load net DUT|scan_code_out[6] -attr @rip(#000000) scan_code_out[6] -attr @name scan_code_out[6] -pin DUT|convert_scancode_inst scan_code_out[6] -pin DUT|keyboard_ctrl_inst scan_code_in[6]
load net DUT|scan_code_out[7] -attr @rip(#000000) scan_code_out[7] -attr @name scan_code_out[7] -pin DUT|convert_scancode_inst scan_code_out[7] -pin DUT|keyboard_ctrl_inst scan_code_in[7]
load net DUT|seg_en[0] -attr @rip(#000000) seg_en[0] -attr @name seg_en[0] -hierPin DUT seg_en[0] -pin DUT|keyboard_ctrl_inst seg_en[0]
load net DUT|seg_en[1] -attr @rip(#000000) seg_en[1] -attr @name seg_en[1] -hierPin DUT seg_en[1] -pin DUT|keyboard_ctrl_inst seg_en[1]
load net DUT|seg_en[2] -attr @rip(#000000) seg_en[2] -attr @name seg_en[2] -hierPin DUT seg_en[2] -pin DUT|keyboard_ctrl_inst seg_en[2]
load net DUT|seg_en[3] -attr @rip(#000000) seg_en[3] -attr @name seg_en[3] -hierPin DUT seg_en[3] -pin DUT|keyboard_ctrl_inst seg_en[3]
load net DUT|sev_seg[0] -attr @rip(#000000) sev_seg[0] -attr @name sev_seg[0] -hierPin DUT sev_seg[0] -pin DUT|binary_to_sg_inst sev_seg[0]
load net DUT|sev_seg[1] -attr @rip(#000000) sev_seg[1] -attr @name sev_seg[1] -hierPin DUT sev_seg[1] -pin DUT|binary_to_sg_inst sev_seg[1]
load net DUT|sev_seg[2] -attr @rip(#000000) sev_seg[2] -attr @name sev_seg[2] -hierPin DUT sev_seg[2] -pin DUT|binary_to_sg_inst sev_seg[2]
load net DUT|sev_seg[3] -attr @rip(#000000) sev_seg[3] -attr @name sev_seg[3] -hierPin DUT sev_seg[3] -pin DUT|binary_to_sg_inst sev_seg[3]
load net DUT|sev_seg[4] -attr @rip(#000000) sev_seg[4] -attr @name sev_seg[4] -hierPin DUT sev_seg[4] -pin DUT|binary_to_sg_inst sev_seg[4]
load net DUT|sev_seg[5] -attr @rip(#000000) sev_seg[5] -attr @name sev_seg[5] -hierPin DUT sev_seg[5] -pin DUT|binary_to_sg_inst sev_seg[5]
load net DUT|sev_seg[6] -attr @rip(#000000) sev_seg[6] -attr @name sev_seg[6] -hierPin DUT sev_seg[6] -pin DUT|binary_to_sg_inst sev_seg[6]
load net DUT|sev_seg[7] -attr @rip(#000000) sev_seg[7] -attr @name sev_seg[7] -hierPin DUT sev_seg[7] -pin DUT|binary_to_sg_inst sev_seg[7]
load net DUT|valid_scan_code -attr @name valid_scan_code -pin DUT|convert_scancode_inst valid_scan_code -pin DUT|keyboard_ctrl_inst valid_code
netloc DUT|valid_scan_code 1 3 1 N 204
load netBundle @DUT|sev_seg 8 DUT|sev_seg[7] DUT|sev_seg[6] DUT|sev_seg[5] DUT|sev_seg[4] DUT|sev_seg[3] DUT|sev_seg[2] DUT|sev_seg[1] DUT|sev_seg[0] -autobundled
netbloc @DUT|sev_seg 1 4 1 NJ 324
load netBundle @DUT|scan_code_out 8 DUT|scan_code_out[7] DUT|scan_code_out[6] DUT|scan_code_out[5] DUT|scan_code_out[4] DUT|scan_code_out[3] DUT|scan_code_out[2] DUT|scan_code_out[1] DUT|scan_code_out[0] -autobundled
netbloc @DUT|scan_code_out 1 3 1 N 184
load netBundle @DUT|binary_in 4 DUT|binary_in[3] DUT|binary_in[2] DUT|binary_in[1] DUT|binary_in[0] -autobundled
netbloc @DUT|binary_in 1 3 1 NJ 324
load netBundle @DUT|code_to_display 8 DUT|code_to_display[7] DUT|code_to_display[6] DUT|code_to_display[5] DUT|code_to_display[4] DUT|code_to_display[3] DUT|code_to_display[2] DUT|code_to_display[1] DUT|code_to_display[0] -autobundled
netbloc @DUT|code_to_display 1 2 3 940 264 NJ 264 1710
load netBundle @DUT|seg_en 4 DUT|seg_en[3] DUT|seg_en[2] DUT|seg_en[1] DUT|seg_en[0] -autobundled
netbloc @DUT|seg_en 1 4 1 N 184
levelinfo -pg 1 0 70 320 1870
levelinfo -hier DUT * 440 750 1110 1490 *
pagesize -pg 1 -db -bbox -sgen 0 0 1870 420
pagesize -hier DUT -db -bbox -sgen 320 54 1740 364
show
zoom 0.690476
scrollpos 130 -295
#
# initialize ictrl to current module tb_pkg work:tb_pkg:NOFILE
ictrl init topinfo |
