library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;


package array_std is
    -- MBE + PP
    constant N_pp_bits: integer := 33;
    constant N_pp_array : integer := 17;
    
    -- TB PARALLEL INPUTS DATA GENERATOR
    constant N_bit_DATAGEN : integer := 33;
    constant N_input_DATAGEN : integer := 17;
    
    ---------------------------------------------------------------------------------------------------------

    -- MBE + PP
    type PP_array is array (N_pp_array-1 downto 0) of std_logic_vector(N_pp_bits-1 downto 0);
    type PP_array_ext is array (N_pp_array-1 downto 0) of std_logic_vector(N_pp_bits + 3 downto 0);

    -- TB PARALLEL INPUTS DATA GENERATOR
    type array_DATAGEN is array (N_input_DATAGEN-1 downto 0) of std_logic_vector(N_bit_DATAGEN-1 downto 0);

end package array_std;

