# movsxtest2.s - an example of MOVSX instruction
.section .text
.globl _start
_start:
	movw $79, %cx
	movl $0, %ebx
	movw %cx, %bx
	movsx %cx, %eax
	movl $1, %eax
	movl $0, %ebx
	int $0x80
