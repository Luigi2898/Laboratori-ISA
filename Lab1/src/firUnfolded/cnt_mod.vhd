library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cnt_mod is
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
end entity cnt_mod;

architecture beh of cnt_mod is
    
begin
    cnt_process : process (clk,rstn,tc_ack)

    variable flag : std_logic := '1';
    variable tcv : std_logic := '0';
    variable cnt : integer := 0;
    
    begin

    

    if (rstn = '0') then
        cnt := 0;
        tcv := '0';
        flag := '1';
    elsif (clk'event and clk = '1') then
        if (en_cnt = '1') then
            cnt := cnt + 1;
            if (cnt = MODULE + 1) then
                cnt := 1;
            end if;
        end if;
    end if;

    if (cnt = MODULE) then
        tcv := '1';
    else
        tcv := '0';
        flag := '1';
    end if;
    
    if (tc_ack = '1') then
        flag := '0';
    end if;

    tc <= tcv and flag;
    cnt_out <= to_unsigned(cnt,N);

end process;

end architecture beh;
