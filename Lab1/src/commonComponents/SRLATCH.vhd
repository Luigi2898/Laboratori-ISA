library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity SRLATCH is
  port (
    S   : in std_logic;
    r   : in std_logic;
    q   : buffer std_logic
  );
end entity;

architecture beh of SRLATCH is

  signal nq : std_logic;

begin

beha : process(s,r)
begin
  if s = '1' and r = '0' then
    nq <= '1';
  elsif s = '0' and r = '1' then
    nq <= '0';
  elsif (s = '0' and r = '0') or (s = '1' and r = '1') then
    nq <= q;
  end if;
  q <= nq;
end process;

end architecture;
