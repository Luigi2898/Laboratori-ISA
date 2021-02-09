library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity ALU is
  generic (N : integer := 32);
  port (
    DATA1_IN   : in  std_logic_vector(N - 1 downto 0);
    DATA2_IN   : in  std_logic_vector(N - 1 downto 0);
    OPCODE_IN  : in  std_logic_vector(5 downto 0);
    ZF_OUT     : out std_logic;
    NF_OUT     : out std_logic;
    RESULT_OUT : out std_logic_vector(N - 1 downto 0)
  );
end entity;

architecture arch of ALU is

  type shifeted_type is array (N - 1 downto 0) of std_logic_vector(N - 1 downto 0);

  constant SUM_OP : std_logic_vector(5 downto 0) := "000000";
  constant SHR_OP : std_logic_vector(5 downto 0) := "000010";
  constant LT_OP  : std_logic_vector(5 downto 0) := "000101"; 
  constant EQ_OP  : std_logic_vector(5 downto 0) := "001001";
  constant AND_OP : std_logic_vector(5 downto 0) := "010000";
  constant XOR_OP : std_logic_vector(5 downto 0) := "100000";

  signal INTERNAL_SH : shifeted_type;
  signal SUM1_IN     : std_logic_vector(N - 1 downto 0);
  signal SUM2_IN     : std_logic_vector(N - 1 downto 0);
  signal SUM_OUT     : std_logic_vector(N - 1 downto 0);
  signal SHIFTED     : std_logic_vector(N - 1 downto 0);

begin

  SHIFT_GEN : for i in 0 to N - 1 generate
    INTERNAL_SH(i) <= DATA1_IN(N - 1 downto N - 1 - i) & DATA1_IN(N - 1 downto 1 + i);
  end generate;
 
  SUM1_IN <= DATA1_IN;

  with OPCODE_IN select SUM2_IN    <= DATA2_IN                                      when SUM_OP,
                                      std_logic_vector(signed(not(DATA2_IN)) + "1") when LT_OP,
                                      std_logic_vector(signed(not(DATA2_IN)) + "1") when EQ_OP,
                                      (others => '-')                               when others;

  SUM_OUT <= std_logic_vector(signed(SUM1_IN) + signed(SUM2_IN));

  with OPCODE_IN select RESULT_OUT <= SUM_OUT                                     when SUM_OP,
                                      SHIFTED                                     when SHR_OP,
                                      (30 downto 0 => '0') & SUM_OUT(0)           when LT_OP,
                                      SUM_OUT                                     when EQ_OP,
                                      DATA1_IN and DATA2_IN                       when AND_OP,
                                      DATA1_IN xor DATA2_IN                       when XOR_OP,
                                      SUM_OUT                                     when others;

  --with SUM_OUT select ZF_OUT      <= '1' when (others => '0'),
    --                                 '0' when others;

  shift : process( OPCODE_IN )
  begin
    if OPCODE_IN = SHR_OP then
      SHIFTED <= INTERNAL_SH(to_integer(unsigned(DATA2_IN)));
    else
      SHIFTED <= (others => '0');
      end if ;
  end process ; -- shift

  ZF : process( SUM_OUT )
  begin
    if SUM_OUT = std_logic_vector(to_signed(0,N)) then
      ZF_OUT <= '1';
    else
      ZF_OUT <= '0';
    end if ;
  end process ; -- ZF

  NF_OUT  <= SUM_OUT(31);

end architecture;

