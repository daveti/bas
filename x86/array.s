	.file	"array.c"
	.globl	b
	.data
	.align 4
	.type	b, @object
	.size	b, 20
b:
	.long	123
	.long	87
	.long	487
	.long	7
	.long	978
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$32, %esp
	movl	$0, -4(%ebp)
	jmp	.L2
.L3:
	movl	-4(%ebp), %eax
	movl	-4(%ebp), %edx
	movl	%edx, -24(%ebp,%eax,4)
	movl	-4(%ebp), %eax
	movl	-4(%ebp), %edx
	movl	%edx, b(,%eax,4)
	addl	$1, -4(%ebp)
.L2:
	cmpl	$4, -4(%ebp)
	jle	.L3
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 4.9.2 20150212 (Red Hat 4.9.2-6)"
	.section	.note.GNU-stack,"",@progbits
