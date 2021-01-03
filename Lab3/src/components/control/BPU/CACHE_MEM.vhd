library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CACHE_MEM is
  generic (SetNum : integer := 2;
           SetEntries : integer := 2;
           TagSize : integer := 1;
           ContentSize : integer := 2;
           AddrBits : integer := 2;
           SetBits : integer := 1 ;
           EntriesBits : integer := 1);
  port (
    CLK : in std_logic;
    RSTN : in std_logic;
    RD_ADDR : in unsigned(AddrBits-1 downto 0);
    WR_ADDR : in unsigned(AddrBits-1 downto 0);
    WR_EN : in std_logic;
    RD_EN : in std_logic;
    DIN : in unsigned (ContentSize-1 downto 0);
    DOUT : out unsigned (ContentSize-1 downto 0);
    HIT_MISSN : out std_logic

  );
end entity CACHE_MEM;

architecture rtl of CACHE_MEM is

  component REG is
    generic(N : integer := 11);
    port(
    REG_IN           : in  std_logic_vector(N-1 downto 0);
    CLK, RST_N, LOAD : in  std_logic;
    REG_OUT          : out std_logic_vector(N-1 downto 0)
    );
  end component;

  component AGE_CNT is
    generic ( Nb : integer := 2;
              Module : integer := 4);
    port (
      CLK : in std_logic;
      RSTN : in std_logic;
      REFRESH : in std_logic;
      EN : in std_logic;
      CNT_UP_DOWNN : in std_logic;
      CNT_OUT : out unsigned (Nb-1 downto 0)
    );
  end component AGE_CNT;

  constant Size : integer := (SetNum * SetEntries);
  constant Depth : integer := (TagSize + ContentSize);

  type memtypeContent2D is array (SetEntries-1 downto 0) of std_logic_vector (ContentSize-1 downto 0);
  type memtypeTag2D is array (SetEntries-1 downto 0) of std_logic_vector (TagSize-1 downto 0);
  type memtypeAge2D is array (SetEntries-1 downto 0) of unsigned (1 downto 0);

  type memtypeContent3D is array (SetNum-1 downto 0) of memtypeContent2D;
  type memtypeTag3D is array (SetNum-1 downto 0) of memtypeTag2D;
  type memtypeAge3D is array (SetNum-1 downto 0) of memtypeAge2D;
  type memtypeDecAddr2D is array (SetNum-1 downto 0) of std_logic_vector (SetEntries-1 downto 0);
  



begin

----------------------------------------------------------------------------------------------------------
  memory_process : process (WR_ADDR,WR_EN,RD_ADDR,CLK,RSTN,DIN,RD_EN)

  variable MEM_CONTENT : memtypeContent3D;
  variable MEM_TAG : memtypeTag3D;
  variable MEM_AGE : memtypeAge3D;

  variable hot_one : integer := 0;
  variable decoded_addr_var : memtypeDecAddr2D;
  variable refresh_cnt_wr_var : memtypeDecAddr2D;
  variable wr_addr_set_var : integer := 0;
  variable wr_addr_entry_var : integer;

  variable flag : std_logic := '0';
  variable rd_addr_entry_var : integer := 0;
  variable rd_addr_set_var : integer := 0;
  variable tag_var : unsigned (TagSize-1 downto 0);
  variable flag_r : std_logic := '0';
  variable refresh_cnt_rd_var : memtypeDecAddr2D;
  variable increase_cnt_var : memtypeDecAddr2D;

  variable read_set, read_row : integer := 0;
  variable found : std_logic := '0';


  begin

  if (RSTN = '0') then
    MEM_CONTENT := (others => (others => (others => '0')));
    MEM_TAG := (others => (others => (others => '0')));
    MEM_AGE := (others => (others => (others => '1')));

  elsif (CLK'event and CLK = '1') then

    if (found = '1') then
      for i in 0 to SetNum-1 loop
        if (i /= read_set) then
          if ((MEM_AGE(i)(read_row)) /= to_unsigned(3,2)) then
            MEM_AGE(i)(read_row) := MEM_AGE(i)(read_row) + "01";
          else
            MEM_AGE(i)(read_row) := MEM_AGE(i)(read_row);
          end if;
        else
          MEM_AGE(i)(read_row) := MEM_AGE(i)(read_row);
        end if;
      end loop;
    end if;


    


    if (WR_EN = '1') then

      wr_addr_entry_var := to_integer(WR_ADDR(EntriesBits-1 downto 0));

      flag := '0';

      wr_addr_set_var := 0;
    
      for i in 0 to SetNum-1 loop
        if (MEM_AGE(i)(wr_addr_entry_var) = "11") then
          wr_addr_set_var := i;
          flag := '1';
        end if;
      end loop;

      if (flag = '1') then
        MEM_CONTENT(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(DIN);
        MEM_TAG(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(WR_ADDR(AddrBits-1 downto EntriesBits));
        MEM_AGE(wr_addr_set_var)(wr_addr_entry_var) := (others => '0');

      else
        for i in 0 to SetNum-1 loop
          if (MEM_AGE(i)(wr_addr_entry_var) = "10") then
            wr_addr_set_var := i;
            flag := '1';
          end if;
        end loop;

        if (flag = '1') then
          MEM_CONTENT(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(DIN);
          MEM_TAG(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(WR_ADDR(AddrBits-1 downto EntriesBits));
          MEM_AGE(wr_addr_set_var)(wr_addr_entry_var) := (others => '0');

        else
          for i in 0 to SetNum-1 loop
            if (MEM_AGE(i)(wr_addr_entry_var) = "01") then
              wr_addr_set_var := i;
              flag := '1';
            end if;
          end loop;

          if (flag = '1') then
            MEM_CONTENT(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(DIN);
            MEM_TAG(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(WR_ADDR(AddrBits-1 downto EntriesBits));
            MEM_AGE(wr_addr_set_var)(wr_addr_entry_var) := (others => '0');
          else
            for i in 0 to SetNum-1 loop
              if (MEM_AGE(i)(wr_addr_entry_var) = "00") then
                wr_addr_set_var := i;
                flag := '1';
              end if;
            end loop;
            
            if (flag = '1') then
              MEM_CONTENT(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(DIN);
              MEM_TAG(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(WR_ADDR(AddrBits-1 downto EntriesBits));
              MEM_AGE(wr_addr_set_var)(wr_addr_entry_var) := (others => '0');
            end if;
          end if;
        end if;
      end if;
    else
      MEM_TAG := MEM_TAG;
      MEM_CONTENT := MEM_CONTENT;
      MEM_AGE := MEM_AGE;
    end if;
    else
      MEM_TAG := MEM_TAG;
      MEM_CONTENT := MEM_CONTENT;
      MEM_AGE := MEM_AGE;
    end if;

  if (RD_EN = '1') then

    rd_addr_entry_var := to_integer(RD_ADDR(EntriesBits-1 downto 0));
    rd_addr_set_var := to_integer(RD_ADDR(SetBits+EntriesBits-1 downto EntriesBits));


    for i in 0 to SetNum-1 loop
      if (MEM_TAG(i)(rd_addr_entry_var) = std_logic_vector(RD_ADDR(AddrBits-1 downto EntriesBits))) then
        flag_r := '1';
        rd_addr_set_var := i;
      else
        flag_r := '0';
      end if;
    end loop;

    if (flag_r = '1') then
      HIT_MISSN <= '1';
      DOUT <= unsigned((MEM_CONTENT(rd_addr_set_var)(rd_addr_entry_var)));
      MEM_AGE(rd_addr_set_var)(rd_addr_entry_var) := (others => '0');
    else
      HIT_MISSN <= '0';
      DOUT <= (others => '0');
    end if;


    read_set := rd_addr_set_var;
    read_row := rd_addr_entry_var;
    found := '1';
  
  else
    DOUT <= (others => '0');
    HIT_MISSN <= '0';
    read_set := 0;
    read_row := 0;
    found := '0';

  end if;
  
  end process memory_process;

----------------------------------------------------------------------------------------------------------
 
  
end architecture rtl;