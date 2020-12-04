library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.array_std.all;


entity fake_DADDA is
  generic(N : integer := 33; N_PP : integer := 17);
  port (
    PP      : in  PP_array;
    PP_sign : in  std_logic_vector (N / 2 downto 0);
    SUM     : out std_logic_vector (2 * N - 3 downto 0)
  ) ;
end fake_DADDA;

architecture structural of fake_DADDA is
  
  
    type pp_out_ext is array (16 downto 0) of signed(63 downto 0);
    type pp_out_sign is array (16 downto 0) of signed(32 downto 0);
    signal tmp2, tmp3 : pp_out_ext;
    signal tmp1 : pp_out_sign;
   
begin



    MBE_decoder : process(PP, PP_sign)
          variable pp_out_2scomp : pp_out_sign;
          variable pp_out_2scomp_ext : pp_out_ext;
		  variable add_out : pp_out_ext;
		  begin
		  
		  for i in 0 to 16 loop
		  if(PP_sign(i) = '1') then
			pp_out_2scomp(i) := signed(PP(i)) + 1;
		  else
		    pp_out_2scomp(i) := signed(PP(i));	
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
