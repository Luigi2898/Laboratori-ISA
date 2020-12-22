library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity incrementer is
  port (
    current_address : in  std_logic_vector(15 downto 0);
    next_address    : out std_logic_vector(15 downto 0)
  );
end entity;

architecture arch of incrementer is

begin

end architecture;
