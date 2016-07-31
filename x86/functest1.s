# functest1.s - An example of using functions
.section .data
precision:
	.byte 0x7f, 0x00

.section .bss
	.lcomm value, 4

.section .text
.globl _start
_start:
	finit
	fldcw precision
	movl $10, %ebx
	call area
	movl $100, %ebx
	call area
	movl $1, %eax
	movl $0, %ebx
	int $0x80

.type area, @function
area:
	fldpi
	imull %ebx, %ebx
	movl %ebx, value
	filds value
	fmulp %st(0), %st(1)
	#fstps %eax --- there is no way to move data from st to eax
	#Need to use the stack (or the bss variable)
	sub $4, %esp
	fstps (%esp)
	movl (%esp), %eax
	add $4, %esp
	ret
