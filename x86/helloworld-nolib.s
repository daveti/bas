.include "linux.s"

.data

helloworld:
	.ascii "hello world\n"
helloworld_end:

.equ helloworld_len, helloworld_end - helloworld

.text
.globl _start
_start:
	movl $STDOUT, %ebx
	movl $helloworld, %ecx
	movl $helloworld_len, %edx
	movl $SYS_WRITE, %eax
	int $LINUX_SYSCALL

	movl $0, %ebx
	movl $SYS_EXIT, %eax
	int $LINUX_SYSCALL
