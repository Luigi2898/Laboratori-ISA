
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

begin

  CNT_PROCESS : process (clk, rstn, tc_ack) is

    variable flag : std_logic;
    variable tcv  : std_logic;
    variable cnt  : unsigned (N downto 0);

  begin

    if (rstn = '0') then
      cnt  := (others => '0');
      tcv  := '0';
      flag := '1';
    elsif (clk'event and clk = '1') then
      if (en_cnt = '1') then
        cnt := cnt + 1;
        if (cnt = MODULE + 1) then
          cnt := to_unsigned(1,N+1);
        end if;
      end if;
    end if;

    if (cnt = MODULE) then
      tcv := '1';
    else
      tcv  := '0';
      flag := '1';
    end if;

    if (tc_ack = '1') then
      flag := '0';
    end if;

    tc      <= tcv and flag;
    cnt_out <= cnt(N-1 downto 0);

  end process CNT_PROCESS;

end architecture BEH;
