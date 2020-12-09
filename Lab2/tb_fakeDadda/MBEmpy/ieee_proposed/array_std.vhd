library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;


package array_std is
    
    constant N_pp_bits: integer := 32;
    constant N_pp_array : integer := 17;
    
    type PP_array is array (N_pp_array-1 downto 0) of std_logic_vector(N_pp_bits downto 0);
    type PP_array_ext is array (N_pp_array-1 downto 0) of std_logic_vector(N_pp_bits + 4 downto 0);

end package array_std;
