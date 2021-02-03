	.data
	.align	2
v:
	.word	10

	.text
	.align	2
	.globl	__start
__start:
la x4,v 
lw x2, 0(x4) # 