library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ABS_VAL is
  generic (Nbits : integer := 32);
  port (
    DATA_IN : in std_logic_vector (Nbits-1 downto 0);
    EN : in std_logic;
    DATA_OUT : out std_logic_vector (Nbits-1 downto 0)
  );
end entity ABS_VAL;

architecture rtl of ABS_VAL is

  signal GATED_DATA_IN : std_logic_vector (Nbits-1 downto 0);
  signal COMPLEMENTED_DATA_IN : std_logic_vector (Nbits-1 downto 0);
  signal ONE_Nbits : std_logic_vector (Nbits-1 downto 0);
  signal GATER_VECT : std_logic_vector (Nbits-1 downto 0);
  
begin

  GATER_VECT <= (others => EN);
  GATED_DATA_IN <= DATA_IN and GATER_VECT;
  COMPLEMENTED_DATA_IN <= std_logic_vector(unsigned(not(GATED_DATA_IN)) + 1);
  
  with GATED_DATA_IN(Nbits-1) select DATA_OUT <= GATED_DATA_IN when '0',
                                                 COMPLEMENTED_DATA_IN when '1',
                                                 GATED_DATA_IN when others;
  
end architecture rtl;