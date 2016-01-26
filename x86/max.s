# Find the max number

.data

data_items:
	.long 3, 67, 34, 222, 777, 45, 75, 0

.text

.global main

main:
	movl $0, %edi
	movl data_items(,%edi,4), %eax
	movl %eax, %ebx

start_loop:
	cmpl $0, %eax
	je loop_exit
	incl %edi
	movl data_items(,%edi,4), %eax
	cmpl %ebx, %eax
	jle start_loop

	movl %eax, %ebx
	jmp start_loop

loop_exit:
	movl $1, %eax
	movl data_items, %ebx
	int $0x80

