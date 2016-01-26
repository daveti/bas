# cmptest.s - an example of CMP and JGE instructions
.section .text
.globl _start
_start:
	movl $15, %eax
	movl $10, %ebx
	cmp %eax, %ebx
	jge greater
	movl $1, %eax
	int $0x80

greater:
	movl $20, %ebx
	movl $1, %eax
	int $0x80
