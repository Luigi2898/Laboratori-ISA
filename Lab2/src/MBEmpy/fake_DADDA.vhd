library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    --use work.array_std.all;


entity fake_DADDA is
  generic(N : integer := 33; N_PP : integer := 17);
  port (
    PP1,PP2,PP3,PP4,PP5,        : in std_logic_vector (N - 1 downto 0);
	PP6,PP7,PP8,PP9,PP10,   	: in std_logic_vector (N - 1 downto 0);
	PP11,PP12,PP13,PP14,PP15,	: in std_logic_vector (N - 1 downto 0);
	PP16,PP17					: in std_logic_vector (N - 1 downto 0);   
	PP_sign : in  std_logic_vector (N / 2 downto 0);
    SUM     : out std_logic_vector (2 * N - 1 downto 0)
  ) ;
end fake_DADDA;

architecture sim of fake_DADDA is
  
    type inputs_type is array (N_PP-1 downto 0) of std_logic_vector (N - 1 downto 0);
	signal normal_inputs : inputs_type;

begin
	
	normal_inputs(0) <= PP1;
	normal_inputs(1) <= PP2;
	normal_inputs(2) <= PP3;
	normal_inputs(3) <= PP4;
	normal_inputs(4) <= PP5;
	normal_inputs(5) <= PP6;
	normal_inputs(6) <= PP7;
	normal_inputs(7) <= PP8;
	normal_inputs(8) <= PP9;
	normal_inputs(9) <= PP10;
	normal_inputs(10) <= PP11;
	normal_inputs(11) <= PP12;
	normal_inputs(12) <= PP13;
	normal_inputs(13) <= PP14;
	normal_inputs(14) <= PP15;
	normal_inputs(15) <= PP16;
	normal_inputs(16) <= PP17;

	

    MBE_decoder : process (PP_sign,PP)
    variable tmp_sum : integer;
    begin
        tmp_sum := 0; 
        for i in 0 to N_PP-1 loop
            if (PP_sign(i) = '0') then
                normal_inputs(i) <= PP(i);
            else
                normal_inputs(i) <= not(PP(i));
            end if;
            tmp_sum := tmp_sum + to_integer(unsigned(normal_inputs(i)));
        end loop;
    SUM <= std_logic_vector(to_unsigned(tmp_sum,2*N));
    end process;

    

end architecture ;
