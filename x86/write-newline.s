# Write a newline to the file

.include "linux.s"

.equ ST_FILEDES, 8

.data

newline:
	.ascii "\n"

.text

.globl write_newline
.type write_newline, @function

write_newline:
	pushl %ebp
	movl %esp, %ebp

	movl $SYS_WRITE, %eax
	movl ST_FILEDES(%ebp), %ebx
	movl $newline, %ecx
	movl $1, %edx
	int $LINUX_SYSCALL

	movl %ebp, %esp
	popl %ebp
	ret
