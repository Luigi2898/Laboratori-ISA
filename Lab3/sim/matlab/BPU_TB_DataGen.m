clc
clear all
close all

num_samples = 100;
start_addr = 1;
beq_opcode_b = '1100011';
beq_opcode = bin2dec(beq_opcode_b);


prog_count(1) = start_addr;
next_addr = start_addr + 1;
opcodes(1) = randi([1 90]);
outcomes(1) = round(rand(1,1));
target_addr(1) = randi([1 (2^8 - 1)]);

for i = 2:num_samples
    prog_count(i) = next_addr;
    if (round(rand(1,1)) == 1) % BEQ instr
        opcodes(i) = beq_opcode;
        outcomes(i) = round(rand(1,1));
        target_addr(i) = randi([1 (2^8 - 1)]);
        
        if outcomes(i) == 1
            next_addr = target_addr(i);
        else
            next_addr = prog_count(i) + 1;
        end
    else
        opcodes(i) = randi([1 90]);
        outcomes(i) = round(rand(1,1));
        target_addr(i) = randi([1 (2^8 - 1)]);
        next_addr = prog_count(i) + 1;
    end
end

prog_count_print = [prog_count 0 0];
prog_count_del = [0 0 prog_count];
target_addr_del = [0 0 target_addr];
opcodes_del = [0 0 opcodes];
outcomes_del = [0 0 outcomes];

fID1 = fopen('PC.txt','w');
fID2 = fopen('PC_DEL.txt','w');
fID3 = fopen('JMP_FLAG.txt','w');
fID4 = fopen('TARG_ADDR.txt','w');
fID5 = fopen('OPCODE.txt','w');
        
for i = 1:length(prog_count_print)
    
    PC_bin = dec2bin(prog_count_print(i),8);
    PC_DEL_bin = dec2bin(prog_count_del(i),8);
    JMP_bin = dec2bin(outcomes_del(i),8);
    TARG_ADDR_bin = dec2bin(target_addr_del(i),8);
    OPCODE_bin = dec2bin(opcodes_del(i),8);
    
    fprintf(fID1,'%s\n',PC_bin);
    fprintf(fID2,'%s\n',PC_DEL_bin);
    fprintf(fID3,'%s\n',JMP_bin);
    fprintf(fID4,'%s\n',TARG_ADDR_bin);
    fprintf(fID5,'%s\n',OPCODE_bin);
    
end



        
fclose(fID1);
fclose(fID2);
fclose(fID3);
fclose(fID4);
fclose(fID5);
        