# fpuenv.s - an exmaple of FSTENV and FLDENV instructions
.section .data
value1:
	.float 12.34
value2:
	.float 56.789
rup:
	.byte 0x7f, 0x0b

.section .bss
	.lcomm buffer, 28

.section .text
.globl _start
_start:
	finit
	flds value1
	flds value2
	fldcw rup
	fstenv buffer

	finit
	flds value2
	flds value1
	fldenv buffer

	movl $1, %eax
	mov $0, %ebx
	int $0x80
