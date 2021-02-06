
module MAIN_MEM 
# ( parameter instr_filename = "",
    parameter data_filename = "",
    parameter Entries = 32767
  )
  ( input CLK,
    input RSTN,
    input WR_EN,
    input  [31:0] RD_ADDR1,
    input  [31:0] RD_ADDR2,
    input  [31:0] WR_ADDR1,
    output [31:0] RD_DOUT_1,
    output [31:0] RD_DOUT_2,
    input  [31:0] WR_DIN_1
  );

  parameter DataBaseAddress = 0;
  parameter DataLimit = 4092;
  parameter InstrBaseAddress = 8192;
  parameter InstrLimit = 12284;
  parameter InstrSegmSize = (InstrLimit-InstrBaseAddress+4)/4;
  parameter DataSegmSize = (DataLimit-DataBaseAddress+4)/4;
  integer i = 0;
  reg [31:0] RD_DOUT_1_TMP;
  reg [31:0] RD_DOUT_2_TMP;

  // byte access memory
  reg [7:0] MEM [Entries-1:0];

  // tmp memories for initialization
  reg [31:0] I_MEM_TMP [InstrSegmSize-1:0];
  reg [31:0] D_MEM_TMP [DataSegmSize-1:0];

  // memory initialization
  initial begin

    i = 0;
    for (i=0; i<Entries; i=i+1) begin
      MEM[i] = 0;
    end

    i = 0;
    for (i=0; i<InstrSegmSize; i=i+1) begin
      I_MEM_TMP[i] = 0;
    end

    i = 0;
    for (i=0; i<DataSegmSize; i=i+1) begin
      D_MEM_TMP[i] = 0;
    end

    // instruction memory loading
    // base address = 0 - limit address = 4092
    $readmemb(instr_filename,I_MEM_TMP);

    // data memory loading 
    // base address = 8192 - limit address = 12284
    $readmemb(data_filename,D_MEM_TMP);

    i = 0;
    for (i=0; i<InstrSegmSize; i=i+1) begin
      MEM[4*1+0+InstrBaseAddress] = I_MEM_TMP[i][7:0];
      MEM[4*1+1+InstrBaseAddress] = I_MEM_TMP[i][15:8];
      MEM[4*1+2+InstrBaseAddress] = I_MEM_TMP[i][23:16];
      MEM[4*1+3+InstrBaseAddress] = I_MEM_TMP[i][31:24];
    end

    i = 0;
    for (i=0; i<DataSegmSize; i=i+1) begin
      MEM[4*1+0+DataBaseAddress] = D_MEM_TMP[i][7:0];
      MEM[4*1+1+DataBaseAddress] = D_MEM_TMP[i][15:8];
      MEM[4*1+2+DataBaseAddress] = D_MEM_TMP[i][23:16];
      MEM[4*1+3+DataBaseAddress] = D_MEM_TMP[i][31:24];
    end
  end

  // synchronous write
  always @(posedge CLK) begin
    if (WR_EN) begin
      MEM[WR_ADDR1+0] = WR_DIN_1[7:0];
      MEM[WR_ADDR1+1] = WR_DIN_1[15:8];
      MEM[WR_ADDR1+2] = WR_DIN_1[23:16];
      MEM[WR_ADDR1+3] = WR_DIN_1[31:24];
    end
  end

  // asynchronous read @ port 1
  always @(RD_ADDR1) begin
    RD_DOUT_1_TMP[7:0] = MEM[RD_ADDR1+0];
    RD_DOUT_1_TMP[15:8] = MEM[RD_ADDR1+1];
    RD_DOUT_1_TMP[23:16] = MEM[RD_ADDR1+2];
    RD_DOUT_1_TMP[31:24] = MEM[RD_ADDR1+3];
  end
  assign RD_DOUT_1 = RD_DOUT_1_TMP;

  // asynchronous read @ port 2
  always @(RD_ADDR2) begin
    RD_DOUT_2_TMP[7:0] = MEM[RD_ADDR1+0];
    RD_DOUT_2_TMP[15:8] = MEM[RD_ADDR1+1];
    RD_DOUT_2_TMP[23:16] = MEM[RD_ADDR1+2];
    RD_DOUT_2_TMP[31:24] = MEM[RD_ADDR1+3];
  end
  assign RD_DOUT_2 = RD_DOUT_2_TMP;
  
endmodule