library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity myfir_unfolded is
  port (
    clk                                      : in std_logic;
    rst_n                                    : in std_logic;
    DIN                                      : in signed (10 downto 0);
    VIN                                      : in std_logic;
    H0                                       : in signed(10 downto 0);
    H1                                       : in signed(10 downto 0);
    H2                                       : in signed(10 downto 0);
    H3                                       : in signed(10 downto 0);
    H4                                       : in signed(10 downto 0);
    H5                                       : in signed(10 downto 0);
    H6                                       : in signed(10 downto 0);
    H7                                       : in signed(10 downto 0);
    H8                                       : in signed(10 downto 0);
    STATE0_DEBUG, STATE1_DEBUG, STATE2_DEBUG : out signed (10 downto 0); -- DEBUG SIGNALS
    start_pipe_debug                         : out std_logic;            -- DEBUG SIGNAL
    DOUT                                     : out signed (10 downto 0);
    VOUT                                     : out std_logic
  );
end entity myfir_unfolded;

architecture beh of myfir_unfolded is

  component myfir_dp_unfolded is
    port (
      CLK                                      : in std_logic;
      RST_N                                    : in std_logic;
      DIN                                      : in signed(10 downto 0);
      LOAD_BUFF                                : in std_logic;
      LOAD_STATE                               : in std_logic;
      BUFF_ON                                  : in std_logic;
      LOAD_OUT                                 : in std_logic;
      LOAD_RES                                 : in std_logic;
      TC_ACK_IN                                : in std_logic;
      EN_CNT_MUX                               : in std_logic;
      EN_CNT_IN                                : in std_logic;
      H0                                       : in signed(10 downto 0);
      H1                                       : in signed(10 downto 0);
      H2                                       : in signed(10 downto 0);
      H3                                       : in signed(10 downto 0);
      H4                                       : in signed(10 downto 0);
      H5                                       : in signed(10 downto 0);
      H6                                       : in signed(10 downto 0);
      H7                                       : in signed(10 downto 0);
      H8                                       : in signed(10 downto 0);
      STATE0_DEBUG, STATE1_DEBUG, STATE2_DEBUG : out signed (10 downto 0); -- DEBUG SIGNALS
      TC_CNT_IN                                : out std_logic;
      TC_CNT_MUX                               : out std_logic;
      DOUT                                     : out signed(10 downto 0)
    );
  end component myfir_dp_unfolded;

  component myfir_cuinputs_unfolded is
    port (
      clk            : in std_logic;
      rst_n          : in std_logic;
      tc_cnt_in      : in std_logic;
      vin            : in std_logic;
      load_buff      : out std_logic;
      state_load     : out std_logic;
      en_cnt_in      : out std_logic;
      buff_on        : out std_logic;
      tc_ack_in      : out std_logic;
      load_first_res : out std_logic;
      start_pipe     : out std_logic
    );
  end component myfir_cuinputs_unfolded;

  component myfir_cuoutputs_unfolded is
    port (
      clk        : in std_logic;
      rst_n      : in std_logic;
      start      : in std_logic;
      tc_cnt_mux : in std_logic;
      en_cnt_mux : out std_logic;
      load_out   : inout std_logic;
      vout       : out std_logic
    );
  end component myfir_cuoutputs_unfolded;

  signal LOAD_BUFF, BUFF_ON, FLUSH, LOAD_OUT, LOAD_RES, EN_CNT_MUX,
  TC_ACK_IN, TC_CNT_MUX, TC_CNT_IN, START_OUT, RST_CNT_1, STATE_LOAD,
  EN_CNT_IN : std_logic;

  --signal STATE0_DEBUG,STATE1_DEBUG,STATE2_DEBUG : signed (10 downto 0);

begin

  datapath : myfir_dp_unfolded port map(
    clk, rst_n, DIN, load_buff, state_load, buff_on, load_out,
    load_res, tc_ack_in, en_cnt_mux, en_cnt_in, H0, H1, H2, H3, H4, H5, H6, H7, H8, STATE0_DEBUG, STATE1_DEBUG, STATE2_DEBUG, tc_cnt_in, tc_cnt_mux, DOUT);

  cu_inputs : myfir_cuinputs_unfolded port map(
    clk, rst_n, tc_cnt_in, VIN, load_buff, state_load, en_cnt_in, buff_on,
    tc_ack_in, load_res, start_out);

  cu_outputs : myfir_cuoutputs_unfolded port map(clk, rst_n, start_out, tc_cnt_mux, en_cnt_mux, load_out, VOUT);

  start_pipe_debug <= start_out;

end architecture beh;