## This file is a general .xdc for the Nexys4 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
##Bank = 35, Pin name = IO_L12P_T1_MRCC_35,					Sch name = CLK100MHZ
set_property PACKAGE_PIN E3 [get_ports clk]
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Switches
##Bank = 34, Pin name = IO_L21P_T3_DQS_34,					Sch name = SW0
set_property PACKAGE_PIN U9 [get_ports {sw_in[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw_in[0]}]
##Bank = 34, Pin name = IO_25_34,							Sch name = SW1
set_property PACKAGE_PIN U8 [get_ports {sw_in[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw_in[1]}]
##Bank = 34, Pin name = IO_L23P_T3_34,						Sch name = SW2
set_property PACKAGE_PIN R7 [get_ports {sw_in[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw_in[2]}]
##Bank = 34, Pin name = IO_L19P_T3_34,						Sch name = SW3
set_property PACKAGE_PIN R6 [get_ports {sw_in[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw_in[3]}]
##Bank = 34, Pin name = IO_L19N_T3_VREF_34,					Sch name = SW4
set_property PACKAGE_PIN R5 [get_ports {sw_in[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw_in[4]}]
##Bank = 34, Pin name = IO_L20P_T3_34,						Sch name = SW5
set_property PACKAGE_PIN V7 [get_ports {sw_in[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw_in[5]}]
##Bank = 34, Pin name = IO_L20N_T3_34,						Sch name = SW6
set_property PACKAGE_PIN V6 [get_ports {sw_in[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw_in[6]}]
##Bank = 34, Pin name = IO_L10P_T1_34,						Sch name = SW7
set_property PACKAGE_PIN V5 [get_ports {sw_in[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw_in[7]}]


# LEDs
#Bank = 34, Pin name = IO_L24N_T3_34,						Sch name = LED0
set_property PACKAGE_PIN T8 [get_ports {led_scancode_debug[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led_scancode_debug[0]}]
##Bank = 34, Pin name = IO_L21N_T3_DQS_34,					Sch name = LED1
set_property PACKAGE_PIN V9 [get_ports {led_scancode_debug[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led_scancode_debug[1]}]
##Bank = 34, Pin name = IO_L24P_T3_34,						Sch name = LED2
set_property PACKAGE_PIN R8 [get_ports {led_scancode_debug[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led_scancode_debug[2]}]
##Bank = 34, Pin name = IO_L23N_T3_34,						Sch name = LED3
set_property PACKAGE_PIN T6 [get_ports {led_scancode_debug[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led_scancode_debug[3]}]
##Bank = 34, Pin name = IO_L12P_T1_MRCC_34,					Sch name = LED4
set_property PACKAGE_PIN T5 [get_ports {led_scancode_debug[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led_scancode_debug[4]}]
##Bank = 34, Pin name = IO_L12N_T1_MRCC_34,					Sch	name = LED5
set_property PACKAGE_PIN T4 [get_ports {led_scancode_debug[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led_scancode_debug[5]}]
##Bank = 34, Pin name = IO_L22P_T3_34,						Sch name = LED6
set_property PACKAGE_PIN U7 [get_ports {led_scancode_debug[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led_scancode_debug[6]}]
##Bank = 34, Pin name = IO_L22N_T3_34,						Sch name = LED7
set_property PACKAGE_PIN U6 [get_ports {led_scancode_debug[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led_scancode_debug[7]}]
#Bank = 34, Pin name = IO_L10N_T1_34,						Sch name = LED8
#set_property PACKAGE_PIN V4 [get_ports {led[8]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
##Bank = 34, Pin name = IO_L8N_T1_34,						Sch name = LED9
#set_property PACKAGE_PIN U3 [get_ports {led[9]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]
##Bank = 34, Pin name = IO_L7N_T1_34,						Sch name = LED10
#set_property PACKAGE_PIN V1 [get_ports {led[10]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]
##Bank = 34, Pin name = IO_L17P_T2_34,						Sch name = LED11
#set_property PACKAGE_PIN R1 [get_ports {led[11]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]
##Bank = 34, Pin name = IO_L13N_T2_MRCC_34,					Sch name = LED12
#set_property PACKAGE_PIN P5 [get_ports {led[12]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]
##Bank = 34, Pin name = IO_L7P_T1_34,						Sch name = LED13
#set_property PACKAGE_PIN U1 [get_ports {led[13]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]
##Bank = 34, Pin name = IO_L15N_T2_DQS_34,					Sch name = LED14
#set_property PACKAGE_PIN R2 [get_ports {led[14]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[14]}]
##Bank = 34, Pin name = IO_L15P_T2_DQS_34,					Sch name = LED15
#set_property PACKAGE_PIN P2 [get_ports {led[15]}]
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[15]}]

##Bank = 34, Pin name = IO_L5P_T0_34,						Sch name = LED16_R
#set_property PACKAGE_PIN K5 [get_ports RGB1_Red]
	#set_property IOSTANDARD LVCMOS33 [get_ports RGB1_Red]
##Bank = 15, Pin name = IO_L5P_T0_AD9P_15,					Sch name = LED16_G
#set_property PACKAGE_PIN F13 [get_ports RGB1_Green]
	#set_property IOSTANDARD LVCMOS33 [get_ports RGB1_Green]
##Bank = 35, Pin name = IO_L19N_T3_VREF_35,					Sch name = LED16_B
#set_property PACKAGE_PIN F6 [get_ports RGB1_Blue]
	#set_property IOSTANDARD LVCMOS33 [get_ports RGB1_Blue]
##Bank = 34, Pin name = IO_0_34,								Sch name = LED17_R
#set_property PACKAGE_PIN K6 [get_ports RGB2_Red]
	#set_property IOSTANDARD LVCMOS33 [get_ports RGB2_Red]
##Bank = 35, Pin name = IO_24P_T3_35,						Sch name =  LED17_G
#set_property PACKAGE_PIN H6 [get_ports RGB2_Green]
	#set_property IOSTANDARD LVCMOS33 [get_ports RGB2_Green]
##Bank = CONFIG, Pin name = IO_L3N_T0_DQS_EMCCLK_14,			Sch name = LED17_B
#set_property PACKAGE_PIN L16 [get_ports RGB2_Blue]
	#set_property IOSTANDARD LVCMOS33 [get_ports RGB2_Blue]



#7 segment display
#Bank = 34, Pin name = IO_L2N_T0_34,						Sch name = CA
set_property PACKAGE_PIN L3 [get_ports {sev_seg[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sev_seg[0]}]
#Bank = 34, Pin name = IO_L3N_T0_DQS_34,					Sch name = CB
set_property PACKAGE_PIN N1 [get_ports {sev_seg[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sev_seg[1]}]
#Bank = 34, Pin name = IO_L6N_T0_VREF_34,					Sch name = CC
set_property PACKAGE_PIN L5 [get_ports {sev_seg[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sev_seg[2]}]
#Bank = 34, Pin name = IO_L5N_T0_34,						Sch name = CD
set_property PACKAGE_PIN L4 [get_ports {sev_seg[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sev_seg[3]}]
#Bank = 34, Pin name = IO_L2P_T0_34,						Sch name = CE
set_property PACKAGE_PIN K3 [get_ports {sev_seg[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sev_seg[4]}]
#Bank = 34, Pin name = IO_L4N_T0_34,						Sch name = CF
set_property PACKAGE_PIN M2 [get_ports {sev_seg[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sev_seg[5]}]
#Bank = 34, Pin name = IO_L6P_T0_34,						Sch name = CG
set_property PACKAGE_PIN L6 [get_ports {sev_seg[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sev_seg[6]}]

#Bank = 34, Pin name = IO_L16P_T2_34,						Sch name = DP
set_property PACKAGE_PIN M4 [get_ports {sev_seg[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sev_seg[7]}]

#Bank = 34, Pin name = IO_L18N_T2_34,						Sch name = AN0
set_property PACKAGE_PIN N6 [get_ports {anode[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[0]}]
#Bank = 34, Pin name = IO_L18P_T2_34,						Sch name = AN1
set_property PACKAGE_PIN M6 [get_ports {anode[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[1]}]
#Bank = 34, Pin name = IO_L4P_T0_34,						Sch name = AN2
set_property PACKAGE_PIN M3 [get_ports {anode[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[2]}]
#Bank = 34, Pin name = IO_L13_T2_MRCC_34,					Sch name = AN3
set_property PACKAGE_PIN N5 [get_ports {anode[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[3]}]
#Bank = 34, Pin name = IO_L3P_T0_DQS_34,					Sch name = AN4
set_property PACKAGE_PIN N2 [get_ports {anode[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[4]}]
#Bank = 34, Pin name = IO_L16N_T2_34,						Sch name = AN5
set_property PACKAGE_PIN N4 [get_ports {anode[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[5]}]
#Bank = 34, Pin name = IO_L1P_T0_34,						Sch name = AN6
set_property PACKAGE_PIN L1 [get_ports {anode[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[6]}]
#Bank = 34, Pin name = IO_L1N_T034,							Sch name = AN7
set_property PACKAGE_PIN M1 [get_ports {anode[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[7]}]



#Buttons
#Bank = 15, Pin name = IO_L3P_T0_DQS_AD1P_15,				Sch name = CPU_RESET
set_property PACKAGE_PIN C12 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]


# Connect rst_n to cpu reset instead
#set_property PACKAGE_PIN U9 [get_ports {rst_n}]
#        set_property IOSTANDARD LVCMOS33 [get_ports {rst_n}]



##Bank = 15, Pin name = IO_L11N_T1_SRCC_15,					Sch name = BTNC
set_property PACKAGE_PIN E16 [get_ports b_enter]
	set_property IOSTANDARD LVCMOS33 [get_ports b_enter]
##Bank = 15, Pin name = IO_L14P_T2_SRCC_15,					Sch name = BTNU
#set_property PACKAGE_PIN F15 [get_ports btnU]
	#set_property IOSTANDARD LVCMOS33 [get_ports btnU]
##Bank = CONFIG, Pin name = IO_L15N_T2_DQS_DOUT_CSO_B_14,	Sch name = BTNL
set_property PACKAGE_PIN T16 [get_ports b_sign]
	set_property IOSTANDARD LVCMOS33 [get_ports b_sign]
##Bank = 14, Pin name = IO_25_14,							Sch name = BTNR
#set_property PACKAGE_PIN R10 [get_ports btnR]
	#set_property IOSTANDARD LVCMOS33 [get_ports btnR]
##Bank = 14, Pin name = IO_L21P_T3_DQS_14,					Sch name = BTND
#set_property PACKAGE_PIN V10 [get_ports btnD]
	#set_property IOSTANDARD LVCMOS33 [get_ports btnD]
