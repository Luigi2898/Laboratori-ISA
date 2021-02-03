library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

    entity BPU is
        port (
          CLK                : in std_logic;
          RSTN               : in std_logic;
          PC                 : in unsigned (31 downto 0);
          PC_D2              : in unsigned (31 downto 0);
          OPCODE_D2          : in std_logic_vector (6 downto 0);
          OUTCOME            : in std_logic;
          TARGET_ADDRESS_IN  : in unsigned (31 downto 0);
          TARGET_ADDRESS_OUT : out unsigned (31 downto 0);
          PREDICTION         : inout std_logic;
          MISPREDICTION      : out std_logic
        );
      end entity;
    

architecture arch of BPU is

begin

end architecture ;