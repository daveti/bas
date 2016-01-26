# jmptest.s - an example of JMP instruction
.section .text
.globl _start
_start:
	movl $1, %eax
	jmp overhere
	movl $10, %ebx
	int $0x80
overhere:
	movl $20, %ebx
	int $0x80
