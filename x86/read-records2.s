# Read reconds from the dat file
# Use allocator

.include "record-def.s"
.include "linux.s"

.equ ST_INPUT_DESCRIPTOR, -4
.equ ST_OUTPUT_DESCRIPTOR, -8

.data

file_name:
	.ascii "test.dat\0"

record_buffer_ptr:
	.long 0

.text

.globl _start
_start:
	movl %esp, %ebp
	subl $8, %esp

	call allocate_init

	pushl $RECORD_SIZE
	call allocate
	movl %eax, record_buffer_ptr

	movl $SYS_OPEN, %eax
	movl $file_name, %ebx
	movl $0, %ecx
	movl $0666, %edx
	int $LINUX_SYSCALL

	movl %eax, ST_INPUT_DESCRIPTOR(%ebp)
	movl $STDOUT, ST_OUTPUT_DESCRIPTOR(%ebp)

record_read_loop:
	pushl ST_INPUT_DESCRIPTOR(%ebp)
	pushl record_buffer_ptr
	call read_record
	addl $8, %esp

	cmpl $RECORD_SIZE, %eax
	jne finished_reading

	movl record_buffer_ptr, %eax
	addl $RECORD_FIRSTNAME, %eax
	pushl %eax
	call count_chars
	addl $4, %esp

	movl %eax, %edx
	movl ST_OUTPUT_DESCRIPTOR(%ebp), %ebx
	movl $SYS_WRITE, %eax
	movl record_buffer_ptr, %ecx
	addl $RECORD_FIRSTNAME, %ecx
	int $LINUX_SYSCALL

	pushl ST_OUTPUT_DESCRIPTOR(%ebp)
	call write_newline
	addl $4, %esp

	jmp record_read_loop

finished_reading:
	pushl record_buffer_ptr
	call deallocate

	movl $SYS_EXIT, %eax
	movl $0, %ebx
	int $LINUX_SYSCALL
