#################
# BPU - TEST PROGRAM 2 - CORRELATE BRANCHES
# This program takes an array v, interprets it as a 50 rows x 40 columns matrix
# and sums at each element +5


	.data
	.align	2
v:
	.word 1
m:
	.word	0

	.text
	.align	2
	.globl	__start
__start:
	li x16,2000       # put the length of v in x16 
	la x4,v           # put in x4 the address of v
	li x24,50 	  # put in x24 the number of rows
	li x25, 40	  # put in x25 the number of columns

rows_loop:	
	beq x24,x0,done   # check all rows have been tested
	addi x24,x24,-1   # decrease remaining rows by 1
	li x25, 40	  # put in x25 the number of columns
	
column_loop:	
	add x26,x4,x0    	# store in x26 the i-th address of the element
	lw x8,0(x4)      	# load new element in x8
	addi x8,x8,5	  	# add +5 to the element
	addi x4,x4,0x4	  	# point to next element
	addi x25,x25,-1   	# decrease remaining columns by 1
	sw x8,0(x26)	        # store modified element
	beq x25,x0,rows_loop    # finished column cycle?
	jal column_loop         # next column element
	
done:		
	jal done  	  # infinite loop
	addi x0,x0,0
