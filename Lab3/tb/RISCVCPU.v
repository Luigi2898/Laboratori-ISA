module RISCVCPU
(input CLK,
 output reg WR_EN,
 output reg RD_EN,
 output [31:0] INSTR_ADDR,
 input  [31:0] INSTR,
 output [31:0] DATA_ADDR,
 output [31:0] DATA_OUT,
 input  [31:0] DATA_IN
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
reg MEM_READ, MEM_WRITE;
reg [31:0] MEM_ADDR, WRITE_DATA;
integer OPCODE; 
integer FUNC3;
integer FUNC7;
integer RS1, RS2, RD;
integer BRANCH = 0;
integer i; 
integer ZERO_FLAG;

// Register File Initialization
initial begin
  PC = 0;

  for (i=0;i<=31;i=i+1) 
      REG_FILE[i] = 0; 
  end


assign INSTR_ADDR = PC;    
assign RD_EN = MEM_READ;
assign WR_EN = MEM_WRITE;
assign DATA_ADDR = MEM_ADDR;
assign DATA_OUT = WRITE_DATA;


  
// CPU Modelling
always @(posedge CLK) begin

  case(BRANCH) 
     0 : PC <= PC + 4;
     1 : PC <= PC + {{{31-20}{INSTR[31]}}, INSTR[19:12], INSTR[20], INSTR[30:25], INSTR[24:21], 1'b0};
  default : PC <= PC;
  endcase

  case(OPCODE)

    ARITH : begin
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
        4'b1000 : // SUB
          REG_FILE[RD] <= REG_FILE[RS1] + REG_FILE[RS2];
        4'b0111 : // AND  
          REG_FILE[RD] <= REG_FILE[RS1] & REG_FILE[RS2];
        4'b0110 : // OR
          REG_FILE[RD] <= REG_FILE[RS1] | REG_FILE[RS2];  
        4'b0010 : //SLT
          begin
          if((~REG_FILE[RS1]+1) < (~REG_FILE[RS2]+1)) 
          REG_FILE[RD] <= 1;
          else 
          REG_FILE[RD] <= 0; 
          end
        4'b0100 : // XOR    
          REG_FILE[RD] <= REG_FILE[RS1] ^ REG_FILE[RS2];                    
        default : $display("Default ARITH");
      endcase
      end

    IMM : begin
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
          REG_FILE[RD] <= REG_FILE[RS1] + {{{31-12}{INSTR[31]}},INSTR[31:20]};        
        3'b111 : // ANDI
          REG_FILE[RD] <= REG_FILE[RS1] & {{{31-12}{INSTR[31]}},INSTR[31:20]};
        3'b101 : // SRAI
          REG_FILE[RD] <= REG_FILE[RS1] >>> {{{31-5}{INSTR[31]}},{{4-0}{INSTR[24:20]}}};
        default :
        $display("Default Immediate");
      endcase
      
      end

    LW : begin
       // Instruction Decode
       OPCODE  = INSTR[6:0];
       RS1     = INSTR[19:15];
       RS2     = INSTR[24:20];
       RD      = INSTR[11:7];
       FUNC3   = INSTR[14:12];
       FUNC7   = INSTR[30];

       MEM_READ <= 1'b1;
       MEM_ADDR = RS1 + {{{31-12}{INSTR[31]}},INSTR[31:20]};
       REG_FILE[RD] <= DATA_IN;       
      end

    SW : begin
       // Instruction Decode
       OPCODE  = INSTR[6:0];
       RS1     = INSTR[19:15];
       RS2     = INSTR[24:20];
       RD      = INSTR[11:7];
       FUNC3   = INSTR[14:12];
       FUNC7   = INSTR[30];

       MEM_WRITE <= 1'b1;
       MEM_ADDR = RS1 + {{{31-12}{INSTR[31]}},INSTR[31:25],INSTR[11:7]};
       WRITE_DATA = RS2;       
      end

    BEQ : begin
       // Instruction Decode
       OPCODE  = INSTR[6:0];
       RS1     = INSTR[19:15];
       RS2     = INSTR[24:20];
       RD      = INSTR[11:7];
       FUNC3   = INSTR[14:12];
       FUNC7   = INSTR[30];
       
       BRANCH = REG_FILE[RS1] - REG_FILE[RS2];         
     end

    JAL : begin
       // Instruction Decode
       OPCODE  = INSTR[6:0];
       RS1     = INSTR[19:15];
       RS2     = INSTR[24:20];
       RD      = INSTR[11:7];
       FUNC3   = INSTR[14:12];
       FUNC7   = INSTR[30];

       BRANCH = 1;
       REG_FILE[RD] <= PC + {{{31-20}{INSTR[31]}}, INSTR[19:12], INSTR[20], INSTR[30:25], INSTR[24:21], 1'b0};
      end 

    LUI : begin
       // Instruction Decode
       OPCODE  = INSTR[6:0];
       RS1     = INSTR[19:15];
       RS2     = INSTR[24:20];
       RD      = INSTR[11:7];
       FUNC3   = INSTR[14:12];
       FUNC7   = INSTR[30];

       REG_FILE[RD] <= {{{31-12}{20'b0}}, INSTR[31], INSTR[30:20], INSTR[19:12]};
       end

    AUIPC : begin
       // Instruction Decode
       OPCODE  = INSTR[6:0];
       RS1     = INSTR[19:15];
       RS2     = INSTR[24:20];
       RD      = INSTR[11:7];
       FUNC3   = INSTR[14:12];
       FUNC7   = INSTR[30];

       REG_FILE[RD] <= PC + {{{31-12}{20'b0}}, INSTR[31], INSTR[30:20], INSTR[19:12]};
       end 
     
     default : $display("Default CASE");        
  endcase
end

endmodule