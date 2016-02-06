# premtest.s - an example of using FPREM1 instruction
.section .data
value1:
	.float 20.65
value2:
	.float 3.97

.section .bss
	.lcomm result, 4

.section .text
.globl _start
_start:
	finit
	flds value2
	flds value1
loop:
	fprem1
	fstsw %ax
	testb $4, %ah
	jnz loop

	fsts result
	movl $1, %eax
	movl $0, %ebx
	int $0x80
