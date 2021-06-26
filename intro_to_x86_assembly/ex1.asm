global _start
_start:
	mov eax, 1	; is used by system call, to know 'which' system call to make, here 1 means 'exit' system call
	mov ebx, 42	; will be treated as return code by the exit system call

	int 0x80	; call the interrupt handler for 0x80 interrupt, which is the system call interrupt

