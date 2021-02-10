library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity INCREMENTER is
  generic (STEP : integer := 4);
  port (
    CURRENT_ADDR : in  std_logic_vector(31 downto 0);
    NEXT_ADDR    : out std_logic_vector(31 downto 0)
  );
end entity;

architecture arch of INCREMENTER is

begin

  NEXT_ADDR <= std_logic_vector(unsigned(CURRENT_ADDR) + to_unsigned(STEP, 32));

end architecture;
