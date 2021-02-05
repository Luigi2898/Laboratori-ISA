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

reg  [31:0] PC;
reg  [31:0] REG_FILE[0:31];
wire [4:0] RS1, RS2, RD; 
wire [6:0] OPCODE; 
wire [2:0] FUNC3;
wire [31:0] ALU_IN1, ALU_IN2;
wire [31:0] RS1_VAL, RS2_VAL;
wire [2:0] ALU_CTRL;
wire ALUSRC;
//controls
wire BRANCH;
wire MEM_READ;
wire MEM_TO_REG;
wire MEM_WRITE;
wire ALUSRC;
wire REG_WRITE;
wire JMP;

assign OPCODE  = INSTR[6:0];
assign RS1     = INSTR[19:15];
assign RS2     = INSTR[24:20];
assign RD      = INSTR[11:7];
assign FUNC3   = INSTR[14:12];

integer i; 
initial
begin
PC = 0;

for (i=0;i<=31;i=i+1) 
     REG_FILE[i] = 0; 
end

end


always @(OPCODE) begin
case(OPCODE) begin
  
  LW : begin
       ALUSRC     = 1'b1;
       IMM_EN     = 1'b1;
       IMM_CODE   = 3'b000;
       ALU_CTRL   = 3'b000; //sum
       RD_EN      = 1'b1;
       MEM_TO_REG = 1'b1;
       REG_WRITE  = 1'b1;
       end

  SW : begin
       ALUSRC   = 1'b1;
       IMM_EN   = 1'b1;
       IMM_CODE = 3'b001;
       ALU_CTRL = 3'b000; //sum
       WR_EN    = 1'b1;
       end

  BEQ : begin
        BRANCH = 1'b1;
        ALUSRC = 1'b1;  
        IMM_EN = 1'b1;
        IMM_CODE = 3'b010;
        ALU_CTRL = 3'b001; //diff
        end

  LUI : begin
        MEM_TO_REG = 1'b0; 
        REG_WRITE = 1'b1;  
        IMM_EN = 1'b1;
        IMM_CODE = 3'b011;        
        end

  AUIPC : begin
        ALUSRC   = 1'b1;
        REG_WRITE = 1'b1;  
        IMM_EN = 1'b1;
        IMM_CODE = 3'b010;
        ALU_CTRL = 3'b000; //sum
        MEM_TO_REG = 1'b0;      
        end

   JAL : begin
        BRANCH = 1'b1;
        IMM_EN = 1'b1;
        IMM_CODE = 3'b100;              
        end

    ARITH: begin
      
      case(FUNC3) begin
           
           3'b000 : ALU_RES_OUT = RS1_VAL + RS2_VAL;

    end
end
end


always @(posedge CLK)
begin

end
endmodule