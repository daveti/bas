# paramtest3.s - An example of using command line parameters
.section .data
output:
	.asciz "The area is: %f\n"
output1:
	.asciz "Parameter number: %d\n"

.section .bss
	.lcomm result, 4

.section .text
.globl _start
_start:
	finit
	#movl (%esp), %ecx
	#pushl %ecx
	pushl (%esp)
	pushl $output1
	call printf
	addl $8, %esp
	#jmp endit
	pushl 8(%esp)
	call atoi
	addl $4, %esp
	movl %eax, result
	fldpi
	filds result
	fmul %st(0), %st(0)
	fmul %st(1), %st(0)
	#fstpl (%esp)
	#This would overwrite the number of parameters on the stack
	pushl $0
	pushl $0
	#NOTE: fstpl load double precision (64-bit) by default
	fstpl (%esp) #NOTE: this does not change the esp
	pushl $output
	call printf
	addl $12, %esp
	#pushl (%esp)
	#Another dumb way
	movl (%esp), %ecx
	pushl %ecx
	pushl $output1
	call printf
	addl $8, %esp
endit:
	pushl $0
	call exit
