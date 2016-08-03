	.file	"asmtest.c"
	.section	.rodata
.LC0:
	.string	"The result is %d\n"
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
	movl	$10, -12(%ebp)
	movl	$20, -16(%ebp)
	movl	-12(%ebp), %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -20(%ebp)
#APP
# 10 "asmtest.c" 1
	nop
# 0 "" 2
#NO_APP
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	movl	$0, %eax
	movl	-4(%ebp), %ecx
	leave
	leal	-4(%ecx), %esp
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 6.1.1 20160621 (Red Hat 6.1.1-3)"
	.section	.note.GNU-stack,"",@progbits
