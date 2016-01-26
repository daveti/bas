# cmpxchgtest.s - an example of CMPXCHG instruction
.section .data
data:
	.int 10

.section .text
.globl _start
_start:
	movl $10, %eax
	movl $5, %ebx
	cmpxchg %ebx, data
	movl $1, %eax
	int $0x80
