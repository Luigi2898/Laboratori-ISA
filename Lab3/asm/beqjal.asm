addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
lui x5, 8 # x5 = 8
lui x7, 10 # x7 = 10
loop:
addi x7, x7, -1 # x7 = x7 - 1
beq x5, x7, loop # if x5 == x7 then loop
addi x0, x0, 0
addi x0, x0, 0
jal ju  # jump to target and save position to ra
addi x8, x5, 9 # x8 = x5 + 9
ju:
addi x8, x5, 22 # x8 = x5 + 22
