
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity MYFIR is
  port (
    RST_N : in    std_logic;            -- External
    CLK   : in    std_logic;            -- External
    VIN   : in    std_logic;            -- External
    DIN   : in    signed(10 downto 0);  -- External
    H0    : in    signed(10 downto 0);  -- External
    H1    : in    signed(10 downto 0);  -- External
    H2    : in    signed(10 downto 0);  -- External
    H3    : in    signed(10 downto 0);  -- External
    H4    : in    signed(10 downto 0);  -- External
    H5    : in    signed(10 downto 0);  -- External
    H6    : in    signed(10 downto 0);  -- External
    H7    : in    signed(10 downto 0);  -- External
    H8    : in    signed(10 downto 0);  -- External
    DOUT  : out   signed(10 downto 0);  -- External
    VOUT  : out   std_logic             -- External
  );
end entity MYFIR;

architecture BEH of MYFIR is

  component FF is
    port (
      FF_IN  : in    std_logic;
      FF_OUT : out   std_logic;
      CLK    : in    std_logic;
      RST    : in    std_logic;
      LOAD   : in    std_logic
    );
  end component;

  component MYFIR_CU is
    port (
      CLK   : in    std_logic;
      RST_N : in    std_logic;
      VIN   : in    std_logic;
      LOAD  : out   std_logic;
      VOUT  : out   std_logic
    );
  end component;

  component MYFIR_DP is
    port (
      RST_N    : in    std_logic;
      CTRL_IN  : in    std_logic;
      CTRL_OUT : in    std_logic;
      CLK      : in    std_logic;
      DIN      : in    signed(10 downto 0);
      H0       : in    signed(10 downto 0);
      H1       : in    signed(10 downto 0);
      H2       : in    signed(10 downto 0);
      H3       : in    signed(10 downto 0);
      H4       : in    signed(10 downto 0);
      H5       : in    signed(10 downto 0);
      H6       : in    signed(10 downto 0);
      H7       : in    signed(10 downto 0);
      H8       : in    signed(10 downto 0);
      DOUT     : out   signed(10 downto 0)
    );
  end component;

  -- Control signals
  signal ctrl_in_dp  : std_logic;
  signal ctrl_out_dp : std_logic;

  signal d1          : std_logic;

begin

  d1 <= '1';

  CU : MYFIR_CU
    port map (
      CLK   => clk,
      RST_N => rst_n,
      VIN   => vin,
      LOAD  => ctrl_in_dp,
      VOUT  => ctrl_out_dp
    );

  DP : MYFIR_DP
    port map (
      RST_N    => rst_n,
      CTRL_IN  => ctrl_in_dp,
      CTRL_OUT => ctrl_out_dp,
      CLK      => clk,
      DIN      => DIN,
      H0       => H0,
      H1       => H1,
      H2       => H2,
      H3       => H3,
      H4       => H4,
      H5       => H5,
      H6       => H6,
      H7       => H7,
      H8       => H8,
      DOUT     => dout
    );

  FLIPFLOP : FF
    port map (ctrl_out_dp, vout, clk, d1, d1);

end architecture BEH;
