#################
# Basic VERSION	
# This program takes an array v and computes
# min{|v[i]|}, the minimum of the absolute value,
# where v[i] is the i-th element in the array
	.data
	.align	2
v:
    .word  20
    .word  -21
    .word  15
    .word  22
    .word  -18
    .word  -24
    .word  -15
    .word  -18
    .word  -7
    .word  -8
    .word  22
    .word  -21
    .word  11
    .word  -13
    .word  24
    .word  -16
    .word  -8
    .word  -14
    .word  20
    .word  25
    .word  -23
    .word  9
    .word  -19
    .word  11
    .word  -1
    .word  -4
    .word  20
    .word  20
    .word  15
    .word  7
    .word  0
    .word  6
    .word  -23
    .word  19
    .word  14
    .word  21
    .word  1
    .word  -12
    .word  10
    .word  -25
    .word  23
    .word  -21
    .word  0
    .word  10
    .word  -14
    .word  -22
    .word  -19
    .word  -1
    .word  -24
    .word  -20
    .word  -7
    .word  -23
    .word  -9
    .word  -17
    .word  -19
    .word  -20
    .word  18
    .word  3
    .word  -13
    .word  1
    .word  -21
    .word  7
    .word  -11
    .word  23
    .word  -12
    .word  14
    .word  23
    .word  -2
    .word  -16
    .word  5
    .word  -19
    .word  -17
    .word  -22
    .word  -18
    .word  -2
    .word  -13
    .word  13
    .word  -11
    .word  -7
    .word  24
    .word  1
    .word  -14
    .word  -21
    .word  -17
    .word  19
    .word  -2
    .word  -11
    .word  4
    .word  -14
    .word  8
    .word  5
    .word  -5
    .word  5
    .word  -18
    .word  23
    .word  -22
    .word  25
    .word  -18
    .word  3
    .word  0
    .word  14
    .word  12
    .word  17
    .word  -14
    .word  -19
    .word  -17
    .word  -3
    .word  -5
    .word  14
    .word  5
    .word  -23
    .word  -14
    .word  -4
    .word  -21
    .word  20
    .word  19
    .word  -24
    .word  -2
    .word  25
    .word  -19
    .word  -23
    .word  -13
    .word  -14
    .word  -5
    .word  23
    .word  13
    .word  8
    .word  6
    .word  21
    .word  -21
    .word  20
    .word  20
    .word  21
    .word  -16
    .word  6
    .word  22
    .word  -21
    .word  21
    .word  2
    .word  13
    .word  21
    .word  0
    .word  -1
    .word  -3
    .word  -18
    .word  -9
    .word  -24
    .word  1
    .word  -17
    .word  2
    .word  5
    .word  -6
    .word  -11
    .word  -11
    .word  1
    .word  12
    .word  10
    .word  4
    .word  21
    .word  -12
    .word  21
    .word  -24
    .word  -16
    .word  9
    .word  -9
    .word  -21
    .word  -6
    .word  4
    .word  25
    .word  24
    .word  -20
    .word  0
    .word  19
    .word  -1
    .word  0
    .word  1
    .word  -24
    .word  10
    .word  12
    .word  1
    .word  20
    .word  -2
    .word  -2
    .word  3
    .word  -24
    .word  -14
    .word  -7
    .word  -6
    .word  22
    .word  17
    .word  -25
    .word  24
    .word  5
    .word  21
    .word  -18
    .word  -17
    .word  -22
    .word  -12
    .word  -16
    .word  12
    .word  -24
    .word  24
    .word  16
    .word  -22
    .word  -1
    .word  -14
    .word  -19
    .word  -21
    .word  23
    .word  -22
    .word  21
    .word  -14
    .word  18
    .word  -11
    .word  17
    .word  24
    .word  -12
    .word  -11
    .word  19
    .word  4
    .word  13
    .word  -20
    .word  -5
    .word  -25
    .word  0
    .word  5
    .word  3
    .word  -4
    .word  1
    .word  -20
    .word  -25
    .word  -24
    .word  9
    .word  -23
    .word  -12
    .word  -9
    .word  0
    .word  -13
    .word  3
    .word  -20
    .word  -24
    .word  0
    .word  4
    .word  11
    .word  -8
    .word  -14
    .word  -16
    .word  2
    .word  -13
    .word  23
    .word  10
    .word  -1
    .word  -24
    .word  16
    .word  -1
    .word  10
    .word  -12
    .word  8
    .word  18
    .word  -17
    .word  5
    .word  -15
    .word  12
    .word  -14
    .word  -7
    .word  -14
    .word  -2
    .word  11
    .word  19
    .word  6
    .word  3
    .word  -12
    .word  -16
    .word  12
    .word  -16
    .word  24
    .word  3
    .word  -25
    .word  11
    .word  -1
    .word  -15
    .word  3
    .word  -3
    .word  -22
    .word  -7
    .word  -6
    .word  -3
    .word  -22
    .word  3
    .word  8
    .word  -13
    .word  -23
    .word  -8
    .word  -23
    .word  24
    .word  -17
    .word  -1
    .word  13
    .word  -23
    .word  -17
    .word  -9
    .word  -9
    .word  -1
    .word  19
    .word  25
    .word  -14
    .word  -8
    .word  22
    .word  -4
    .word  24
    .word  -20
    .word  -17
    .word  -25
    .word  4
    .word  18
    .word  -19
    .word  -19
    .word  9
    .word  -21
    .word  -7
    .word  14
    .word  -18
    .word  -2
    .word  -16
    .word  10
    .word  16
    .word  22
    .word  10
    .word  -25
    .word  17
    .word  -15
    .word  12
    .word  21
    .word  11
    .word  22
    .word  -5
    .word  -12
    .word  0
    .word  5
    .word  17
    .word  -3
    .word  -7
    .word  18
    .word  17
    .word  25
    .word  -9
    .word  0
    .word  -20
    .word  -19
    .word  -10
    .word  -2
    .word  9
    .word  8
    .word  15
    .word  7
    .word  -15
    .word  -2
    .word  12
    .word  -8
    .word  -17
    .word  13
    .word  10
    .word  -15
    .word  23
    .word  14
    .word  -15
    .word  -17
    .word  -17
    .word  5
    .word  -15
    .word  -3
    .word  9
    .word  -12
    .word  7
    .word  -2
    .word  -2
    .word  13
    .word  20
    .word  -20
    .word  11
    .word  -4
    .word  -16
    .word  -6
    .word  5
    .word  -17
    .word  6
    .word  -21
    .word  18
    .word  12
    .word  -6
    .word  -15
    .word  9
    .word  6
    .word  -21
    .word  -21
    .word  4
    .word  6
    .word  11
    .word  7
    .word  7
    .word  12
    .word  -9
    .word  7
    .word  14
    .word  8
    .word  24
    .word  -20
    .word  18
    .word  17
    .word  18
    .word  -13
    .word  6
    .word  2
    .word  -3
    .word  17
    .word  -8
    .word  3
    .word  -8
    .word  3
    .word  -25
    .word  24
    .word  -25
    .word  15
    .word  6
    .word  21
    .word  -4
    .word  13
    .word  -21
    .word  -12
    .word  -25
    .word  3
    .word  9
    .word  -1
    .word  15
    .word  1
    .word  14
    .word  -13
    .word  -5
    .word  12
    .word  10
    .word  10
    .word  19
    .word  -2
    .word  1
    .word  23
    .word  4
    .word  2
    .word  -21
    .word  10
    .word  -17
    .word  18
    .word  -25
    .word  -13
    .word  -18
    .word  -7
    .word  16
    .word  16
    .word  -20
    .word  20
    .word  -6
    .word  24
    .word  24
    .word  -19
    .word  -17
    .word  12
    .word  -3
    .word  -15
    .word  9
    .word  9
    .word  3
    .word  12
    .word  9
    .word  8
    .word  16
    .word  -4
    .word  2
    .word  -2
    .word  22
    .word  -16
    .word  7
    .word  -23
    .word  -19
    .word  14
    .word  21
    .word  -3
    .word  0
    .word  -1
    .word  24
    .word  20
    .word  -10
    .word  8
    .word  -2
    .word  -8
    .word  -11
    .word  17
    .word  24
    .word  18
    .word  19
    .word  14
    .word  2


m:
	.word	0

	.text
	.align	2
	.globl	__start
__start:
    li x16,500        # put 500 in x16   
	la x4,v           # put in x4 the address of v
	la x5,m           # put in x5 the address of m
	li x13,0x3fffffff # init x13 with max pos
loop:	
	beq x16,x0,done   # check all elements have been tested
	lw x8,0(x4)       # load new element in x8
	srai x9,x8,31     # apply shift to get sign mask in x9
	xor x10,x8,x9     # x10 = sign(x8)^x8
	andi x9,x9,0x1    # x9 &= 0x1 (carry in)
	add x10,x10,x9    # x10 += x9 (add the carry in)
	addi x4,x4,0x4	  # point to next element
	addi x16,x16,-1   # decrease x16 by 1
	slt x11,x10,x13   # x11 = (x10 < x13) ? 1 : 0
	beq x11,x0,loop   # next element
	add x13,x10,x0    # update min
	jal loop          # next element
done:	
	sw x13,0(x5)      # store the result	
endc:	
	jal endc  	  # infinite loop
	addi x0,x0,0
	
