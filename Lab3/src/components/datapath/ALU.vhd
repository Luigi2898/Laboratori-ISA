library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity ALU is
  port (
    DATA1_IN   : in  std_logic_vector(31 downto 0);
    DATA2_IN   : in  std_logic_vector(31 downto 0);
    OPCODE_IN  : in  std_logic_vector(5 downto 0);
    ZF_OUT     : out std_logic;
    NF_OUT     : out std_logic;
    RESULT_OUT : out std_logic_vector(31 downto 0)
  );
end entity;

architecture arch of ALU is

  type shifeted_type is array (31 downto 0) of std_logic_vector(31 downto 0);

  constant SUM_OP : std_logic_vector(5 downto 0) := "000000";
  constant SHR_OP : std_logic_vector(5 downto 0) := "000010";
  constant LT_OP  : std_logic_vector(5 downto 0) := "000101"; 
  constant EQ_OP  : std_logic_vector(5 downto 0) := "001001";
  constant AND_OP : std_logic_vector(5 downto 0) := "010000";
  constant XOR_OP : std_logic_vector(5 downto 0) := "100000";

  signal INTERNAL_RES : std_logic_vector(31 downto 0);
  signal INTERNAL_SH  : shifeted_type;
  signal INTERNAL_LT  : std_logic_vector(31 downto 0);

begin

  SHIFT_GEN : for i in 0 to 31 generate
    INTERNAL_SH(i) <= DATA1_IN(31 downto 31 - i) & DATA1_IN(31 downto 1 + i);
  end generate;

  INTERNAL_LT <= (31 downto 1 => '0') & std_logic_vector(signed(DATA1_IN) - signed(DATA2_IN))(31);

  with OPCODE_IN select INTERNAL_RES <= std_logic_vector(signed(DATA1_IN) + signed(DATA2_IN))                       when SUM_OP,
                                        INTERNAL_SH(to_integer(signed(DATA2_IN)))                                   when SHR_OP,
                                        DATA1_IN and DATA2_IN                                                       when AND_OP,
                                        DATA1_IN xor DATA2_IN                                                       when XOR_OP,
                                        INTERNAL_LT                                                                 when LT_OP,
                                        std_logic_vector(signed(DATA1_IN) - signed(DATA2_IN))                       when EQ_OP,
                                        (others => '-')                                                             when others;

  with INTERNAL_RES select ZF_OUT    <= '1' when std_logic_vector(to_unsigned(0,32)),
                                        '0' when others;
                                  
  NF_OUT                             <= INTERNAL_RES(31);

  RESULT_OUT                         <= INTERNAL_RES;
  
end architecture;

