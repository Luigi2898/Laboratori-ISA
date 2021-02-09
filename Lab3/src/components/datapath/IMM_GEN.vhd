library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity IMM_GEN is
  port(
    IR_IN       : in  std_logic_vector(31 downto 0);
    IMM_GEN_OUT : out std_logic_vector(31 downto 0);
    IMM_EN_IN   : in  std_logic;
    IMM_CODE_IN : in  std_logic_vector(2 downto 0)
  );
end entity IMM_GEN;

architecture IMM_ARCH of IMM_GEN is

--immediate types    
signal IMM_ITYPE : std_logic_vector (31 downto 0);
signal IMM_ITYPE_SRAI : std_logic_vector (31 downto 0);
signal IMM_STYPE : std_logic_vector (31 downto 0);
signal IMM_BTYPE : std_logic_vector (31 downto 0);
signal IMM_UTYPE : std_logic_vector (31 downto 0);
signal IMM_JTYPE : std_logic_vector (31 downto 0);
signal IMM_GEN : std_logic_vector (31 downto 0);
signal IMM_NULL : std_logic_vector (31 downto 0);
--constant types
constant CTRL_IN0_MUX : std_logic_vector(2 downto 0) := "000";
constant CTRL_IN1_MUX : std_logic_vector(2 downto 0) := "001";
constant CTRL_IN2_MUX : std_logic_vector(2 downto 0) := "010";
constant CTRL_IN3_MUX : std_logic_vector(2 downto 0) := "011";
constant CTRL_IN4_MUX : std_logic_vector(2 downto 0) := "100";

begin

--IMM_ITYPE <= (31 downto 12 => IR_IN(31))  & IR_IN(30 downto 20);    
--IMM_STYPE <= ((31 downto 12 => IR_IN(31)) & IR_IN(31 downto 25)  & IR_IN(11 downto 7));
--IMM_BTYPE <= ((31 downto 12 => IR_IN(31)) & IR_IN(7) & IR_IN(30 downto 25) & IR_IN(11 downto 8) & '0');  
--IMM_UTYPE <= IR_IN(31 downto 12)  & (11 downto 0 => '0');  
--IMM_JTYPE <= (31 downto 20 => IR_IN(31)) & IR_IN(19 downto 12) & IR_IN(20) & IR_IN(30 downto 21) & '0';    

immediate_generation_process: process(IR_IN)
  variable imm_Itype_var, imm_Stype_var, imm_Itype_srai_var, imm_Btype_var, imm_Utype_var, imm_Jtype_var : std_logic_vector (31 downto 0);
begin

  imm_Itype_var := (others => IR_IN(31));
  imm_Stype_var := (others => IR_IN(31));
  imm_Btype_var := (others => IR_IN(31));
  imm_Utype_var := (others => '0');
  imm_Jtype_var := (others => IR_IN(31));
  imm_Itype_srai_var := (others => IR_IN(31));

  imm_Itype_var(10 downto 0) := IR_IN(30 downto 20);
  imm_Stype_var(10 downto 0) := IR_IN(30 downto 25) & IR_IN(11 downto 8) & IR_IN(7);
  imm_Btype_var(11 downto 0) := IR_IN(7) & IR_IN(30 downto 25) & IR_IN(11 downto 8) & '0';
  imm_Utype_var(31 downto 12) := IR_IN(31) & IR_IN(30 downto 20) & IR_IN(19 downto 12);
  imm_Jtype_var(19 downto 0) := IR_IN(19 downto 12) & IR_IN(20) & IR_IN(30 downto 25) & IR_IN(24 downto 21) & '0';
  imm_Itype_srai_var(4 downto 0) := IR_IN(24 downto 20);

  if (IR_IN(14 downto 12) = "101") then -- SRAI
    IMM_ITYPE <= imm_Itype_srai_var;
  else
    IMM_ITYPE <= imm_Itype_var;
  end if;

  IMM_STYPE <= imm_Stype_var;
  IMM_BTYPE <= imm_Btype_var;
  IMM_UTYPE <= imm_Utype_var;
  IMM_JTYPE <= imm_Jtype_var;
  
end process immediate_generation_process;

IMM_NULL <= (others => '0');


with IMM_CODE_IN select 
     IMM_GEN     <= IMM_ITYPE when CTRL_IN0_MUX,
                    IMM_STYPE when CTRL_IN1_MUX,
                    IMM_BTYPE when CTRL_IN2_MUX,
                    IMM_UTYPE when CTRL_IN3_MUX,
                    IMM_JTYPE when CTRL_IN4_MUX,
                    IMM_ITYPE when others;
                    
with IMM_EN_IN select IMM_GEN_OUT <= IMM_GEN when '1',
                                     IMM_NULL when others;


end architecture;