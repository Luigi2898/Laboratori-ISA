library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity myfir_cupipe_unfolded is
  port (
    clk : in std_logic;
    rst_n : in std_logic;
    start_pipe : in std_logic;
    load_res2 : out std_logic;
    load_res3 : out std_logic;
    load_res4 : out std_logic;
    load_res5 : out std_logic;
    start_out : out std_logic
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

  signal load_res_chain : std_logic_vector (4 downto 0);
  signal vdd : std_logic;

begin

  vdd <= '1';
  load_res_chain(0) <= start_pipe;
  load_res2 <= load_res_chain(1);
  load_res3 <= load_res_chain(2);
  load_res4 <= load_res_chain(3);
  load_res5 <= load_res_chain(4);
  start_out <= load_res_chain(4); 

  load_res_ff_gen : for i in 0 to 3 generate
    load_ff : ff port map (load_res_chain(i),load_res_chain(i+1),clk,rst_n,vdd);
  end generate;



end architecture beh  ;