# ifthen2.s - an example of weird ESP manipulation
.section .data
output:
	.asciz "The higher value is %d\n"

.section .text
.globl _start
_start:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl $100, -4(%ebp)
	movl $25, -8(%ebp)
	movl -4(%ebp), %eax
	cmpl -8(%ebp), %eax
	jle L2
	movl -4(%ebp), %eax
	movl %eax, 4(%esp)
	movl $output, (%esp)
	call printf
	jmp Done
L2:
	movl -8(%ebp), %eax
	movl %eax, 4(%esp)
	movl $output, (%esp)
	call printf
Done:
	movl $0, (%esp)
	call exit
