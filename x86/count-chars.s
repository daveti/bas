# Count the chars

.equ ST_STRING_START_ADDRESS, 8

.globl count_chars
.type count_chars, @function

count_chars:
	pushl %ebp
	movl %esp, %ebp

	movl $0, %ecx
	movl ST_STRING_START_ADDRESS(%ebp), %edx

count_loop_begin:
	movb (%edx), %al
	cmpb $0, %al
	je count_loop_end
	incl %ecx
	incl %edx
	jmp count_loop_begin

count_loop_end:
	movl %ecx, %eax
	# No need to recover esp
	popl %ebp
	ret

