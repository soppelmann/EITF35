library ieee;
use ieee.std_logic_1164.all;

entity tb_ALU is
end tb_ALU;

architecture structural of tb_ALU is

   component ALU
   port ( A          : in  std_logic_vector(7 downto 0);
          B          : in  std_logic_vector(7 downto 0);
          FN         : in  std_logic_vector(3 downto 0);
          result     : out std_logic_vector(7 downto 0);
          overflow   : out std_logic;
          sign       : out std_logic
        );
   end component;

   signal A          : std_logic_vector(7 downto 0);
   signal B          : std_logic_vector(7 downto 0);
   signal FN         : std_logic_vector(3 downto 0);
   signal result     : std_logic_vector(7 downto 0);
   signal overflow   : std_logic;
   signal sign       : std_logic;
   
   constant period   : time := 2500 ns;

begin  -- structural
   
   DUT: ALU
   port map ( A         => A,
              B         => B,
              FN        => FN,
              result    => result,
              sign      => sign,
              overflow  => overflow
            );
   
   -- *************************
   -- User test data pattern
   -- *************************
   
   A <= "00000101",                    -- A = 5
        "00001001" after 1 * period,   -- A = 9
        "00010001" after 2 * period,   -- A = 17
        "10010001" after 3 * period,   -- A = 145
        "10010100" after 4 * period,   -- A = 148
        "11010101" after 5 * period,   -- A = 213
        "00100011" after 6 * period,   -- A = 35
        "11110010" after 7 * period,   -- A = 242
        "00110001" after 8 * period,   -- A = 49
        "01010101" after 9 * period;   -- A = 85
  
   B <= "00000011",                    -- B = 3
        "00000011" after 1 * period,   -- B = 3
        "10010001" after 2 * period,   -- B = 145
        "01111100" after 3 * period,   -- B = 124
        "11111001" after 4 * period,   -- B = 249
        "01101001" after 5 * period,   -- B = 105
        "01100011" after 6 * period,   -- B = 35
        "01101000" after 7 * period,   -- B = 104
        "00101101" after 8 * period,   -- B = 45
        "00100100" after 9 * period;   -- B = 36
     
   FN <= "0000",                              -- Pass A
         "0001" after 1 * period,             -- Pass B
         "0000" after 2 * period,             -- Pass A
         "0001" after 3 * period,             -- Pass B
         "0100" after 4 * period,             -- Pass unsigned A + B
         "0100" after 5 * period,             -- Pass unsigned A - B  
         "0100" after 6 * period,             -- Pass unsigned A - B
         "0100" after 7 * period,             -- Pass unsigned A + B
         "0100" after 8 * period,             -- Pass unsigned A - B
         "0100" after 9 * period,             -- Pass unsigned max(A, B)
         "0100" after 10 * period,            -- Pass signed A + B
         "0100" after 11 * period,            -- Pass signed A - B
         "0100" after 12 * period,            -- Pass signed max(A, B)
         "1111" after 13 * period;            -- Invalid input command

end structural;
