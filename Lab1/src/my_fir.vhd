library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity my_fir is
  port (
    clk   : in std_logic;
    rst_n : in std_logic;
    din   : in signed(10 downto 0);
    vin   : in std_logic;
    h0    : in signed(10 downto 0);
    h1    : in signed(10 downto 0);
    h2    : in signed(10 downto 0);
    h3    : in signed(10 downto 0);
    dout  : out signed(10 downto 0);
    vout  : out std_logic
  ) ;
end my_fir ; 

architecture beh of my_fir is

begin
    out : process( clk )
    begin
        if clk'event and clk = 1 then
            dout <= "10101010101";
        end if ;
    end process ; -- out

end architecture ;