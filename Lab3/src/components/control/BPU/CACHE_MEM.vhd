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
  
  signal CONTENT_MEM : memtypeContent3D;
  signal TAG_MEM : memtypeTag3D;
  signal AGE_MEM : memtypeAge3D;
  signal DECODED_ADDR : memtypeDecAddr2D;
  signal REFRESH_CNT_RD, REFRESH_CNT_WR : memtypeDecAddr2D;
  signal REFRESH_CNT : memtypeDecAddr2D;
  signal INCREASE_CNT : memtypeDecAddr2D;

  signal vdd, gnd : std_logic;

  signal DIN_REG : std_logic_vector (ContentSize-1 downto 0);
  signal TAG_IN_REG : std_logic_vector (TagSize-1 downto 0);



begin

  vdd <= '1';
  gnd <= '0';

  DIN_REG <= (std_logic_vector(DIN));
  TAG_IN_REG <= (std_logic_vector(WR_ADDR(AddrBits-1 downto EntriesBits)));

  refresh_cnt_process : process(RSTN,RD_EN,WR_EN,REFRESH_CNT_WR,REFRESH_CNT_RD)
  begin
    for i in 0 to SetNum-1 loop
      for j in 0 to SetEntries-1 loop
        REFRESH_CNT(i)(j) <= (REFRESH_CNT_RD(i)(j)) or (REFRESH_CNT_WR(i)(j));
      end loop;
    end loop;
  end process refresh_cnt_process;

----------------------------------------------------------------------------------------------------------
  write_address_decode_process : process (WR_ADDR,WR_EN,AGE_MEM)
  variable hot_one : integer := 0;
  variable decoded_addr_var : memtypeDecAddr2D;
  variable refresh_cnt_wr_var : memtypeDecAddr2D;
  variable wr_addr_set_var : integer := 0;
  variable wr_addr_entry_var : integer;
  variable flag : std_logic := '0';

  begin

    wr_addr_entry_var := to_integer(WR_ADDR(EntriesBits-1 downto 0));

    flag := '0';

    wr_addr_set_var := 0;
    decoded_addr_var := (others => (others =>'0'));
    refresh_cnt_wr_var := (others => (others =>'0'));

    for i in 0 to SetNum-1 loop
      if (AGE_MEM(i)(wr_addr_entry_var) = "11") then
        wr_addr_set_var := i;
        flag := '1';
      end if;
    end loop;

    if (flag = '1') then
      decoded_addr_var := (others => (others =>'0'));
      decoded_addr_var(wr_addr_set_var)(wr_addr_entry_var) := '1' and WR_EN;
      refresh_cnt_wr_var := (others => (others =>'0'));
      refresh_cnt_wr_var(wr_addr_set_var)(wr_addr_entry_var) := '1' and WR_EN;

    else
      for i in 0 to SetNum-1 loop
        if (AGE_MEM(i)(wr_addr_entry_var) = "10") then
          wr_addr_set_var := i;
          flag := '1';
        end if;
      end loop;

      if (flag = '1') then
        decoded_addr_var := (others => (others =>'0'));
        decoded_addr_var(wr_addr_set_var)(wr_addr_entry_var) := '1' and WR_EN;
        refresh_cnt_wr_var := (others => (others =>'0'));
        refresh_cnt_wr_var(wr_addr_set_var)(wr_addr_entry_var) := '1' and WR_EN;

      else
        for i in 0 to SetNum-1 loop
          if (AGE_MEM(i)(wr_addr_entry_var) = "01") then
            wr_addr_set_var := i;
            flag := '1';
          end if;
        end loop;

        if (flag = '1') then
          decoded_addr_var := (others => (others =>'0'));
          decoded_addr_var(wr_addr_set_var)(wr_addr_entry_var) := '1' and WR_EN;
          refresh_cnt_wr_var := (others => (others =>'0'));
          refresh_cnt_wr_var(wr_addr_set_var)(wr_addr_entry_var) := '1' and WR_EN;

        else
          for i in 0 to SetNum-1 loop
            if (AGE_MEM(i)(wr_addr_entry_var) = "00") then
              wr_addr_set_var := i;
              flag := '1';
            end if;
          end loop;
          
          if (flag = '1') then
            decoded_addr_var := (others => (others =>'0'));
            decoded_addr_var(wr_addr_set_var)(wr_addr_entry_var) := '1' and WR_EN;
            refresh_cnt_wr_var := (others => (others =>'0'));
            refresh_cnt_wr_var(wr_addr_set_var)(wr_addr_entry_var) := '1' and WR_EN;
          else
            decoded_addr_var := (others => (others =>'0'));
            refresh_cnt_wr_var := (others => (others =>'0'));
          end if;
        end if;
      end if;
    end if;

      

    DECODED_ADDR <= decoded_addr_var;
    REFRESH_CNT_WR <= refresh_cnt_wr_var;
  
  end process write_address_decode_process;
----------------------------------------------------------------------------------------------------------
  mem_set_generation : for i in 0 to SetNum-1 generate  
    mem_entry_generation : for j in 0 to SetEntries-1 generate

      TAG_REG : REG generic map (TagSize) port map (TAG_IN_REG,CLK,RSTN,DECODED_ADDR(i)(j),TAG_MEM(i)(j));
      CONTENT_REG : REG generic map (ContentSize) port map (DIN_REG,CLK,RSTN,DECODED_ADDR(i)(j),CONTENT_MEM(i)(j));
      AGE_COUNT : AGE_CNT generic map (2,4) port map (CLK,RSTN,REFRESH_CNT(i)(j),INCREASE_CNT(i)(j),vdd,AGE_MEM(i)(j));

    end generate mem_entry_generation;
  end generate mem_set_generation;
----------------------------------------------------------------------------------------------------------
  data_read_process : process(RD_ADDR,CONTENT_MEM,RD_EN,TAG_MEM)
  variable rd_addr_entry_var : integer := 0;
  variable rd_addr_set_var : integer := 0;
  variable tag_var : unsigned (TagSize-1 downto 0);
  variable flag : std_logic;
  variable refresh_cnt_rd_var : memtypeDecAddr2D;
  variable increase_cnt_var : memtypeDecAddr2D;
    begin

      rd_addr_entry_var := to_integer(RD_ADDR(EntriesBits-1 downto 0));
      rd_addr_set_var := to_integer(RD_ADDR(SetBits+EntriesBits-1 downto EntriesBits));


      for i in 0 to SetNum-1 loop
        if (std_logic_vector(TAG_MEM(i)(rd_addr_entry_var)) = std_logic_vector(RD_ADDR(AddrBits-1 downto EntriesBits))) then
          flag := '1';
          rd_addr_set_var := i;
        else
          flag := '0';
        end if;
      end loop;

      if (flag = '1') then
        HIT_MISSN <= '1';
        DOUT <= unsigned((CONTENT_MEM(rd_addr_set_var)(rd_addr_entry_var)));
        refresh_cnt_rd_var := (others => (others => '0'));
        refresh_cnt_rd_var(rd_addr_set_var)(rd_addr_entry_var) := '1';
      else
        HIT_MISSN <= '0';
        DOUT <= (others => '0');
        refresh_cnt_rd_var := (others => (others => '0'));
      end if;

      increase_cnt_var := (others => (others => '0'));
      for i in 0 to SetNum-1 loop
        increase_cnt_var(i)(rd_addr_entry_var) := '1' and RD_EN;
      end loop;
      increase_cnt_var(rd_addr_set_var)(rd_addr_entry_var) := '0';

      INCREASE_CNT <= increase_cnt_var;
      REFRESH_CNT_RD <= refresh_cnt_rd_var;
      

    
  end process data_read_process;
----------------------------------------------------------------------------------------------------------  
  
  
end architecture rtl;