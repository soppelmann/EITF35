library ieee;
use ieee.std_logic_1164.all;

entity sequence_detector_mealy is
    port (
        clk: in std_logic;
        reset_n: in std_logic;
        data_serial : in std_logic;
        data_valid : in std_logic;
        data_out: out std_logic
    );
end sequence_detector_mealy;

architecture behavioural of sequence_detector_mealy is


    -- Define a enumeration type for the states
    type state_type is (s_init, s_1, s_11, s_111, s_1111);
    
    -- Define the needed internal signals
    signal current_state, next_state: state_type;

begin
            
    -- purpose: Implements the registers for the sequence decoder
    -- type : sequential
    registers: process (clk, reset_n)
    begin
        if reset_n = '0' then
            current_state <= s_init;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
    
    -- purpose: Implements the next_state logic as well as the output logic
    -- type : combinational
    combinational: process () -- fill out the sensitivity list
    begin
        -- set default value
        next_state <= current_state;
        data_out <= '0';

        case current_state is
            when s_init =>
                 if data_serial = '0' then
                    next_state <= s_init;  -- is this line necessary?
                 else
                    next_state <= s_1;
                 end if;
            when s_1 =>
                --?
                --?
                --?
         end case;
    end process;

end behavioural;
