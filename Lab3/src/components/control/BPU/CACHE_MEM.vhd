library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CACHE_MEM is
  generic (SetNum : integer := 2;
           SetEntries : integer := 4;
           TagSize : integer := 2;
           ContentSize : integer := 2;
           AddrBits : integer := 8;
           SetBits : integer := 1 ;
           EntriesBits : integer := 2);
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

architecture beh of CACHE_MEM is

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
  type memtypeVirgin3D is array (SetNum-1 downto 0) of std_logic_vector (SetEntries-1 downto 0);
  
  signal INCREASE_CNT, REFRESH_CNT_RD, REFRESH_CNT_WR, REFRESH_CNT : memtypeDecAddr2D;
  signal MEM_CONTENT_SIGNAL : memtypeContent3D;
  signal MEM_TAG_SIGNAL : memtypeTag3D;
  signal AGE_MEM : memtypeAge3D;
  signal MEM_VIRGIN_SIGNAL : memtypeVirgin3D;
  signal VDD : std_logic;

begin
-- aaaaaaaaaaaaaa
----------------------------------------------------------------------------------------------------------
  VDD <= '1';


cam_memory_process_synch_write : process (CLK,RSTN)

  variable MEM_CONTENT : memtypeContent3D;
  variable MEM_TAG : memtypeTag3D;
  variable MEM_AGE : memtypeAge3D;
  variable MEM_VIRGIN : memtypeVirgin3D;

  variable decoded_addr_var : memtypeDecAddr2D;
  variable refresh_cnt_wr_var : memtypeDecAddr2D;
  variable wr_addr_set_var : integer := 0;
  variable wr_addr_entry_var : integer;

  variable flag : std_logic := '0';
  variable rd_addr_entry_var : integer := 0;
  variable tag_var : unsigned (TagSize-1 downto 0);
  variable refresh_cnt_rd_var : memtypeDecAddr2D;
  variable increase_cnt_var : memtypeDecAddr2D;



  begin
  -- RESET PROCESS

  if (RSTN = '0') then
    MEM_CONTENT := (others => (others => (others => '0')));
    MEM_TAG := (others => (others => (others => '0')));
    refresh_cnt_wr_var := (others => (others => '0'));
    MEM_VIRGIN := (others => (others => '0')); -- all the locations have never been written

  -- SYNCHR WRITING  
  elsif (CLK'event and CLK = '1') then

    if (WR_EN = '1') then
      

      wr_addr_entry_var := to_integer(WR_ADDR(EntriesBits-1 downto 0));
      flag := '0';
      wr_addr_set_var := 0;
    
      for i in 0 to SetNum-1 loop
        if (AGE_MEM(i)(wr_addr_entry_var) = "11") then
          wr_addr_set_var := i;
          flag := '1';
        end if;
      end loop;

      if (flag = '1') then
        MEM_CONTENT(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(DIN);
        MEM_TAG(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(WR_ADDR(AddrBits-1 downto EntriesBits));
        refresh_cnt_wr_var := (others => (others => '0'));
        refresh_cnt_wr_var(wr_addr_set_var)(wr_addr_entry_var) := '1';
        MEM_VIRGIN(wr_addr_set_var)(wr_addr_entry_var) := '1';

      else
        for i in 0 to SetNum-1 loop
          if (AGE_MEM(i)(wr_addr_entry_var) = "10") then
            wr_addr_set_var := i;
            flag := '1';
          end if;
        end loop;

        if (flag = '1') then
          MEM_CONTENT(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(DIN);
          MEM_TAG(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(WR_ADDR(AddrBits-1 downto EntriesBits));
          refresh_cnt_wr_var := (others => (others => '0'));
          refresh_cnt_wr_var(wr_addr_set_var)(wr_addr_entry_var) := '1';
          MEM_VIRGIN(wr_addr_set_var)(wr_addr_entry_var) := '1';

        else
          for i in 0 to SetNum-1 loop
            if (AGE_MEM(i)(wr_addr_entry_var) = "01") then
              wr_addr_set_var := i;
              flag := '1';
            end if;
          end loop;

          if (flag = '1') then
            MEM_CONTENT(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(DIN);
            MEM_TAG(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(WR_ADDR(AddrBits-1 downto EntriesBits));
            refresh_cnt_wr_var := (others => (others => '0'));
            refresh_cnt_wr_var(wr_addr_set_var)(wr_addr_entry_var) := '1';
            MEM_VIRGIN(wr_addr_set_var)(wr_addr_entry_var) := '1';
          else

            for i in 0 to SetNum-1 loop
              if (AGE_MEM(i)(wr_addr_entry_var) = "00") then
                wr_addr_set_var := i;
                flag := '1';
              end if;
            end loop;
            
            if (flag = '1') then
              MEM_CONTENT(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(DIN);
              MEM_TAG(wr_addr_set_var)(wr_addr_entry_var) := std_logic_vector(WR_ADDR(AddrBits-1 downto EntriesBits));
              refresh_cnt_wr_var := (others => (others => '0'));
              refresh_cnt_wr_var(wr_addr_set_var)(wr_addr_entry_var) := '1';
              MEM_VIRGIN(wr_addr_set_var)(wr_addr_entry_var) := '1';
            end if;

          end if;
        end if;
      end if;
    else
      MEM_TAG := MEM_TAG;
      MEM_CONTENT := MEM_CONTENT;
      refresh_cnt_wr_var := refresh_cnt_wr_var;
      MEM_VIRGIN := MEM_VIRGIN;
    end if;
  else
    --MEM_TAG := MEM_TAG;
    --MEM_CONTENT := MEM_CONTENT;
    --refresh_cnt_wr_var := refresh_cnt_wr_var;
    --MEM_VIRGIN := MEM_VIRGIN;
  end if;

    MEM_TAG_SIGNAL <= MEM_TAG;
    MEM_CONTENT_SIGNAL <= MEM_CONTENT;
    REFRESH_CNT_WR <= refresh_cnt_wr_var;
    MEM_VIRGIN_SIGNAL <= MEM_VIRGIN;

  end process cam_memory_process_synch_write;


  cam_memory_process_asynch_read : process (RD_ADDR,RD_EN,MEM_TAG_SIGNAL,MEM_CONTENT_SIGNAL,MEM_VIRGIN_SIGNAL)
  -- ASYNCH READ
  variable flag : std_logic := '0';
  variable rd_addr_entry_var : integer := 0;
  variable rd_addr_set_var : integer := 0;
  variable tag_var : unsigned (TagSize-1 downto 0);
  variable flag_r : std_logic := '0';
  variable refresh_cnt_rd_var : memtypeDecAddr2D;
  variable increase_cnt_var : memtypeDecAddr2D;

  begin

  if (RD_EN = '1') then  
    increase_cnt_var := (others => (others => '0'));
    refresh_cnt_rd_var := (others => (others => '0'));

    rd_addr_entry_var := to_integer(RD_ADDR(EntriesBits-1 downto 0));
    rd_addr_set_var := to_integer(RD_ADDR(AddrBits-1 downto EntriesBits));
    flag_r := '0';

    for i in 0 to SetNum-1 loop
      if ((MEM_TAG_SIGNAL(i)(rd_addr_entry_var) = std_logic_vector(RD_ADDR(AddrBits-1 downto EntriesBits)))
           and MEM_VIRGIN_SIGNAL(i)(rd_addr_entry_var) = '1') then
        flag_r := '1';
        rd_addr_set_var := i;
      else
        flag_r := flag_r;
      end if;
    end loop;

    if (flag_r = '1') then
      HIT_MISSN <= '1';
      DOUT <= unsigned((MEM_CONTENT_SIGNAL(rd_addr_set_var)(rd_addr_entry_var)));
      refresh_cnt_rd_var(rd_addr_set_var)(rd_addr_entry_var) := '1';

      for i in 0 to SetNum-1 loop
        if i /= rd_addr_set_var then
          increase_cnt_var(i)(rd_addr_entry_var) := '1';
        else
          increase_cnt_var(i)(rd_addr_entry_var) := '0';
        end if;
      end loop;
    else
      HIT_MISSN <= '0';
      DOUT <= (others => '0');
    end if;
  else
    HIT_MISSN <= '0';
    DOUT <= (others => '0');
    increase_cnt_var := (others => (others => '0'));
    refresh_cnt_rd_var := (others => (others => '0'));
  end if;

  REFRESH_CNT_RD <= refresh_cnt_rd_var;
  INCREASE_CNT <= increase_cnt_var;
  
  end process cam_memory_process_asynch_read;
----------------------------------------------------------------------------------------------------------
age_cnts_generation_set : for i in 0 to SetNum-1 generate
  age_cnts_generation_entry : for j in 0 to SetEntries-1 generate

    AGE_REG : AGE_CNT port map (CLK,RSTN,REFRESH_CNT(i)(j),INCREASE_CNT(i)(j),VDD,AGE_MEM(i)(j));
    
  end generate age_cnts_generation_entry;
end generate age_cnts_generation_set;
----------------------------------------------------------------------------------------------------------

refresh_cnt_comb : process (REFRESH_CNT_RD,REFRESH_CNT_WR)
  begin
    for i in 0 to SetNum-1 loop
      for j in 0 to SetEntries-1 loop
        REFRESH_CNT(i)(j) <= REFRESH_CNT_RD(i)(j) or REFRESH_CNT_WR(i)(j);
      end loop;
    end loop;
end process;


  
end architecture beh;