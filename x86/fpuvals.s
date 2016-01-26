# fpuvals.s - an example of pushing float point constants
.section .text
.globl _start
_start:
	fld1
	fldl2t
	fldl2e
	fldpi
	fldlg2
	fldln2
	fldz
	movl $1, %eax
	movl $0, %ebx
	int $0x80
