
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity TB_CNT_MOD is
end entity TB_CNT_MOD;

architecture TB of TB_CNT_MOD is

  component CNT_MOD is
    generic (
      N      : positive := 2;
      MODULE : integer := 3
    );
    port (
      CLK     : in    std_logic;
      RSTN    : in    std_logic;
      EN_CNT  : in    std_logic;
      TC_ACK  : in    std_logic;
      TC      : out   std_logic;
      CNT_OUT : out   unsigned (N - 1 downto 0)
    );
  end component cnt_mod;

  signal clk     : std_logic
  signal rstn    : std_logic
  signal tc      : std_logic
  signal en_cnt  : std_logic
  signal tc_ack  : std_logic
  signal cnt_out : unsigned (2 - 1 downto 0);

begin

  CLK_PROCESS : process
  begin

    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;

  end process CLK_PROCESS;

  RSTN_PROCESS : process
  begin

    rstn <= '1';
    wait for 10 ns;
    rstn <= '0';
    wait for 11 ns;
    rstn <= '1';
    wait for 1 sec;

  end process RSTN_PROCESS;

  TEST_PROCESS : process (clk) is

    variable flag : std_logic := '0';

  begin

    if (clk'event and clk = '1') then
      if (tc = '1' and flag = '0') then
        tc_ack <= '1';
        flag := '1';
      else
        tc_ack <= '0';
      end if;
    end if;

  end process TEST_PROCESS;

  DUT : CNT_MOD
    generic map (2, 3
    )
    port map (clk, rstn, en_cnt, tc_ack, tc, cnt_out;
  )

      ENABLE_PROCESS : process
      begin

        en_cnt <= '1';
        wait for 71 ns;
        en_cnt <= '0';
        wait for 70 ns;
        en_cnt <= '1';
        wait for 1 sec;

      end process ENABLE_PROCESS;

end architecture tb;
