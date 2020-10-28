library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_cnt_mod is
end entity tb_cnt_mod;

architecture tb of tb_cnt_mod is

    component cnt_mod is
        generic (
            N : positive := 2;
            MODULE : integer := 3
            );
        port (
            clk : in std_logic;
            rstn : in std_logic;
            en_cnt : in std_logic;
            tc_ack : in std_logic;
            tc : out std_logic;
            cnt_out : out unsigned (N-1 downto 0)
            );
    end component cnt_mod;

    signal clk,rstn,tc,en_cnt,tc_ack : std_logic := '0';
    signal cnt_out : unsigned (2-1 downto 0);

begin

    clk_process : process 
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    rstn_process : process
    begin
        rstn <= '1';
        wait for 10 ns;
        rstn <= '0';
        wait for 11 ns;
        rstn <= '1';
        wait for 1 sec;
    end process;

    test_process : process (clk)
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
    end process;

    dut : cnt_mod generic map (2,3) port map (clk,rstn,en_cnt,tc_ack,tc,cnt_out);

    enable_process : process 
    begin
        en_cnt <= '1';
        wait for 71 ns;
        en_cnt <= '0';
        wait for 70 ns;
        en_cnt <= '1';
        wait for 1 sec;
    end process;



end architecture tb;