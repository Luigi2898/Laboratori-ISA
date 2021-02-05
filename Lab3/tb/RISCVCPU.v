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
reg [5:0] CU_CTRL;

//alu
reg [31:0] ALU_RES;
reg [31:0] ALU_IN1, ALU_IN2;


//immediate-code
reg [31:0] IMM_GEN_OUT;

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

assign {MEM_TO_REG,REG_WRITE,MEM_READ,MEM_WRITE,BRANCH,JMP} = CU_CTRL;
always @(INSTR)
begin
case(OPCODE)
ARITH   : begin
          CU_CTRL <= 6'b010000;
          IMM_GEN_OUT <= {{{31-12}{INSTR[31]}},INSTR[31:20]};
          end

LW      : begin
          CU_CTRL <= 6'b111000; 
          IMM_GEN_OUT <= {{{31-12}{INSTR[31]}},INSTR[31:20]};
          end

SW      : begin
          CU_CTRL <= 6'bx00100; 
          IMM_GEN_OUT <= {{{31-12}{INSTR[31]}},INSTR[31:25],INSTR[11:7]};
          end

BEQ     : begin
          CU_CTRL <= 6'b0x00010; 
          IMM_GEN_OUT <= {{{31-12}{INSTR[31]}},INSTR[7],INSTR[30:25],INSTR[11:8], 1'b0};
          end

IMM     : begin
          CU_CTRL <= 6'b010000; 
          IMM_GEN_OUT <= {{{31-12}{INSTR[31]}},INSTR[31:20]};
          end

JAL     : CU_CTRL <= 6'b11xx01;
          IMM_GEN_OUT <= {{{31-12}{INSTR[31]}},INSTR[31:20]};
          end 

LUI     : begin
          CU_CTRL <= 6'b010000; 
          IMM_GEN_OUT <= {{31-12}{1'b0}}, INSTR[31], INSTR[30:20], INSTR[19:12]}
          end

AUIPC   : begin
          CU_CTRL <= 6'b010000;
          IMM_GEN_OUT <= {{31-12}{1'b0}}, INSTR[31], INSTR[30:20], INSTR[19:12]}
          end 
default : CU_CTRL <= 6'bxxxxxx;
endcase
end



always @(posedge CLK)
begin

end
endmodule