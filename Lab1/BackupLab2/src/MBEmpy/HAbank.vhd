library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity HAbank is
  generic ( N : integer := 1 );
  port (
    in1  : in  unsigned(N - 1 downto 0);
    in2  : in  unsigned(N - 1 downto 0);
    outS : out unsigned(N - 1 downto 0);
    outC : out unsigned(N - 1 downto 0)
  );
end entity;

architecture structural of HAbank is

  component HA
    port (
      A, B  : IN  STD_LOGIC;
      S, Co : OUT STD_LOGIC
    );
  end component HA;

begin

  bank : for i in N - 1 downto 0 generate
    HA_i : HA port map(in1(i), in2(i), outS(i), outC(i));
  end generate;

end architecture;
