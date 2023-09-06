library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity par2ser is
    port (
        clk: in std_logic;
        reset_n: in std_logic;
        data_parallel: in std_logic_vector(3 downto 0);
        data_serial: out std_logic
    );
end par2ser;

architecture behavioural of par2ser is
    
    -- Define the needed internal signals
    signal current_sample_shifter, next_sample_shifter : std_logic_vector(3 downto 0);
    signal current_counter, next_counter : unsigned(1 downto 0);
    signal conversion_start : std_logic;

begin

    -- purpose: Implements the registers for the sequence decoder
    -- type : sequential
    registers: process (clk, reset_n)
    begin
        if reset_n = '0' then
            current_sample_shifter <= (others => '0');
            current_counter <= (others =>'0');
        elsif rising_edge(clk) then
            current_sample_shifter <= next_sample_shifter;
            current_counter <= next_counter;
        end if;
    end process;
    
    -- increment code
    -- ???

    -- output logic
    -- ???

    combinational_shifter : process() -- fill out the sensitivity list
    begin
        -- default values (why needed?)
        next_sample_shifter <= current_sample_shifter;

        -- write the code for parallel to serial conversion
	-- ???

    end process;
    
end behavioural;
