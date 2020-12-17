library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    --use work.array_std.all;


entity fake_DADDA is
  generic(N : integer := 33; N_PP : integer := 17);
  port (
    	 PP1 : in std_logic_vector(N-1 downto 0);
         PP2 : in std_logic_vector(N-1 downto 0);	
		 PP3 : in std_logic_vector(N-1 downto 0);
		 PP4 : in std_logic_vector(N-1 downto 0);
		 PP5 : in std_logic_vector(N-1 downto 0);
		 PP6 : in std_logic_vector(N-1 downto 0);
		 PP7 : in std_logic_vector(N-1 downto 0);
		 PP8 : in std_logic_vector(N-1 downto 0);
		 PP9 : in std_logic_vector(N-1 downto 0);
		 PP10: in std_logic_vector(N-1 downto 0);
		 PP11: in std_logic_vector(N-1 downto 0);
		 PP12: in std_logic_vector(N-1 downto 0);
		 PP13: in std_logic_vector(N-1 downto 0);
		 PP14: in std_logic_vector(N-1 downto 0);
		 PP15: in std_logic_vector(N-1 downto 0);
		 PP16: in std_logic_vector(N-1 downto 0);
		 PP17: in std_logic_vector(N-1 downto 0);
         PP_sign : in  std_logic_vector (N / 2 downto 0);
         SUM     : out std_logic_vector (2 * N-2 downto 0)
  ) ;
end fake_DADDA;

architecture beh of fake_DADDA is
  
	type pp_out_sign is array (16 downto 0) of std_logic_vector(64 downto 0);
	signal PP : pp_out_sign;
	signal zero_padding : std_logic_vector (32 downto 0);

begin
	
	

	
	PP(0) <= (64 downto 33 => PP_sign(0)) & (signed(PP1)+1);
	PP(1) <= (64 downto 33 => PP_sign(1))  & (PP2);
	PP(2) <= (64 downto 33 => PP_sign(2))  & (PP3);
	PP(3) <= (64 downto 33 => PP_sign(3))  & (PP4);
	PP(4) <= (64 downto 33 => PP_sign(4))  & (PP5);
	PP(5) <= (64 downto 33 => PP_sign(5))  & (PP6);
	PP(6) <= (64 downto 33 => PP_sign(6))  & (PP7);
	PP(7) <= (64 downto 33 => PP_sign(7))  & (PP8);
	PP(8) <= (64 downto 33 => PP_sign(8))  & (PP9);
	PP(9) <= (64 downto 33 => PP_sign(9))  & (PP10);
	PP(10) <= (64 downto 33 => PP_sign(10))  & (PP11);
	PP(11) <= (64 downto 33 => PP_sign(11))  & (PP12);
	PP(12) <= (64 downto 33 => PP_sign(12))  & (PP13);
	PP(13) <= (64 downto 33 => PP_sign(13))  & (PP14);
	PP(14) <= (64 downto 33 => PP_sign(14))  & (PP15);
	PP(15) <= (64 downto 33 => PP_sign(15))  & (PP16);
	PP(16) <= (64 downto 33 => PP_sign(16))  & (PP17);


    MBE_decoder : process(PP, PP_sign)

    variable sum_v : signed (64 downto 0);
	variable to_sum_tmp : std_logic_vector (31 downto 0);
	variable to_sum : std_logic_vector (32 downto 0);

	begin

	sum_v := (others => '0');
	to_sum_tmp := (others => '0');
	to_sum := to_sum_tmp & '1';
		
		for i in 0 to 16 loop
			if (PP_sign(i) = '0') then
				sum_v := sum_v + shift_left((signed(PP(i))),2*i);
			else
				sum_v := sum_v + shift_left((signed(PP(i))+signed(to_sum_tmp)),2*i);
			end if;	
		end loop;
	
	SUM <= std_logic_vector(sum_v);

    end process;
    

end architecture ;
