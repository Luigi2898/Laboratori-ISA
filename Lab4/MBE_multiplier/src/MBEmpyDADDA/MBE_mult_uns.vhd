library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
--  use ieee.std_logic_signed.all;

entity MBE_mult_uns is
    port (
        IN_A    : in std_logic_vector (31 downto 0);
        IN_B    : in std_logic_vector (31 downto 0);
        OUT_MPY : out std_logic_vector (64 downto 0)
    );
end entity MBE_mult_uns;

architecture CSA_tree of MBE_mult_uns is

  -- Partial product generation from the input operands via MBE

  component MBE_PPG is
    generic(
            N    : integer := 32;
            N_pp : integer := 17
           );
    port(
            A    : in  std_logic_vector(N-1 downto 0);
		        B    : in  std_logic_vector(N-1 downto 0);
		        S    : out std_logic_vector(N/2 downto 0);
	          PP1  : out std_logic_vector(N downto 0);
            PP2  : out std_logic_vector(N downto 0);
		        PP3  : out std_logic_vector(N downto 0);
		        PP4  : out std_logic_vector(N downto 0);
		        PP5  : out std_logic_vector(N downto 0);
		        PP6  : out std_logic_vector(N downto 0);
		        PP7  : out std_logic_vector(N downto 0);
		        PP8  : out std_logic_vector(N downto 0);
		        PP9  : out std_logic_vector(N downto 0);
		        PP10 : out std_logic_vector(N downto 0);
		        PP11 : out std_logic_vector(N downto 0);
		        PP12 : out std_logic_vector(N downto 0);
		        PP13 : out std_logic_vector(N downto 0);
		        PP14 : out std_logic_vector(N downto 0);
		        PP15 : out std_logic_vector(N downto 0);
		        PP16 : out std_logic_vector(N downto 0);
		        PP17 : out std_logic_vector(N downto 0)
	      );
  end component;

  -- Partial products sum via Dadda-Tree

  component CSA_Tree_DADDA is
    generic(
            N    : integer := 33;
            N_PP : integer := 17
           );
    port(
    	      PP1     : in  std_logic_vector(N-1 downto 0);
            PP2     : in  std_logic_vector(N-1 downto 0);
		        PP3     : in  std_logic_vector(N-1 downto 0);
		        PP4     : in  std_logic_vector(N-1 downto 0);
		        PP5     : in  std_logic_vector(N-1 downto 0);
		        PP6     : in  std_logic_vector(N-1 downto 0);
		        PP7     : in  std_logic_vector(N-1 downto 0);
		        PP8     : in  std_logic_vector(N-1 downto 0);
		        PP9     : in  std_logic_vector(N-1 downto 0);
		        PP10    : in  std_logic_vector(N-1 downto 0);
		        PP11    : in  std_logic_vector(N-1 downto 0);
		        PP12    : in  std_logic_vector(N-1 downto 0);
		        PP13    : in  std_logic_vector(N-1 downto 0);
		        PP14    : in  std_logic_vector(N-1 downto 0);
		        PP15    : in  std_logic_vector(N-1 downto 0);
		        PP16    : in  std_logic_vector(N-1 downto 0);
		        PP17    : in  std_logic_vector(N-1 downto 0);
            PP_sign : in  std_logic_vector(N / 2 downto 0);
            SUM     : out std_logic_vector(2 * N - 2 downto 0)
        );
    end component CSA_Tree_DADDA;

    signal sign_out : std_logic_vector(16 downto 0);
    signal PP1      : std_logic_vector(32 downto 0);
    signal PP2      : std_logic_vector(32 downto 0);
    signal PP3      : std_logic_vector(32 downto 0);
    signal PP4      : std_logic_vector(32 downto 0);
    signal PP5      : std_logic_vector(32 downto 0);
    signal PP6      : std_logic_vector(32 downto 0);
    signal PP7      : std_logic_vector(32 downto 0);
    signal PP8      : std_logic_vector(32 downto 0);
    signal PP9      : std_logic_vector(32 downto 0);
    signal PP10     : std_logic_vector(32 downto 0);
    signal PP11     : std_logic_vector(32 downto 0);
    signal PP12     : std_logic_vector(32 downto 0);
    signal PP13     : std_logic_vector(32 downto 0);
    signal PP14     : std_logic_vector(32 downto 0);
    signal PP15     : std_logic_vector(32 downto 0);
    signal PP16     : std_logic_vector(32 downto 0);
    signal PP17     : std_logic_vector(32 downto 0);

    begin

      MBEU_PP : MBE_PPG port map (IN_A,IN_B,sign_out, PP1, PP2, PP3, PP4, PP5,
                                  PP6, PP7, PP8, PP9, PP10, PP11, PP12, PP13,
                                  PP14, PP15, PP16, PP17);

      CSA_Tree : CSA_Tree_DADDA port map (PP1, PP2, PP3, PP4, PP5, PP6, PP7,
                                          PP8, PP9, PP10, PP11, PP12, PP13,
                                          PP14, PP15, PP16, PP17, sign_out,
                                          OUT_MPY);

end architecture CSA_tree;
