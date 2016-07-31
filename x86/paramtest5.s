# paramtest1.s - Listing command line parameters
.section .data
output1:
	.asciz "There are %d parameters:\n"
output2:
	.asciz "Parameter number: %d\n"

.section .text
.globl _start
_start:
	movl (%esp), %ecx
	pushl %ecx
	pushl $output2
	call printf
	pushl $0
	call exit
