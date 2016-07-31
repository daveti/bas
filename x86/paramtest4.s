# paramtest4.s - An example of using command line parameters
.section .data
output1:
	.asciz "Parameter number: %d\n"

.section .text
.globl _start
_start:
	movl (%esp), %ecx
	pushl %ecx
	pushl output1 # Been debugging this stupid mistake for a while...sigh
	call printf
	addl $8, %esp
	pushl $0
	call exit
