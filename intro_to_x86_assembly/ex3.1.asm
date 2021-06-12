global _start

section .text
_start:
	mov ebx, 42	; exit code 42 (used by the sys_exit system call)
	mov eax, 1	; sys_exit system call (used by interrupt command)

	jmp skip	; jumps to 'skip' label

	mov ebx, 13	; modify, ebx to 13, ie. exit code changed

skip:
	int 0x80	; call the interrupt handler for system call

