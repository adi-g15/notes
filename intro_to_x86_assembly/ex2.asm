global _start

section .data	; this time, let's separate into sections
	; we store a byte stream/ byte array/ string; though, note some things
	; 1. The same thing can be mentioned as `msg db 'N','a',...,'d','!',0x0a`
	; 2. Generally, or when we need to deal with C library functions, we need it to be NULL terminated... ie. have a 0 at end, that could have been done using `msg db "Namaste !",10,0`	; see the 0 at end (also 10 is same as 0x0a or 0xa)
	msg db "Namaste, world!", 0x0a	; 0x0a is same as 0xa
	len equ $ - msg	; Subtract current location with start of 'msg', we can get length of string (Smart boii)

	; '$' evaluates to the assembly position at the beginning of the line containing the expression (ie. current address)

section .text:
_start:
	mov eax, 4	; sys_write system call
	mov ebx, 1	; stdout file descriptor (used by the system call we made, ie. sys_write)
	mov ecx, msg	; bytes to write
	mov edx, len	; number of bytes to write

	int 0x80	; system call interrupt

	mov eax, 1	; sys_exit system call (ie. exit)
	mov ebx, 0	; used the the sys_exit system call (so, it's the return code)

	int 0x80	; system call interrupt

