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
wire FUNC7;
wire [31:0] RS1_VAL, RS2_VAL;

//controls
wire BRANCH;
wire MEM_READ;
wire MEM_TO_REG;
wire MEM_WRITE;
wire ALUSRC;
wire [1:0] ALUOP;
wire REG_WRITE;
wire JMP;
reg [8:0] CU_CTRL;
reg [3:0] ALU_CTRL;

//alu
reg [31:0] ALU_RES;
reg [31:0] ALU_IN1, ALU_IN2;


assign OPCODE  = INSTR[6:0];
assign RS1     = INSTR[19:15];
assign RS2     = INSTR[24:20];
assign RD      = INSTR[11:7];
assign FUNC3   = INSTR[14:12];
assign FUNC7   = INSTR[30];

integer i; 
initial
begin
PC = 0;

for (i=0;i<=31;i=i+1) 
     REG_FILE[i] = 0; 
end

end

assign {ALUSRC,MEM_TO_REG,REG_WRITE,MEM_READ,MEM_WRITE,BRANCH,JMP,ALUOP} = CU_CTRL;
always @(OPCODE)
begin
case(OPCODE)
ARITH   : CU_CTRL <= 9'b001000010; 
LW      : CU_CTRL <= 9'b111100000; 
SW      : CU_CTRL <= 9'b1x0010000; 
BEQ     : CU_CTRL <= 9'b0x0001001; 
IMM     : CU_CTRL <= 9'b101000011; 
JAL     : CU_CTRL <= 9'b111xx0100; 
LUI     : CU_CTRL <= 9'b101000011; 
AUIPC   : CU_CTRL <= 9'b101000011; 
default : CU_CTRL <= 9'b000000000;
endcase
end

always @(CU_CTRL[1:0])
begin
case (CU_CTRL[1:0])
2'b00 : ALU_CTRL <= 4'b0010;
2'b01 : ALU_CTRL <= 4'b0110;
2'b10 : case({FUNC7,FUNC3})
4'b0000 : ALU_CTRL <= 4'b0010; // add
4'b1000 : ALU_CTRL <= 4'b0110; // sub
4'b0111 : ALU_CTRL <= 4'b0000; // and
4'b0110 : ALU_CTRL <= 4'b0001; // or
4'b0010 : ALU_CTRL <= 4'b0100; // slt
4'b0100 : ALU_CTRL <= 4'b0111; // xor
default : ALU_CTRL <= 4'b0000;
endcase
2'b11 : case({FUNC7,FUNC3})
4'b0000 : ALU_CTRL <= 4'b0010; // addi
4'b0111 : ALU_CTRL <= 4'b0000; // andi
4'b1101 : ALU_CTRL <= 4'b1010; // srai
default : ALU_CTRL <= 4'b0000;
endcase
endcase
end





always @(posedge CLK)
begin

end
endmodule