LIBRARY ieee;
LIBRARY ieee_proposed;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee_proposed.array_std.all;


ENTITY mbe_ppg is
    GENERIC(N : INTEGER := 32; N_PP : INTEGER := 17);
	PORT(A : in std_logic_vector(N-1 downto 0);
		 B : in std_logic_vector(N-1 downto 0);
		 S : out std_logic_vector(N/2 downto 0);
		 PP: out PP_array	
	);
END ENTITY;

ARCHITECTURE BEH OF mbe_ppg is

COMPONENT BEU is
	PORT(y      : in std_logic_vector(2 downto 0);
		 s      : out std_logic;
		 decode : out std_logic_vector(2 downto 0)
	    );
END COMPONENT;

COMPONENT MUX3XNTO1XN is
  generic (
    N : integer := 32
  );
  port (
    IN_MUX0 : in    std_logic_vector (N downto 0);
    IN_MUX1 : in    std_logic_vector (N downto 0);
    IN_MUX2 : in    std_logic_vector (N downto 0);
    OUT_MUX : out   std_logic_vector (N downto 0);
    SEL_MUX : in    std_logic_vector (2 downto 0)
  );
end COMPONENT MUX3XNTO1XN;

type beu_vect is array (N/2 downto 0) of std_logic_vector(2 downto 0);
type mux_vect is array (N/2 downto 0) of std_logic_vector(N downto 0);

signal sign          : std_logic_vector(N/2 downto 0);
signal in0, in1, in2 : std_logic_vector(N downto 0);
signal y_triplets    : std_logic_vector(N+1 downto 0);
signal out_mux_temp  : std_logic_vector(N downto 0);
signal pp_comp_temp  : std_logic_vector(N downto 0);
signal beu_out       : beu_vect;
signal out_mux       : mux_vect;


BEGIN

in0 <= (others => '0');
in1 <= ('0' & A);
in2 <= ('0' & A(N-2 downto 0) & '0');
y_triplets <= "00" & B;


BEU_GEN : FOR I IN 0 TO 16 GENERATE 
	      BEU_GEN0 : IF(I = 0) GENERATE 
		             BEU0 :BEU PORT MAP(y_triplets(1 downto 0) & '0', sign(i), beu_out(i));
				     END GENERATE;
	      BEU_GEN1 : IF(I > 0) GENERATE		
	                 BEU1: BEU PORT MAP(y_triplets(2*i+1 downto 2*i-1),  sign(i), beu_out(i));
			         END GENERATE;
          END GENERATE BEU_GEN;

S <= sign;
		
MUX_GEN : FOR I IN 0 TO 16 GENERATE 
	      MUX_GEN0 : IF(I = 0) GENERATE 
		             MUX0 :MUX3XNTO1XN GENERIC MAP(N => 32) PORT MAP(in0, in1, in2, out_mux(i), beu_out(i));
				     END GENERATE;
		  MUX_GEN1 : IF(I > 0) GENERATE		
	                 MUX1: MUX3XNTO1XN GENERIC MAP(N => 32) PORT MAP(in0, in1, in2, out_mux(i), beu_out(i));
			         END GENERATE;
          END GENERATE MUX_GEN;		

comp1_proc : process(out_mux, sign, out_mux_temp, pp_comp_temp)
		   begin		   
		   for j in 0 to N_PP-1 loop
				out_mux_temp <= out_mux(j);
					for k in 0 to N-1 loop
					pp_comp_temp(k) <= out_mux_temp(k) xor sign(j);
					end loop;
				PP(j) <= pp_comp_temp;			 
		   end loop;					   
		   end process;



--q_j <= (others => '0') when (zero = '1') ELSE
--	   ('0' & A) when (x_1a = '1') ELSE
--	   ('0' & A(N-1 downto 1) & '0') when (x_2a = '1');
	   
-- ppg_proc : process(decode, ppg, pp_j, A, B) 
      
	  -- begin  
	  
	  -- case decode is
	  -- when "001" => q_j <= (others => '0');
	  -- when "010" => q_j <= ('0' & A);
	  -- when "100" => q_j <= ('0' & A(N-2 downto 0) & '0');
	  -- when others => q_j <= (others => '0');
	  -- end case;
	      
	  -- for i in 0 to q_j'length-1 loop
		  -- pp_j(i) <= (ppg(i) XOR q_j(i));
      -- end loop;
	  
      -- end process;
	  -- PP <= pp_j;

END ARCHITECTURE;