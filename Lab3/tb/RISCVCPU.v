module RISCVCPU ();
(
  input CLK;
  output WR_EN;
  output RD_EN;
  output [31:0] INSTR_ADDR;
  input  [31:0] INSTR;
  output [31:0] DATA_ADDR;
  output [31:0] DATA_OUT;
  input  [31:0] DATA_IN;
  input  [31:0] IMM_GEN_OUT;
  output IMM_EN;
  output IMM_CODE
);

// Instruction opcodes
parameter LW = 7'b0000011;
parameter SW = 7'b0100011;
parameter BEQ = 7'b1100011;
parameter ARITH = 7'b0110011;
parameter IMM = 7'b0010011; 
parameter LUI = 7'b0110111;
parameter AUIPC = 7'b0010111;
parameter JAL = 7'b1101111;

// clock registers
reg  [31:0] PC;
reg  [31:0] REG_FILE[0:31];

integer OPCODE; 
integer FUNC3;
integer FUNC7;
integer RS1, RS2, RD;
integer IMM, EXTENDED_IMM;

integer i; 

// Register File Initialization
initial begin
  PC = 0;

  for (i=0;i<=31;i=i+1) 
      REG_FILE[i] = 0; 
  end

end

// CPU Modelling
always @(posedge CLK) begin

  case(OPCODE)

    ARITH : 
      // Instruction Decode
      OPCODE  = INSTR[6:0];
      RS1     = INSTR[19:15];
      RS2     = INSTR[24:20];
      RD      = INSTR[11:7];
      FUNC3   = INSTR[14:12];
      FUNC7   = INSTR[30];

      // Instruction Execute + Write Back
      case ({FUNC7, FUNC3})
        4'b0000 : // ADD
          REG_FILE[RD] <= REG_FILE[RS1] + REG_FILE[RS2];
        default : ;
      endcase


    IMM :
      // Instruction Decode
      OPCODE  = INSTR[6:0];
      RS1     = INSTR[19:15];
      RS2     = INSTR[24:20];
      RD      = INSTR[11:7];
      FUNC3   = INSTR[14:12];
      FUNC7   = INSTR[30];

      // Instruction Execute + Write Back
      case (FUNC3)
        3'b000 : // ADDI
          REG_FILE[RD] = REG_FILE[RS1] + INSTR[31:19];
        
        3'b111 : // ANDI
          REG_FILE[RD] = REG_FILE[RS1] & {ININSTR[31:19];

        
  endcase
end


endmodule