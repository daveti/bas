# functest4.s - An example of using C style functions
.section .data
precision:
	.byte 0x7f, 0x00

.section .bss
	.lcomm result, 4

.section .text
.globl _start
_start:
	finit
	fldcw precision

	pushl $10
	call area
	addl $4, %esp
	movl %eax, result

	pushl $100
	call area
	addl $4, %esp
	movl %eax, result

	movl $1, %eax
	movl $0, %ebx
	int $0x80
