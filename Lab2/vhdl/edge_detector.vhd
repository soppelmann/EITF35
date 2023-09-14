-------------------------------------------------------------------------------
-- Title      : edge_detector.vhd 
-- Project    : Keyboard VLSI Lab
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description: 
-- 		        Make sure not to use 'EVENT on anyother signals than clk
-- 		        
--
-------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity edge_detector is
    port (
	     clk : in std_logic;
	     rst : in std_logic;
	     kb_clk_sync : in std_logic;
	     edge_found : out std_logic
	 );
end edge_detector;


architecture edge_detector_arch of edge_detector is

begin


end edge_detector_arch;
