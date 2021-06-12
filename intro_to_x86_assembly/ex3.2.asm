global _start

section .text
_start:
	mov ebx, 42	; it will store 42 as the ebx, ie. the return code
	mov eax, 1	; sys_exit, the system call to make
