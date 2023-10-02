library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_ctrl is
   port ( clk     : in  std_logic;
          reset   : in  std_logic;
          enter   : in  std_logic;
          sign    : in  std_logic;
          FN      : out std_logic_vector (3 downto 0);   -- ALU functions
          RegCtrl : out std_logic_vector (1 downto 0)   -- Register update control bits
        );
end ALU_ctrl;

architecture behavioral of ALU_ctrl is

-- SIGNAL DEFINITIONS HERE IF NEEDED

begin

   -- DEVELOPE YOUR CODE HERE

end behavioral;
