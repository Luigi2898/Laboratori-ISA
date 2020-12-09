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
         SUM     : out std_logic_vector (2 * N - 3 downto 0)
  ) ;
end fake_DADDA;

architecture structural of fake_DADDA is
  
  
    type pp_out_ext is array (16 downto 0) of signed(63 downto 0);
    type pp_out_sign is array (16 downto 0) of signed(32 downto 0);
    signal tmp2, tmp3 : pp_out_ext;
    signal tmp1 : pp_out_sign;
	signal PP : pp_out_sign;
   
begin

PP(0)  <= signed(PP1);
PP(1)  <= signed(PP2);
PP(2)  <= signed(PP3);
PP(3)  <= signed(PP4);
PP(4)  <= signed(PP5);
PP(5)  <= signed(PP6);
PP(6)  <= signed(PP7);
PP(7)  <= signed(PP8);
PP(8)  <= signed(PP9);
PP(9)  <= signed(PP10);
PP(10) <= signed(PP11);
PP(11) <= signed(PP12);
PP(12) <= signed(PP13);
PP(13) <= signed(PP14);
PP(14) <= signed(PP15);
PP(15) <= signed(PP16);
PP(16) <= signed(PP17);


    MBE_decoder : process(PP, PP_sign)
          variable pp_out_2scomp : pp_out_sign;
          variable pp_out_2scomp_ext : pp_out_ext;
		  variable add_out : pp_out_ext;
		  begin
		  
		  for i in 0 to 16 loop
		  if(PP_sign(i) = '1') then
			pp_out_2scomp(i) := PP(i) + 1;
		  else
		    pp_out_2scomp(i) := PP(i);	
		  end if;
          tmp1(i) <= pp_out_2scomp(i); 
		  if(to_integer(tmp1(i)(31 downto 0)) = 0) then
			pp_out_2scomp_ext(i)(63 downto 33) := (others => '0');		     
          else pp_out_2scomp_ext(i)(63 downto 33) := (others => PP_sign(i));
          end if;
          pp_out_2scomp_ext(i)(32 downto 0) := pp_out_2scomp(i);
          tmp2(i) <= pp_out_2scomp_ext(i);
		  end loop;
		  
		  add_out(0) := pp_out_2scomp_ext(0);
          tmp3(0) <= add_out(0);
		  for i in 1 to 16 loop
		  add_out(i) := add_out(i-1) + SHIFT_LEFT(pp_out_2scomp_ext(i), 2*i);
          tmp3(i) <= add_out(i);
		  end loop;	  
		  SUM <= std_logic_vector(add_out(16));
		  end process;

    

end architecture ;
