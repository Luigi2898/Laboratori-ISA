LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;



ENTITY mbe_ppg is
    GENERIC(N : INTEGER := 32; N_PP : INTEGER := 17);
	PORT(A   : in std_logic_vector(N-1 downto 0);
		 B   : in std_logic_vector(N-1 downto 0);
		 S   : out std_logic_vector(N/2 downto 0);
		 PP1 : out std_logic_vector(N downto 0);
         PP2 : out std_logic_vector(N downto 0);
		 PP3 : out std_logic_vector(N downto 0);
		 PP4 : out std_logic_vector(N downto 0);
		 PP5 : out std_logic_vector(N downto 0);
		 PP6 : out std_logic_vector(N downto 0);
		 PP7 : out std_logic_vector(N downto 0);
		 PP8 : out std_logic_vector(N downto 0);
		 PP9 : out std_logic_vector(N downto 0);
		 PP10: out std_logic_vector(N downto 0);
		 PP11: out std_logic_vector(N downto 0);
		 PP12: out std_logic_vector(N downto 0);
		 PP13: out std_logic_vector(N downto 0);
		 PP14: out std_logic_vector(N downto 0);
		 PP15: out std_logic_vector(N downto 0);
		 PP16: out std_logic_vector(N downto 0);
		 PP17: out std_logic_vector(N downto 0)
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
type out_vect is array (N/2 downto 0) of std_logic_vector(N downto 0);

signal sign          : std_logic_vector(N/2 downto 0);
signal in0, in1, in2 : std_logic_vector(N downto 0);
signal y_triplets    : std_logic_vector(N+1 downto 0);
signal y_triplet0    : std_logic_vector(2 downto 0);
signal beu_out       : beu_vect;
signal out_mux       : mux_vect;
signal pp_out_tmp    : out_vect;


BEGIN

in0 <= (others => '0');
in1 <= ('0' & A);
in2 <= A(N-1) & std_logic_vector(SHIFT_LEFT(unsigned(A),1));
y_triplets <= "00" & B;
y_triplet0 <= y_triplets(1 downto 0) & '0';

BEU_GEN : FOR I IN 0 TO N_PP-1 GENERATE
	      BEU_GEN0 : IF(I = 0) GENERATE
		             BEU0 :BEU PORT MAP(y_triplet0, sign(i), beu_out(i));
				     END GENERATE;
	      BEU_GEN1 : IF(I > 0) GENERATE
	                 BEU1: BEU PORT MAP(y_triplets(2*i+1 downto 2*i-1),  sign(i), beu_out(i));
			         END GENERATE;
          END GENERATE BEU_GEN;

S <= sign;

MUX_GEN : FOR I IN 0 TO N_PP-1 GENERATE
          MUX1: MUX3XNTO1XN GENERIC MAP(N => 32) PORT MAP(in0, in1, in2, out_mux(i), beu_out(i));
          END GENERATE MUX_GEN;

comp1_proc : process(out_mux, sign)
			 variable out_mux_temp  : std_logic_vector(N downto 0);
             variable pp_comp_temp  : std_logic_vector(N downto 0);
		     begin
		     for j in 0 to N_PP-1 loop
				out_mux_temp := out_mux(j);
					for k in 0 to N loop
					pp_comp_temp(k) := out_mux_temp(k) xor sign(j);
					end loop;
				pp_out_tmp(j) <= pp_comp_temp;
		     end loop;
		     end process;

PP1  <= pp_out_tmp(0);
PP2  <= pp_out_tmp(1);
PP3  <= pp_out_tmp(2);
PP4  <= pp_out_tmp(3);
PP5  <= pp_out_tmp(4);
PP6  <= pp_out_tmp(5);
PP7  <= pp_out_tmp(6);
PP8  <= pp_out_tmp(7);
PP9  <= pp_out_tmp(8);
PP10 <= pp_out_tmp(9);
PP11 <= pp_out_tmp(10);
PP12 <= pp_out_tmp(11);
PP13 <= pp_out_tmp(12);
PP14 <= pp_out_tmp(13);
PP15 <= pp_out_tmp(14);
PP16 <= pp_out_tmp(15);
PP17 <= pp_out_tmp(16);


END ARCHITECTURE;
