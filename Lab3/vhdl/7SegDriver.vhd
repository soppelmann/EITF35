library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg_driver is
   port ( clk           : in  std_logic;
          reset         : in  std_logic;
          BCD_digit     : in  std_logic_vector(9 downto 0);          
          sign          : in  std_logic;
          overflow      : in  std_logic;
          DIGIT_ANODE   : out std_logic_vector(3 downto 0);
          SEGMENT       : out std_logic_vector(6 downto 0)
        );
end seven_seg_driver;

architecture behavioral of seven_seg_driver is

-- SIGNAL DEFINITIONS HERE IF NEEDED

begin

-- DEVELOPE YOUR CODE HERE

end behavioral;
