
library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.NUMERIC_STD.all;

entity MYFIR_CUINPUTS_UNFOLDED is
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
end entity MYFIR_CUINPUTS_UNFOLDED;

architecture BEH of MYFIR_CUINPUTS_UNFOLDED is

  type state_type is (
    rst, idle, load_buffs, load_state, load_res, load_buff_res,
    load_buff_state, load_buff_state_res, load_state_res
  );

  signal state : state_type;
  signal vdd   : std_logic;

begin

  STATE_TRANSITION_PROCESS : process(clk, rst_n) is
  begin

    if (rst_n = '0') then
      state <= rst;
    elsif (clk'event and clk = '1') then

      case state is

        when rst =>
          state <= idle;

        when idle =>
          if (vin = '1' and tc_cnt_in = '0') then
            state <= load_buffs;
          elsif (vin = '1' and tc_cnt_in = '1') then
            state <= load_buff_res;
          elsif (vin = '0' and tc_cnt_in = '1') then
            state <= load_res;
          elsif (vin = '0' and tc_cnt_in = '0') then
            state <= idle;
          else
            state <= idle;
          end if;

        when load_buffs =>
          if (vin = '1' and tc_cnt_in = '0') then
            state <= load_buff_state;
          elsif (vin = '1' and tc_cnt_in = '1') then
            state <= load_buff_state_res;
          elsif (vin = '0' and tc_cnt_in = '1') then
            state <= load_state_res;
          elsif (vin = '0' and tc_cnt_in = '0') then
            state <= load_state;
          else
            state <= load_state;
          end if;

        when load_state =>
          if (vin = '1' and tc_cnt_in = '0') then
            state <= load_buffs;
          elsif (vin = '1' and tc_cnt_in = '1') then
            state <= load_buff_res;
          elsif (vin = '0' and tc_cnt_in = '1') then
            state <= load_res;
          elsif (vin = '0' and tc_cnt_in = '0') then
            state <= idle;
          else
            state <= idle;
          end if;

        when load_buff_state =>
          if (vin = '1' and tc_cnt_in = '0') then
            state <= load_buff_state;
          elsif (vin = '1' and tc_cnt_in = '1') then
            state <= load_buff_state_res;
          elsif (vin = '0' and tc_cnt_in = '1') then
            state <= load_state_res;
          elsif (vin = '0' and tc_cnt_in = '0') then
            state <= load_state;
          else
            state <= load_state;
          end if;

        when load_buff_state_res =>
          if (vin = '1') then
            state <= load_buff_state;
          else
            state <= load_state;
          end if;

        when load_state_res =>
          if (vin = '1') then
            state <= load_buffs;
          else
            state <= idle;
          end if;

        when load_buff_res =>
          if (vin = '1') then
            state <= load_buff_state;
          else
            state <= load_state;
          end if;

        when load_res =>
          if (vin = '1') then
            state <= load_buffs;
          else
            state <= idle;
          end if;

      end case;

    end if;

  end process STATE_TRANSITION_PROCESS;

  OUTPUT_EVALUATION_PROCESS : process(state) is
  begin

    load_buff      <= '0';
    buff_on        <= '1';
    start_pipe     <= '0';
    tc_ack_in      <= '0';
    load_first_res <= '0';
    state_load     <= '0';
    en_cnt_in      <= '0';

    case state is

      when rst =>

      when idle =>

      when load_buffs =>
        load_buff <= '1';
        en_cnt_in <= '1';

      when load_state =>
        state_load <= '1';

      when load_buff_state =>
        load_buff  <= '1';
        en_cnt_in  <= '1';
        state_load <= '1';

      when load_buff_state_res =>
        load_buff      <= '1';
        en_cnt_in      <= '1';
        state_load     <= '1';
        tc_ack_in      <= '1';
        load_first_res <= '1';
        start_pipe     <= '1';

      when load_state_res =>
        state_load     <= '1';
        tc_ack_in      <= '1';
        load_first_res <= '1';
        start_pipe     <= '1';

      when load_buff_res =>
        load_buff      <= '1';
        en_cnt_in      <= '1';
        tc_ack_in      <= '1';
        load_first_res <= '1';
        start_pipe     <= '1';

      when load_res =>
        tc_ack_in      <= '1';
        load_first_res <= '1';
        start_pipe     <= '1';

    end case;

  end process OUTPUT_EVALUATION_PROCESS;

end architecture BEH;
