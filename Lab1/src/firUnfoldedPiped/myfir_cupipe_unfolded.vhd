library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity myfir_cupipe_unfolded is
  port (
    clk : in std_logic;
    rst_n : in std_logic;
    start_pipe : in std_logic;
    load_res2 : out std_logic;
    start_out : inout std_logic
  ) ;
end entity myfir_cupipe_unfolded;

architecture beh of myfir_cupipe_unfolded is

  component FF is
    port (
      FF_IN          : in STD_LOGIC;
      FF_OUT         : out STD_LOGIC;
      CLK, RST, LOAD : in STD_LOGIC
    );
  end component;

  signal vdd : std_logic;

begin

  vdd <= '1';
  load_res2 <= start_out;


 
  load_ff : ff port map (start_pipe,start_out,clk,rst_n,vdd);



end architecture beh  ;
