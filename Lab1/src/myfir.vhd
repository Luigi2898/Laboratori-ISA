library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity myfir is
  port (RST_N    : in std_logic;            -- External
        CLK      : in std_logic;            -- External
        VIN      : in std_logic;            -- External
        DIN      : in signed(10 downto 0);  -- External
        H0       : in signed(10 downto 0);  -- External
        H1       : in signed(10 downto 0);  -- External
        H2       : in signed(10 downto 0);  -- External
        H3       : in signed(10 downto 0);  -- External
        H4       : in signed(10 downto 0);  -- External
        H5       : in signed(10 downto 0);  -- External
        H6       : in signed(10 downto 0);  -- External
        H7       : in signed(10 downto 0);  -- External
        H8       : in signed(10 downto 0);  -- External
        DOUT     : out signed(10 downto 0); -- External
        VOUT     : out std_logic            -- External
  ) ;
end myfir ; 

architecture beh of myfir is

    component myfir_cu is
		port(CLK       : in std_logic;
			 RST_N     : in std_logic;
			 RST_N_FIR : out std_logic;
			 VIN       : in std_logic;
			 LOAD      : out std_logic;
			 VOUT      : out std_logic		
		);
    end component;

    component myfir_dp is
        port(RST_N    : in  std_logic;           -- Control unit
             ctrl_in  : in  std_logic;           -- Control unit
             ctrl_out : in  std_logic;           -- Control Unit
             CLK      : in  std_logic;           -- External
             DIN      : in  signed(10 downto 0); -- External
             H0       : in  signed(10 downto 0); -- External
             H1       : in  signed(10 downto 0); -- External
             H2       : in  signed(10 downto 0); -- External
             H3       : in  signed(10 downto 0); -- External
             H4       : in  signed(10 downto 0); -- External
             H5       : in  signed(10 downto 0); -- External
             H6       : in  signed(10 downto 0); -- External
             H7       : in  signed(10 downto 0); -- External
             H8       : in  signed(10 downto 0); -- External
             DOUT     : out signed(10 downto 0) -- External
            );
    end component;
    
    -- Control signals
    signal rst_n_dp    : std_logic;
    signal ctrl_in_dp  : std_logic;
    signal ctrl_out_dp : std_logic;

begin

    CU : myfir_cu port map(clk => clk, rst_n => rst_n, rst_n_fir => rst_n_dp, vin => vin, load => ctrl_in_dp, vout => ctrl_out_dp);

    DP : myfir_dp port map(rst_n => rst_n_dp, ctrl_in => ctrl_in_dp, ctrl_out => ctrl_out_dp, clk => clk, DIN => DIN,
                           H0 => H0, H1 => H1, H2 => H2, H3 => H3, H4 => H4, H5 => H5, H6 => H6, H7 => H7, H8 => H8,
                           dout => dout);
    
    vout <= ctrl_out_dp;

end architecture ;