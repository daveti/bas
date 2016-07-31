# area.s - area function
.section .text
.type area, @function
.globl area
area:
	pushl %ebp
	movl %esp, %ebp
	sub $4, %esp
	fldpi
	filds 8(%ebp)
	fmul %st(0), %st(0)
	fmulp %st(0), %st(1)
	fstps -4(%ebp)
	movl -4(%ebp), %eax
	
	#addl $4, %esp
	movl %ebp, %esp
	popl %ebp
	ret
