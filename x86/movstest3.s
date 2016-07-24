# movstest3.s - an example of moving an entire string
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
loop1:
	movsb
	loop loop1

	movl $1, %eax
	movl $0, %ebx
	int $0x80
