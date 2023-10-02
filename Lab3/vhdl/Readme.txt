You may select different push buttons for your design. So, based on your selection, you should add them into the .xdc file.
You can use the .xdc file of lab 2 and just modify it based on the port definition of your design.

The required information about pin configuration for Lab 3 is as follows:

## Switches
#NET "sw<0>"			LOC = "U9"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L21P_T3_DQS_34,					Sch name = SW0
#NET "sw<1>"			LOC = "U8"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_25_34,							Sch name = SW1
#NET "sw<2>"			LOC = "R7"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L23P_T3_34,						Sch name = SW2
#NET "sw<3>"			LOC = "R6"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L19P_T3_34,						Sch name = SW3
#NET "sw<4>"			LOC = "R5"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L19N_T3_VREF_34,					Sch name = SW4
#NET "sw<5>"			LOC = "V7"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L20P_T3_34,						Sch name = SW5
#NET "sw<6>"			LOC = "V6"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L20N_T3_34,						Sch name = SW6
#NET "sw<7>"			LOC = "V5"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L10P_T1_34,						Sch name = SW7
#NET "sw<8>"			LOC = "U4"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L8P_T1-34,						Sch name = SW8
#NET "sw<9>"			LOC = "V2"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L9N_T1_DQS_34,					Sch name = SW9
#NET "sw<10>"			LOC = "U2"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L9P_T1_DQS_34,					Sch name = SW10
#NET "sw<11>"			LOC = "T3"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L11N_T1_MRCC_34,					Sch name = SW11
#NET "sw<12>"			LOC = "T1"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L17N_T2_34,						Sch name = SW12
#NET "sw<13>"			LOC = "R3"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L11P_T1_SRCC_34,					Sch name = SW13
#NET "sw<14>"			LOC = "P3"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L14N_T2_SRCC_34,					Sch name = SW14
#NET "sw<15>"			LOC = "P4"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L14P_T2_SRCC_34,					Sch name = SW15


## Buttons
#NET "btnCpuReset"		LOC = "C12"	| IOSTANDARD = "LVCMOS33";		#Bank = 15, Pin name = IO_L3P_T0_DQS_AD1P_15,				Sch name = CPU_RESET
#NET "btnC"				LOC = "E16"	| IOSTANDARD = "LVCMOS33";		#Bank = 15, Pin name = IO_L11N_T1_SRCC_15,					Sch name = BTNC
#NET "btnU"				LOC = "F15"	| IOSTANDARD = "LVCMOS33";		#Bank = 15, Pin name = IO_L14P_T2_SRCC_15,					Sch name = BTNU
#NET "btnL"				LOC = "T16"	| IOSTANDARD = "LVCMOS33";		#Bank = CONFIG, Pin name = IO_L15N_T2_DQS_DOUT_CSO_B_14,	Sch name = BTNL
#NET "btnR"				LOC = "R10"	| IOSTANDARD = "LVCMOS33";		#Bank = 14, Pin name = IO_25_14,							Sch name = BTNR
#NET "btnD"				LOC = "V10"	| IOSTANDARD = "LVCMOS33";		#Bank = 14, Pin name = IO_L21P_T3_DQS_14,					Sch name = BTND


## 7 segment display
#NET "seg<0>"			LOC = "L3"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L2N_T0_34,						Sch name = CA
#NET "seg<1>"			LOC = "N1"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L3N_T0_DQS_34,					Sch name = CB
#NET "seg<2>"			LOC = "L5"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L6N_T0_VREF_34,					Sch name = CC
#NET "seg<3>"			LOC = "L4"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L5N_T0_34,						Sch name = CD
#NET "seg<4>"			LOC = "K3"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L2P_T0_34,						Sch name = CE
#NET "seg<5>"			LOC = "M2"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L4N_T0_34,						Sch name = CF
#NET "seg<6>"			LOC = "L6"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L6P_T0_34,						Sch name = CG

#NET "dp"				LOC = "M4"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L16P_T2_34,						Sch name = DP

#NET "an<0>"			LOC = "N6"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L18N_T2_34,						Sch name = AN0
#NET "an<1>"			LOC = "M6"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L18P_T2_34,						Sch name = AN1
#NET "an<2>"			LOC = "M3"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L4P_T0_34,						Sch name = AN2
#NET "an<3>"			LOC = "N5"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L13_T2_MRCC_34,					Sch name = AN3
#NET "an<4>"			LOC = "N2"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L3P_T0_DQS_34,					Sch name = AN4
#NET "an<5>"			LOC = "N4"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L16N_T2_34,						Sch name = AN5
#NET "an<6>"			LOC = "L1"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L1P_T0_34,						Sch name = AN6
#NET "an<7>"			LOC = "M1"	| IOSTANDARD = "LVCMOS33";		#Bank = 34, Pin name = IO_L1N_T034,							Sch name = AN7