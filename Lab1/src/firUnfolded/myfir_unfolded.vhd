
library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.NUMERIC_STD.all;

entity MYFIR_UNFOLDED is
  port (
    CLK                                      : in    std_logic;
    RST_N                                    : in    std_logic;
    DIN                                      : in    signed (10 downto 0);
    VIN                                      : in    std_logic;
    H0                                       : in    signed(10 downto 0);
    H1                                       : in    signed(10 downto 0);
    H2                                       : in    signed(10 downto 0);
    H3                                       : in    signed(10 downto 0);
    H4                                       : in    signed(10 downto 0);
    H5                                       : in    signed(10 downto 0);
    H6                                       : in    signed(10 downto 0);
    H7                                       : in    signed(10 downto 0);
    H8                                       : in    signed(10 downto 0);
    DOUT                                     : out   signed (10 downto 0);
    VOUT                                     : out   std_logic
  );
end entity MYFIR_UNFOLDED;

architecture BEH of MYFIR_UNFOLDED is

  component MYFIR_DP_UNFOLDED is
    port (
      CLK                                      : in    std_logic;
      RST_N                                    : in    std_logic;
      DIN                                      : in    signed(10 downto 0);
      LOAD_BUFF                                : in    std_logic;
      LOAD_STATE                               : in    std_logic;
      BUFF_ON                                  : in    std_logic;
      LOAD_OUT                                 : in    std_logic;
      LOAD_RES                                 : in    std_logic;
      TC_ACK_IN                                : in    std_logic;
      EN_CNT_MUX                               : in    std_logic;
      EN_CNT_IN                                : in    std_logic;
      H0                                       : in    signed(10 downto 0);
      H1                                       : in    signed(10 downto 0);
      H2                                       : in    signed(10 downto 0);
      H3                                       : in    signed(10 downto 0);
      H4                                       : in    signed(10 downto 0);
      H5                                       : in    signed(10 downto 0);
      H6                                       : in    signed(10 downto 0);
      H7                                       : in    signed(10 downto 0);
      H8                                       : in    signed(10 downto 0);
      TC_CNT_IN                                : out   std_logic;
      TC_CNT_MUX                               : out   std_logic;
      DOUT                                     : out   signed(10 downto 0)
    );
  end component myfir_dp_unfolded;

  component MYFIR_CUINPUTS_UNFOLDED is
    port (
      CLK            : in    std_logic;
      RST_N          : in    std_logic;
      TC_CNT_IN      : in    std_logic;
      VIN            : in    std_logic;
      LOAD_BUFF      : out   std_logic;
      STATE_LOAD     : out   std_logic;
      EN_CNT_IN      : out   std_logic;
      BUFF_ON        : out   std_logic;
      TC_ACK_IN      : out   std_logic;
      LOAD_FIRST_RES : out   std_logic;
      START_PIPE     : out   std_logic
    );
  end component myfir_cuinputs_unfolded;

  component MYFIR_CUOUTPUTS_UNFOLDED is
    port (
      CLK        : in    std_logic;
      RST_N      : in    std_logic;
      START      : in    std_logic;
      TC_CNT_MUX : in    std_logic;
      EN_CNT_MUX : out   std_logic;
      LOAD_OUT   : inout std_logic;
      VOUT       : out   std_logic
    );
  end component myfir_cuoutputs_unfolded;

  signal load_buff  : std_logic;
  signal buff_on    : std_logic;
  signal flush      : std_logic;
  signal load_out   : std_logic;
  signal load_res   : std_logic;
  signal en_cnt_mux : std_logic;
  signal tc_ack_in  : std_logic;
  signal tc_cnt_mux : std_logic;
  signal tc_cnt_in  : std_logic;
  signal start_out  : std_logic;
  signal rst_cnt_1  : std_logic;
  signal state_load : std_logic;
  signal en_cnt_in  : std_logic;

begin

  DATAPATH : MYFIR_DP_UNFOLDED
    port map (
    clk, rst_n, DIN, load_buff, state_load, buff_on, load_out,
    load_res, tc_ack_in, en_cnt_mux, en_cnt_in, H0, H1, H2, H3, H4, H5, H6, H7, H8, tc_cnt_in, tc_cnt_mux, DOUT);

  CU_INPUTS : MYFIR_CUINPUTS_UNFOLDED
    port map (
    clk, rst_n, tc_cnt_in, VIN, load_buff, state_load, en_cnt_in, buff_on,
    tc_ack_in, load_res, start_out);

  CU_OUTPUTS : MYFIR_CUOUTPUTS_UNFOLDED
    port map (clk, rst_n, start_out, tc_cnt_mux, en_cnt_mux, load_out, VOUT);

end architecture BEH;
