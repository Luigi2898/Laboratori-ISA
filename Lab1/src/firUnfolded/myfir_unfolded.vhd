library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity myfir_unfolded is
    port (
        clk : in std_logic;
        rst_n : in std_logic;
        DIN : in signed (10 downto 0);
        VIN : in std_logic;
        H0: in signed(10 downto 0);
        H1: in signed(10 downto 0);
        H2: in signed(10 downto 0);
        H3: in signed(10 downto 0);
        H4: in signed(10 downto 0);
        H5: in signed(10 downto 0);
        H6: in signed(10 downto 0);
        H7: in signed(10 downto 0);
        H8: in signed(10 downto 0);
        DOUT : out signed (10 downto 0);
        VOUT : out std_logic             
    );
end entity myfir_unfolded;

architecture beh of myfir_unfolded is
    
    component myfir_dp_unfolded is
        port(
        CLK: in std_logic;
        RST_N: in std_logic;
        DIN: in signed(10 downto 0);
        LOAD_BUFF : in std_logic;
        BUFF_ON : in std_logic;
        FLUSH : in std_logic;
        LOAD_STATE : in std_logic;
        LOAD_OUT : in std_logic;
        LOAD_RES : in std_logic;
        EN_CNT_MUX : in std_logic;
        H0: in signed(10 downto 0);
        H1: in signed(10 downto 0);
        H2: in signed(10 downto 0);
        H3: in signed(10 downto 0);
        H4: in signed(10 downto 0);
        H5: in signed(10 downto 0);
        H6: in signed(10 downto 0);
        H7: in signed(10 downto 0);
        H8: in signed(10 downto 0);
        BUFF_FULL : out std_logic;
        TC_CNT_MUX : out std_logic;
        DOUT: out signed(10 downto 0)
            );
    end component myfir_dp_unfolded;

    component myfir_cuinputs_unfolded is
        port (
          clk : in std_logic;
          rst_n : in std_logic;
          buff_full : in std_logic;
          vin : in std_logic;
          load_state : out std_logic;
          load_buff : out std_logic;
          load_res : out std_logic;
          buff_on : out std_logic;
          flush : out std_logic;
          start_out : out std_logic    
        ) ;
    end component myfir_cuinputs_unfolded;

    component myfir_cuoutputs_unfolded is
        port (
          clk : in std_logic;
          rst_n : in std_logic;
          start : in std_logic;
          tc_cnt_mux : in std_logic;
          en_cnt_mux : out std_logic;
          load_out : inout std_logic;
          vout : out std_logic    
        ) ;
    end component myfir_cuoutputs_unfolded;

    signal LOAD_BUFF, BUFF_ON, FLUSH, LOAD_STATE, LOAD_OUT, LOAD_RES, EN_CNT_MUX,
    BUFF_FULL, TC_CNT_MUX, start_out : std_logic;

begin

    datapath : myfir_dp_unfolded port map (clk,rst_n,DIN,load_buff,buff_on,flush,
                load_state,load_out,load_res,en_cnt_mux,H0,H1,H2,H3,H4,H5,H6,H7,H8,
                buff_full,tc_cnt_mux,DOUT);

    cu_inputs : myfir_cuinputs_unfolded port map (clk,rst_n,buff_full,VIN,load_state,
                load_buff,load_res,buff_on,flush,start_out);

    cu_outputs : myfir_cuoutputs_unfolded port map (clk,rst_n,start_out,tc_cnt_mux,en_cnt_mux,load_out,VOUT);


    
    
    
end architecture beh;