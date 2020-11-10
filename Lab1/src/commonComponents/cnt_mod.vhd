
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity CNT_MOD is
  generic (
    N      : positive := 2;
    MODULE : integer  := 3
  );
  port (
    CLK     : in    std_logic;
    RSTN    : in    std_logic;
    EN_CNT  : in    std_logic;
    TC_ACK  : in    std_logic;
    TC      : out   std_logic;
    CNT_OUT : out   unsigned (N - 1 downto 0)
  );
end entity CNT_MOD;

architecture BEH of CNT_MOD is

  component SRLATCH is
    port (
      S   : in std_logic;
      r   : in std_logic;
      q   : buffer std_logic
    );
  end component;

  signal tc_internal : std_logic;
  signal rst_internal : std_logic;

begin

  CNT_PROCESS : process (clk, rstn) is

    variable flag : std_logic;
    variable tcv  : std_logic;
    variable cnt  : unsigned (N downto 0);

  begin

    if (rstn = '0') then
      cnt  := (others => '0');
      tcv  := '0';
    elsif (clk'event and clk = '1') then
      if (en_cnt = '1') then
        cnt := cnt + 1;
        if (cnt = MODULE + 1) then
          cnt := to_unsigned(1,N+1);
          tcv := '0';
        elsif (cnt = MODULE) then
          tcv := '1';
        else
          tcv := '0';
        end if;
        end if;
      tcv := tcv and not (tc_ack);
    end if;

    cnt_out <= cnt(N-1 downto 0);
    tc <= tcv;
  end process CNT_PROCESS;


end architecture BEH;
