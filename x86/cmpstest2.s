# cmpstest2.s - An example of using the REPE CMPS instruciton
# NOTE: repe cmpsb seems working backwards and returns the index
# of the first letter mismatching!
.section .data
value1:
	.ascii "This is a test of the CMPS instructions"
value2:
	.ascii "This is a test of the CMPS instructiont"

.section .text
.globl _start
_start:
	movl $1, %eax
	leal value1, %esi
	leal value2, %edi
	movl $39, %ecx
	cld
	repe cmpsb
	je equal
	movl %ecx, %ebx
	int $0x80
equal:
	movl $0, %ebx
	int $0x80
