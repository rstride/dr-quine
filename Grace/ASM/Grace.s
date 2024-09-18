section.text:
	global _start
	extern dprintf

%define		FILENAME		`Grace_kid.s`
%define FT	_start:
%macro		xxx 0
	lea rdi, [rel filename]   ; Load filename into rdi
	mov rsi, 420              ; Set file mode to 420 (octal: 0644)
	mov rax, 90               ; Syscall: create/open a file
	syscall                   ; Make the syscall

	push rsi                  ; Save rsi temporarily
	pop rdx                   ; Set rdx with rsi (420)
	mov rsi, 577              ; Set rsi (offset or flag)
	mov rax, 2                ; Syscall: open a file
	syscall                   ; Make the syscall

	push rax                  ; Save the file descriptor
	pop rdi                   ; Move file descriptor into rdi
	lea rsi, [rel code]       ; Load address of code
	mov rdx, 10               ; Set rdx (length of string)
	mov rcx, 37               ; Move a constant into rcx
	mov r8, 96                ; Move a constant into r8
	mov r9, rsi               ; Move address of code into r9
	call dprintf              ; Call dprintf to print the code

	mov rax, 3                ; Syscall: close file
	syscall                   ; Make the syscall

	xor rdi, rdi              ; Exit with status 0
	mov rax, 60               ; Syscall: exit
	syscall                   ; Make the syscall

code db `section.text:%1$c	global _start%1$c	extern dprintf%1$c%1$c%2$cdefine		FILENAME		%3$cGrace_kid.s%3$c%1$c%2$cdefine FT	_start:%1$c%2$cmacro		xxx 0%1$c	lea rdi, [rel filename]%1$c	mov rsi, 420%1$c	mov rax, 90%1$c	syscall%1$c%1$c	push rsi%1$c	pop rdx%1$c	mov rsi, 577%1$c	mov rax, 2%1$c	syscall%1$c%1$c	push rax%1$c	pop rdi%1$c	lea rsi, [rel code]%1$c	mov rdx, 10%1$c	mov rcx, 37%1$c	mov r8, 96%1$c	mov r9, rsi%1$c	call dprintf%1$c%1$c	mov rax, 3%1$c	syscall%1$c%1$c	xor rdi, rdi%1$c	mov rax, 60%1$c	syscall%1$c%1$ccode db %3$c%4$s%3$c, 0x0%1$cfilename db FILENAME, 0x0%2$cendmacro%1$c%1$c;%1$c; This is a _start. No shit ?%1$c;%1$cFT%1$c	xxx%1$c`, 0x0
filename db FILENAME, 0x0
%endmacro

;
; This is a _start. No shit?
;
FT
	xxx
