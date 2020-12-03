library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.array_std.all;


entity fake_DADDA is
  generic(N : integer := 33; N_PP : integer := 17);
  port (
    PP      : in  PP_array;
    PP_sign : in  std_logic_vector (N / 2 downto 0);
    SUM     : out std_logic_vector (2 * N - 1 downto 0)
  ) ;
end fake_DADDA;

architecture structural of fake_DADDA is
  
    signal normal_inputs : PP_array;

begin

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