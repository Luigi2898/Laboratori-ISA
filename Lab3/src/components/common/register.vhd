library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity reg is
  generic (
    N : integer := 32
  );
  port (
    CLK  : in  std_logic;
    DIN  : in  std_logic_vector(N - 1 downto 0);
    DOUT : out std_logic_vector(N - 1 downto 0)
  );
end entity;

architecture arch of reg is

begin

end architecture;
