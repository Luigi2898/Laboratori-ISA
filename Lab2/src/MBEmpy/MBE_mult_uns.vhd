library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_signed.all;
  use work.array_std.all;

entity MBE_mult_uns is
    port (
        IN_A : in unsigned (31 downto 0);
        IN_B : in unsigned (31 downto 0);
        OUT_MPY : out unsigned (63 downto 0)        
    );
end entity MBE_mult_uns;  

architecture CSA_tree of MBE_mult_uns is

    -- Partial product generation from the input operands via MBE
    component MBE_PPG is
        generic(N : integer := 32; N_pp : integer := 17);
        port (
            A : in std_logic_vector(n-1 downto 0);
            B : in std_logic_vector(n-1 downto 0);
            S : out std_logic_vector(n/2 downto 0);
            PP: out pp_array	
        );
    end component;

    -- Partial products sum via Dadda-Tree
    component DADDA is
        port (
          PP      : in  PP_array;
          PP_sign : in  std_logic_vector (N / 2 downto 0); -- Last one is 0, please give me a 0
          SUM     : out std_logic_vector (2 * N - 1 downto 0)
        ) ;
    end component;

    signal sign_out : std_logic_vector (16 downto 0);
    signal pp_out : pp_array;

begin

    MBEU_PP : MBE_PPG port map (IN_A,IN_n,sign_out,pp_out);
    DADDA_TREE : DADDA port map (pp_out,sign_out,OUT_MPY);
    
end architecture CSA_tree;
