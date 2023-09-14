-------------------------------------------------------------------------------
-- Title      : tb_pkg.vhd 
-- Project    :  
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description: 
-- 		        Some functions for testbench 
--
--
-------------------------------------------------------------------------------

library ieee; 
use ieee.numeric_std.all; 
use ieee.std_logic_1164.all; 
use std.textio.all;  
use ieee.std_logic_textio.all;


package tb_pkg is 
    -- create a memory almost 1Kb to store all keyboard stimulus from file
    subtype kb_word_t is unsigned(10 downto 0);
    subtype word_t is unsigned(7 downto 0);
    type word_arr is array (natural range <>) of word_t;
    constant max_mem_size : natural := 1024-1;

    function GetCodeFromFile (RamFileName: in string) return word_arr; 
    function function_parity (a: unsigned) return std_logic;
    function reverse_any_vector (a: in unsigned) return unsigned; 

end tb_pkg; 

package body tb_pkg is

    function GetCodeFromFile (RamFileName: in string) return word_arr is
	file RamFile         : text open read_mode is RamFileName;
	variable RamFileLine : line;
	variable RAM         : word_arr(0 to max_mem_size);
	variable ww           : std_logic_vector(word_t'range);
	variable i           : natural;
    begin
	for i in 0 to max_mem_size loop
	    if endfile(RamFile) then
		RAM(i to max_mem_size) := (others => (others => '0'));
		exit;
	    else
		readline (RamFile, RamFileLine);
		hread(RamFileLine, ww);
		Ram(i) := unsigned(ww);
	    end if;
	end loop;
	assert endfile(RamFile)
	report "Memory initialisation file is too big" severity error;
	return RAM;

    end function;



    function function_parity (a: unsigned) return std_logic is
    variable y : std_logic := '1';
    begin
	for i in a'RANGE loop
	    y := y xor a(i);
	end loop;
	return y;
    end function_parity;


    function reverse_any_vector (a: in unsigned)
    return unsigned is
	variable result: unsigned(a'RANGE);
	alias aa: unsigned(a'REVERSE_RANGE) is a;
    begin
	for i in aa'RANGE loop
	    result(i) := aa(i);
	end loop;
	return result;
    end; -- function reverse_any_vector

end package body;
