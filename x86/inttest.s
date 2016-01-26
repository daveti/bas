# inttest.s - an example of using signed integer
.section .data
data:
	.int -45

.section .text
.globl _start
_start:
	movl $-345, %ecx
	movw $0xffb1, %dx
	movl data, %ebx
	movl $1, %eax
	int $0x80
