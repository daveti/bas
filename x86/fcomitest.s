# fcomitest.s - an example of FCOMI instruciton
.section .data
value1:
	.float 10.923
value2:
	.float 4.5532

.section .text
.globl _start
_start:
	flds value2
	flds value1
	fcomi
	ja greater
	jb lessthan
	movl $1, %eax
	movl $0, %ebx
	int $0x80
greater:
	movl $1, %eax
	movl $2, %ebx
	int $0x80
lessthan:
	movl $1, %eax
	movl $1, %ebx
	int $0x80
