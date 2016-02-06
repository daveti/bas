# trigtest2.s - an example of FSINCOS instruciton
.section .data
degree1:
	.float 90.0
val180:
	.int 180

.section .bss
	.lcomm sinresult, 4
	.lcomm cosresult, 4

.section .text
.globl _start
_start:
	finit
	flds degree1
	fidivs val180
	fldpi
	fmul %st(1), %st(0)
	fsincos
	fstps cosresult
	fsts sinresult

	movl $1, %eax
	movl $0, %ebx
	int $0x80
