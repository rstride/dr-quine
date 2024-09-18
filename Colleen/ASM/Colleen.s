section.text:
	global main
	extern printf

main:
	push rbp          ; Save the base pointer
	; Does an empty label with a ret count as a function?
	call f            ; Call the empty function 'f'
	lea rdi, [rel code] ; Load address of 'code' into rdi (for printf's first argument)
	push 10           ; Push 10 (newline) to the stack
	pop rsi           ; Pop into rsi (printf's second argument)
	push 96           ; Push 96 (length of the format string) to the stack
	pop rdx           ; Pop into rdx (printf's third argument)
	lea rcx, [rel code] ; Load the address of 'code' into rcx
	call printf       ; Call printf to print the 'code' string
	xor rax, rax      ; Set rax to 0 (indicates successful execution)
	pop rbp           ; Restore the base pointer
	ret               ; Return from the main function

; This is an empty function f. Cool.
f:
	ret               ; Return from the function 'f'

code db `section.text:%1$c	global main%1$c	extern printf%1$c%1$cmain:%1$c	push rbp%1$c	; Does an empty label with a ret count as a function ?%1$c	call f%1$c	lea rdi, [rel code]%1$c	push 10%1$c	pop rsi%1$c	push 96%1$c	pop rdx%1$c	lea rcx, [rel code]%1$c	call printf%1$c	xor rax, rax%1$c	pop rbp%1$c	ret%1$c%1$c; This is a empty function f. Cool.%1$cf:%1$c	ret%1$c%1$ccode db %2$c%3$s%2$c, 0x0%1$c`, 0x0 ; The code string to print with printf, ends with a null terminator
