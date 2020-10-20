library verilog;
use verilog.vl_types.all;
entity myfir is
    port(
        RST_n           : in     vl_logic;
        CLK             : in     vl_logic;
        VIN             : in     vl_logic;
        DIN             : in     vl_logic_vector(10 downto 0);
        H0              : in     vl_logic_vector(10 downto 0);
        H1              : in     vl_logic_vector(10 downto 0);
        H2              : in     vl_logic_vector(10 downto 0);
        H3              : in     vl_logic_vector(10 downto 0);
        H4              : in     vl_logic_vector(10 downto 0);
        H5              : in     vl_logic_vector(10 downto 0);
        H6              : in     vl_logic_vector(10 downto 0);
        H7              : in     vl_logic_vector(10 downto 0);
        H8              : in     vl_logic_vector(10 downto 0);
        DOUT            : out    vl_logic_vector(10 downto 0);
        VOUT            : out    vl_logic
    );
end myfir;
