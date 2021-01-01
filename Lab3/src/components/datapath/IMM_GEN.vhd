library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity IMM_GEN is
    generic ( word_size : integer := 32);
    port (
            IR_IN       : in std_logic_vector(word_size - 1 downto 0);
            IMM_GEN_OUT : out std_logic_vector(word_size - 1 downto 0);
            IMM_EN_IN   : in std_logic;
            IMM_CODE_IN : in std_logic_vector(2 downto 0)
        );
end entity IMM_GEN;

architecture IMM_ARCH of IMM_GEN is

--immediate types    
signal IMM_ITYPE : std_logic_vector(word_size-1 downto 0);
signal IMM_STYPE : std_logic_vector(word_size-1 downto 0);
signal IMM_BTYPE : std_logic_vector(word_size-1 downto 0);
signal IMM_UTYPE : std_logic_vector(word_size-1 downto 0);
signal IMM_JTYPE : std_logic_vector(word_size-1 downto 0);
signal IMM_GEN : std_logic_vector(word_size-1 downto 0);
--constant types
constant CTRL_IN0_MUX : std_logic_vector(2 downto 0) := "000";
constant CTRL_IN1_MUX : std_logic_vector(2 downto 0) := "001";
constant CTRL_IN2_MUX : std_logic_vector(2 downto 0) := "010";
constant CTRL_IN3_MUX : std_logic_vector(2 downto 0) := "011";
constant CTRL_IN4_MUX : std_logic_vector(2 downto 0) := "100";

begin

IMM_ITYPE <= (31 downto 12 => IR_IN(31))  & IR_IN(31 downto 20);    
IMM_STYPE <= ((31 downto 12 => IR_IN(31)) & IR_IN(31 downto 25)  & IR_IN(11 downto 7));
IMM_BTYPE <= ((31 downto 12 => IR_IN(31)) & IR_IN(7) & IR_IN(30 downto 25) & IR_IN(11 downto 8) & '0');  
IMM_UTYPE <= IR_IN(31 downto 12)  & (11 downto 0 => '0');  
IMM_JTYPE <= (31 downto 20 => IR_IN(31)) & IR_IN(19 downto 12) & IR_IN(20) & IR_IN(30 downto 21) & '0';    


  
with IMM_CODE_IN select 
     IMM_GEN     <= IMM_ITYPE when CTRL_IN0_MUX,
                    IMM_STYPE when CTRL_IN1_MUX,
                    IMM_BTYPE when CTRL_IN2_MUX,
                    IMM_UTYPE when CTRL_IN3_MUX,
                    IMM_JTYPE when CTRL_IN4_MUX,
                    (others=>'-') when others;
                    
with IMM_EN_IN select IMM_GEN_OUT <= IMM_GEN when '1',
                                     (others=>'-') when others;


end architecture;