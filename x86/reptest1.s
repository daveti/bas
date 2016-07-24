# reptest1.s - an example of rep instruction
.section .data
value1:
	.ascii "This is a test string.\n"

.section .bss
	.lcomm output, 23

.section .text
.global _start
_start:
	leal value1, %esi
	leal output, %edi
	movl $23, %ecx
	cld
	rep movsb

	movl $1, %eax
	movl $0, %ebx
	int $0x80
