# addtest3.s - an example of ADD with carry condition
.section .text
.globl _start
_start:
	movl $0, %ebx
	movb $190, %bl
	movb $100, %al
	addb %al, %bl
	jc carry
	movl $1, %eax
	int $0x80
carry:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
