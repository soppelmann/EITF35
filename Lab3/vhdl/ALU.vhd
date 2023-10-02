library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
   port ( A          : in  std_logic_vector (7 downto 0);   -- Input A
          B          : in  std_logic_vector (7 downto 0);   -- Input B
          FN         : in  std_logic_vector (3 downto 0);   -- ALU functions provided by the ALU_Controller (see the lab manual)
          result 	   : out std_logic_vector (7 downto 0);   -- ALU output (unsigned binary)
	       overflow   : out std_logic;                       -- '1' if overflow ocurres, '0' otherwise 
	       sign       : out std_logic                        -- '1' if the result is a negative value, '0' otherwise
        );
end ALU;

architecture behavioral of ALU is

-- SIGNAL DEFINITIONS HERE IF NEEDED

begin

   process ( FN, A, B )
   begin

   -- DEVELOPE YOUR CODE HERE

   end process;

end behavioral;
