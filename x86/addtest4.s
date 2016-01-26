# addtest4.s - an example of ADD with a overflow condition
.section .data
output:
	.asciz "The result is %d\n"

.section .text
.globl _start
_start:
	movl $-1590876934, %ebx
	movl $-1259230143, %eax
	addl %eax, %ebx
	jo over
	pushl %ebx
	pushl $output
	call printf
	add $8, %esp
	pushl $0
	call exit
over:
	pushl $0
	pushl $output
	call printf
	add $8, %esp
	pushl $0
	call exit