-------------------------------------------------------------------------------
-- Title      : tb_keyboard
-- Project    : Keyboard VLSI Lab
-------------------------------------------------------------------------------
-- File       : tracking_top.vhd
-- Author     : Hemanth Prabhu
-- Company    : Lund University
-- Created    : 2013-08-17
-- Last update: 2023-09-13
-- Platform   : Modelsim
-------------------------------------------------------------------------------
-- Description:
-- 		Testbench to emulate keyboard, seven segement display, led !!
-- 		Keyboard stimulus from input.txt
--		led and seven segment output is written into output_x.txt files
--
-------------------------------------------------------------------------------
-- Copyright (c) 2012 Lund University
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--library ieee, modelsim_lib;
--use modelsim_lib.util.all;
use std.textio.all;
use ieee.std_logic_textio.all;

use work.tb_pkg.all;

entity tb_keyboard is
    end tb_keyboard;

architecture tb_keyboard_arch of tb_keyboard is


    -- This is the top level entity
    -- I prefer to call sys_clk as clk
    component keyboard_top is
	port (
		 clk          : in std_logic;
		 rst          : in std_logic;
		 kb_data	  : in std_logic;
		 kb_clk	  : in std_logic;
		 sc		  : out unsigned(7 downto 0);
		 num	  : out unsigned(7 downto 0);
		 seg_en	  : out unsigned(3 downto 0)
	     );
    end component;

    -- file io declarations
    constant INPUT_FILE   : string := "./input.txt";
    constant OUTPUT_LED_FILE  : string := "./output_led.txt";
    constant OUTPUT_SG_FILE  : string := "./output_sg.txt";
    signal clk_delay : std_logic := '0';

    -- testbench signal declarations,
    -- not so pro naming conventions :)
    -- initial value only in testbench, not to be used in design !!!
    signal tb_clk, clk, kb_clk_gen, kb_clk : std_logic := '0';
    signal tb_rst, sys_rst : std_logic := '0';
    signal tb_sc	  : unsigned(7 downto 0);
    signal tb_num	  : unsigned(7 downto 0);
    signal tb_seg_en	  : unsigned(3 downto 0);
    signal kb_data_serial : std_logic := '0';

    signal start_tb : std_logic := '0';
    signal read_mem_make_code, kb_make_code_rev, kb_make_code : unsigned(7 downto 0);
    signal kb_all_code : unsigned(32 downto 0);
    signal code_counter : unsigned(9 downto 0) := (others => '0');
    signal get_new_code, ready_to_shift :std_logic := '0';
    signal shift_counter : unsigned(6 downto 0);
    signal start_kb_clk, kb_clk_to_dut : std_logic := '0';
    signal kb_data_to_dut : std_logic := '0';
    signal kb_parity : std_logic;


    -- GetCodeFromFile a complicated function to decode ASCII to corresponding kb code !!
    signal kb_code_mem : word_arr(0 to max_mem_size) := GetCodeFromFile("input.txt");

begin


    -- design under test (DUT) instance
    keyboard_top_inst : keyboard_top
    port map (
		 clk => clk,
		 rst => sys_rst,
		 kb_data => kb_data_to_dut,
		 kb_clk => kb_clk_to_dut,
		 sc => tb_sc,
		 num => tb_num,
		 seg_en => tb_seg_en
	     );



    -- 2 MHz sys clock generated in testbench,
    -- kb_clk is made faster 500kHz, in fpga it wil be around 30KHz
    -- feel free to change, however shouldnt matter in simulations !!
    clk <= not(clk) after 500 ns;
    kb_clk_gen <= not(kb_clk_gen) after 2000 ns;
    -- adding delay to emulate latency
    kb_clk <= kb_clk_gen after 125 ns;

    sys_rst <= '1', '0' after 2300 ns;

    tb_clk <= clk;
    tb_rst <= sys_rst;

    start_tb <= '1' after 2700 ns;

    -- process block to read stimulus, emulate serial keyboard code
    -- some bad coding with messy logic to make it work
    process(kb_clk,tb_rst)
    begin
	if(tb_rst = '1') then
	    code_counter <=  (others => '0');
	    get_new_code <= '1';
	    shift_counter <=  (others => '0');
	    kb_data_serial <= '0';
	else
	    if(kb_clk'event and kb_clk = '1') then
		start_kb_clk <= '0';
		if(start_tb = '1' and get_new_code = '1') then
		    -- make code + break code, parity is fixed to 1 to simplify
		    kb_all_code <= '0' & kb_make_code & kb_parity & '1' & '0' & X"0F" & "11" & '0' & kb_make_code & kb_parity & '1';
		    code_counter <= code_counter + 1;
		    get_new_code <= '0';
		    ready_to_shift <= '1';
		end if;

		if(ready_to_shift = '1') then
		    get_new_code <= '0';
		    kb_data_serial <= kb_all_code(32-to_integer(shift_counter));
		    start_kb_clk <= '1';
		    shift_counter <= shift_counter + 1;
		    if (shift_counter = 32) then
			shift_counter <= (others => '0');
			ready_to_shift <= '0';
		    end if;
		end if;

		--wait for sometime before next key
		if ( get_new_code = '0' and ready_to_shift = '0') then
			start_kb_clk <= '0';
			get_new_code <= '1';
			kb_data_serial <= '0';
		end if;

	    end if;
	end if;
    end process;
    -- read code from memory, counter used as index
    read_mem_make_code <= kb_code_mem(to_integer(code_counter));
    kb_make_code_rev <= reverse_any_vector(read_mem_make_code);
    kb_make_code <= kb_make_code_rev;
    kb_parity <= function_parity(kb_make_code);
    kb_clk_to_dut <= kb_clk and start_kb_clk;
    kb_data_to_dut <= kb_data_serial after 100 ns;


-- assertion in testbench
    assert start_tb'event and start_tb = '1'
    report "********Reset released, STARTING TESTBENCH ***********"
    severity NOTE;

end tb_keyboard_arch;
