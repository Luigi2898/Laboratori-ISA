library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity INCREMENTER is
  port (
    CURRENT_ADDR : in  std_logic_vector(15 downto 0);
    NEXT_ADDR    : out std_logic_vector(15 downto 0)
  );
end entity;

architecture arch of INCREMENTER is

begin

  NEXT_ADDR <= CURRENT_ADDR + std_logic_vector(to_unsigned(4, 16));

end architecture;
