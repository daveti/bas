# reptest2.s - an incorrect example of rep instructions
.section .data
value1:
	.ascii "This is a test string.\n"
value2:
	.ascii "Oops"

.section .bss
	.lcomm output, 23

.section .text
.global _start
_start:
	leal value1, %esi
	leal output, %edi
	movl $6, %ecx
	cld
	rep movsl

	movl $1, %eax
	movl $0, %ebx
	int $0x80
