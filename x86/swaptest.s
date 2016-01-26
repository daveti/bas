# swaptest.s - an example of BSWAP instruction
.section .text
.globl _start
_start:
	movl $0x12345678, %ebx
	bswap %ebx
	movl $1, %eax
	int $0x80
