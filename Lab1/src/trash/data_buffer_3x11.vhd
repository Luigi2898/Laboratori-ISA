
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity DATA_BUFFER_3X11 is
  generic (
    W     : positive:= 3;
    B     : positive:= 11;
    LOG2W : positive:= 2
  );
  port (
    CLK       : in    std_logic;
    DATA_IN   : in    signed (11 - 1 downto 0);
    BUFF_ON   : in    std_logic;
    LOAD      : in    std_logic;
    FLUSH     : in    std_logic;
    RST_N     : in    std_logic;
    RST_CNT_0 : in    std_logic;
    RST_CNT_1 : in    std_logic;
    DATA_OUT0 : out   signed (11 - 1 downto 0);
    DATA_OUT1 : out   signed (11 - 1 downto 0);
    DATA_OUT2 : out   signed (11 - 1 downto 0);
    BUFF_FULL : out   std_logic
  );
end entity DATA_BUFFER_3X11;

architecture BEH of DATA_BUFFER_3X11 is

  ---------------------------------------------

  component REG is
    port (
      REG_IN  : in    signed(10 downto 0);
      REG_OUT : out   signed(10 downto 0);
      CLK     : in    std_logic
      RST_N   : in    std_logic
      LOAD    : in    std_logic
    );
  end component;

  component COUNTER_MODULO_N is
    generic (
      N : positive:= 4;
      F : unsigned:= "1111";
      S : integer:= 0
    );
    port (
      ENABLE   : in    std_logic;
      CLOCK_50 : in    std_logic;
      RESET_0N : in    std_logic;
      RESET_1N : in    std_logic;
      TC       : out   std_logic;
      CNT      : buffer unsigned (n - 1 downto 0)
    );
  end component;

  --------------------------------------------------

  type buffer_type is array (W downto 0) of signed (B - 1 downto 0);

  signal buffer_content : buffer_type;
  signal cnt_out        : unsigned (log2W - 1 downto 0);
  signal rst_signal     : std_logic;
  signal rst_n_internal : std_logic;
  signal rst_cnt_0n     : std_logic;
  signal rst_cnt_1n     : std_logic;
  signal gnd            : std_logic := '0';
  -------------------------------------------------------------------------------------

begin

  -------------------------------------------------------------------------------------

  BUFF_REG_GEN : for i in 0 to W generate

    BUFF_REG_GEN1 : if (i = 0) generate

      BUFF_REG : REG
        port map (
          REG_IN  => data_in,
          REG_OUT => buffer_content(i),
          CLK     => clk,
          RST_N   => rst_n,
          LOAD    => buff_on
        );

    end generate BUFF_REG_GEN1;

    BUFF_REG_GEN2 : if (i > 0)  generate

      BUFF_REG : REG
        port map (
          REG_IN  => buffer_content(i - 1),
          REG_OUT => buffer_content(i),
          CLK     => clk,
          RST_N   => rst_n_internal,
          LOAD    => load
        );

    end generate BUFF_REG_GEN2;

  end generate BUFF_REG_GEN;

  -------------------------------------------------------------------------------------
  CNT : COUNTER_MODULO_N
    generic map (2, "11", 1
    )
    port map (load, clk, rst_cnt_0n, rst_cnt_1n, buff_full, cnt_out;
  )
      -------------------------------------------------------------------------------------
      rst_cnt_0n     <= (not(rst_cnt_0) and (rst_n_internal));
      rst_cnt_1n     <= not(rst_cnt_1);
      rst_n_internal <= not(not(rst_n) or flush);
      data_out0      <= buffer_content(1);
      data_out1      <= buffer_content(2);
      data_out2      <= buffer_content(3);
      -------------------------------------------------------------------------------------
end architecture beh;












