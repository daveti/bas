# TOUPPER.S

.EQU SYS_OPEN, 5
.EQU SYS_WRITE, 4
.EQU SYS_READ, 3
.EQU SYS_CLOSE, 6
.EQU SYS_EXIT, 1

.EQU O_RDONLY, 0
.EQU O_CREAT_WRONLY_TRUNC, 03101
.EQU PERMISSION, 0666

.EQU STDIN, 0
.EQU STDOUT, 1
.EQU STDERR, 2

.EQU LINUX_SYSCALL, 0X80
.EQU END_OF_FILE, 0
.EQU NUMBER_ARGUMENTS, 2

.BSS

.EQU BUFFER_SIZE, 1024
.LCOMM BUFFER_DATA, BUFFER_SIZE

.TEXT

.EQU ST_SIZE_RESERVE, 8
.EQU ST_FD_IN, -4
.EQU ST_FD_OUT, -8
.EQU ST_ARGC, 0
.EQU ST_ARGV_0, 4
.EQU ST_ARGV_1, 8
.EQU ST_ARGV_2, 12

.GLOBL _START
_START:
	MOVL %ESP, %EBP
	SUBL $ST_SIZE_RESERVE, %ESP

OPEN_FILES:
OPEN_FD_IN:
	MOVL $SYS_OPEN, %EAX
	MOVL ST_ARGV_1(%EBP), %EBX
	MOVL $O_RDONLY, %ECX
	MOVL $PERMISSION, %EDX
	INT $LINUX_SYSCALL

STORE_FD_IN:
	MOVL %EAX, ST_FD_IN(%EBP)

OPEN_FD_OUT:
	MOVL $SYS_OPEN, %EAX
	MOVL ST_ARGV_2(%EBP), %EBX
	MOVL $O_CREAT_WRONLY_TRUNC, %ECX
	MOVL $PERMISSION, %EDX
	INT $LINUX_SYSCALL

STORE_FD_OUT:
	MOVL %EAX, ST_FD_OUT(%EBP)

READ_LOOP_BEGIN:
	MOVL $SYS_READ, %EAX
	MOVL ST_FD_IN(%EBP), %EBX
	MOVL $BUFFER_DATA, %ECX
	MOVL $BUFFER_SIZE, %EDX
	INT $LINUX_SYSCALL

	CMPL $END_OF_FILE, %EAX
	JLE END_LOOP
CONTINUE_READ_LOOP:
	PUSHL $BUFFER_DATA
	PUSHL %EAX
	CALL CONVERT_TO_UPPER
	POPL %EAX
	ADDL $4, %ESP

	MOVL %EAX, %EDX
	MOVL $SYS_WRITE, %EAX
	MOVL ST_FD_OUT(%EBP), %EBX
	MOVL $BUFFER_DATA, %ECX
	INT $LINUX_SYSCALL

	JMP READ_LOOP_BEGIN

END_LOOP:
	MOVL $SYS_CLOSE, %EAX
	MOVL ST_FD_IN(%EBP), %EBX
	INT $LINUX_SYSCALL

	MOVL $SYS_CLOSE, %EAX
	MOVL ST_FD_OUT(%EBP), %EBX
	INT $LINUX_SYSCALL

	MOVL $SYS_EXIT, %EAX
	MOVL $0, %EBX
	INT $LINUX_SYSCALL


.EQU LOWERCASE_A, 'A'
.EQU LOWERCASE_Z, 'Z'
.EQU UPPER_CONVERSION, 'A'-'A'

.EQU ST_BUFFER_LEN, 8
.EQU ST_BUFFER, 12

CONVERT_TO_UPPER:
	PUSHL %EBP
	MOVL %ESP, %EBP

	MOVL ST_BUFFER(%EBP), %EAX
	MOVL ST_BUFFER_LEN(%EBP), %EBX
	MOVL $0, %EDI
	CMPL $0, %EBX
	JE END_CONVERT_LOOP

CONVERT_LOOP:
	MOVB (%EAX,%EDI,1), %CL
	CMPB $LOWERCASE_A, %CL
	JL NEXT_BYTE
	CMPB $LOWERCASE_Z, %CL
	JG NEXT_BYTE

	ADDB $UPPER_CONVERSION, %CL
	MOVB %CL, (%EAX,%EDI,1)

NEXT_BYTE:
	INCL %EDI
	CMP %EDI, %EBX
	JNE CONVERT_LOOP

END_CONVERT_LOOP:
	MOVL %EBP, %ESP
	POPL %EBP
	RET	
