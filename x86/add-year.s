# Modify the records to add a year for the age

.include "record-def.s"
.include "linux.s"

.equ ST_INPUT_DESCRIPTOR, -4
.equ ST_OUTPUT_DESCRIPTOR, -8

.data

input_file_name:
	.ascii "test.dat\0"

output_file_name:
	.ascii "testout.dat\0"

open_file_error_code:
	.ascii "0001: \0"

open_file_error_msg:
	.ascii "Can't open input file\0"

.bss

.lcomm record_buffer, RECORD_SIZE

.text

.globl _start
_start:
	movl %esp, %ebp
	subl $8, %esp

	movl $SYS_OPEN, %eax
	movl $input_file_name, %ebx
	movl $0, %ecx
	movl $0666, %edx
	int $LINUX_SYSCALL

	movl %eax, ST_INPUT_DESCRIPTOR(%ebp)

	# Error handling
	cmpl $0, %eax
	jl error_handling

	movl $SYS_OPEN, %eax
	movl $output_file_name, %ebx
	movl $0101, %ecx
	movl $0666, %edx
	int $LINUX_SYSCALL

	movl %eax, ST_OUTPUT_DESCRIPTOR(%ebp)

loop_begin:
	pushl ST_INPUT_DESCRIPTOR(%ebp)
	pushl $record_buffer
	call read_record
	addl $8, %esp

	cmpl $RECORD_SIZE, %eax
	jne loop_end

	incl record_buffer + RECORD_AGE

	pushl ST_OUTPUT_DESCRIPTOR(%ebp)
	pushl $record_buffer
	call write_record
	addl $8, %esp

	jmp loop_begin

loop_end:
	movl $SYS_EXIT, %eax
	movl $0, %ebx
	int $LINUX_SYSCALL

error_handling:
	pushl $open_file_error_msg
	pushl $open_file_error_code
	call error_exit
