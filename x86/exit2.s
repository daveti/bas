# Play with exit syscall

.data

.text

.globl main

main:
	movl $1, %eax
	movl $77, %ebx
	int $0x80
