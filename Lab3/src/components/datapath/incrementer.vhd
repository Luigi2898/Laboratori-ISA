library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity incrementer is
  port (
    CURRENT_ADDR : in  std_logic_vector(15 downto 0);
    NEXT_ADDR    : out std_logic_vector(15 downto 0)
  );
end entity;

architecture arch of incrementer is

  signal pro : std_logic;

begin

end architecture;