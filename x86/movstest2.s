# movstest2.s - a second example of movs instruction
.section .data
value1:
	.ascii "This is a test string.\n"

.section .bss
	.lcomm output, 23

.section .text
.global _start
_start:
	leal value1+22, %esi
	leal output+22, %edi
	std
	movsb
	movsw
	movsl

	mov $1, %eax
	mov $0, %ebx
	int $0x80
