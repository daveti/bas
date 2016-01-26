	.file	"ifthen.c"
	.section	.rodata
.LC0:
	.string	"The higher value is %d\n"
	.text
	.globl	main
	.type	main, @function
main:
	leal	4(%esp), %ecx
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ecx
	subl	$20, %esp
	movl	$100, -12(%ebp)
	movl	$25, -16(%ebp)
	movl	-12(%ebp), %eax
	cmpl	-16(%ebp), %eax
	jle	.L2
	subl	$8, %esp
	pushl	-12(%ebp)
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	jmp	.L3
.L2:
	subl	$8, %esp
	pushl	-16(%ebp)
	pushl	$.LC0
	call	printf
	addl	$16, %esp
.L3:
	movl	$0, %eax
	movl	-4(%ebp), %ecx
	leave
	leal	-4(%ecx), %esp
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 4.9.2 20150212 (Red Hat 4.9.2-6)"
	.section	.note.GNU-stack,"",@progbits
