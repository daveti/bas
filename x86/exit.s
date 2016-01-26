# Play with exit syscall

.section data

.section text
.globl _start

_start:
movl $1, %eax
movl $77, %ebx
int $0x80
