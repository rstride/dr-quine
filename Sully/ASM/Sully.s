section.text:
	global _start
	extern system
	extern sprintf
	extern dprintf

%define		FILENAME		`Sully_%d.s`
%define		COMPILE			`nasm -felf64 -DCHILD Sully_%1$d.s -o Sully_%1$d.o; gcc -Wall -Wextra -Werror -no-pie -nostartfiles Sully_%1$d.o -o Sully_%1$d; rm -rf Sully_%1$d.o`
%define		EXECUTE			`./Sully_%1$d`

_start:
	mov rcx, 5                ; Initialize counter to 5

	cmp rcx, 0                ; Compare counter with 0
	jle exit                 ; If counter <= 0, exit
%ifdef CHILD
	dec rcx                  ; If CHILD is defined, decrement counter
%endif
	sub rsp, 256             ; Allocate 256 bytes on stack

	mov rdi, rsp             ; Set rdi to point to stack
	lea rsi, [rel filename]  ; Load address of filename format string
	mov rdx, rcx             ; Set rdx to counter value
	mov r13, rcx             ; Save counter value in r13
	call sprintf             ; Call sprintf to format filename

	mov rdi, rsp             ; Set rdi to formatted filename
	mov rsi, 420             ; Set rsi to file mode (octal 0644)
	mov rax, 90              ; Set syscall number to sys_open (90)
	syscall                  ; Open file

	mov rdx, rcx             ; Set rdx to counter value
	push rsi                 ; Push file mode to stack
	pop rdx                  ; Pop file mode to rdx
	mov rsi, 577             ; Set rsi to file flags (O_CREAT | O_WRONLY | O_TRUNC)
	mov rax, 2               ; Set syscall number to sys_open (2)
	syscall                  ; Open file

	cmp rax, 0               ; Compare file descriptor with 0
	jl exit                  ; If file descriptor < 0, exit

	push r13                 ; Push counter value to stack
	pop rcx                  ; Pop counter value to rcx

	mov r12, rax             ; Save file descriptor in r12
	mov rdi, rax             ; Set rdi to file descriptor
	lea rsi, [rel code]      ; Load address of code string
	mov rdx, 10              ; Set rdx to length of code string
	mov r13, rcx             ; Save counter value in r13
	mov r8, 37               ; Set r8 to 37 (format specifier)
	mov r9, 96               ; Set r9 to 96 (format specifier)
	lea rax, [rel code]      ; Load address of code string
	push rax                 ; Push address of code string to stack
	xor rax, rax             ; Clear rax
	call dprintf             ; Call dprintf to write code to file
	pop rax                  ; Pop address of code string from stack

	push r12                 ; Push file descriptor to stack
	pop rdi                  ; Pop file descriptor to rdi
	mov rax, 3               ; Set syscall number to sys_close (3)
	syscall                  ; Close file

	mov rdi, rsp             ; Set rdi to point to stack
	lea rsi, [rel compile]   ; Load address of compile command format string
	mov rdx, r13             ; Set rdx to counter value
	call sprintf             ; Call sprintf to format compile command

	mov rdi, rsp             ; Set rdi to formatted compile command
	call system              ; Call system to execute compile command

	cmp r13, 0x0             ; Compare counter value with 0
	je .not_execute          ; If counter == 0, jump to .not_execute
	mov rdi, rsp             ; Set rdi to point to stack
	lea rsi, [rel execute]   ; Load address of execute command format string
	mov rdx, r13             ; Set rdx to counter value
	call sprintf             ; Call sprintf to format execute command

	mov rdi, rsp             ; Set rdi to formatted execute command
	call system              ; Call system to execute command
	.not_execute:

	add rsp, 256             ; Deallocate 256 bytes from stack

exit:
	xor rdi, rdi             ; Clear rdi (exit status 0)
	mov rax, 60              ; Set syscall number to sys_exit (60)
	syscall                  ; Exit

filename db FILENAME, 0x0   ; Define filename format string
compile db COMPILE, 0x0     ; Define compile command format string
execute db EXECUTE, 0x0     ; Define execute command format string
code db `section.text:%1$c	global _start%1$c	extern system%1$c	extern sprintf%1$c	extern dprintf%1$c%1$c%3$cdefine		FILENAME		%4$cSully_%3$cd.s%4$c%1$c%3$cdefine		COMPILE			%4$cnasm -felf64 -DCHILD Sully_%3$c1$d.s -o Sully_%3$c1$d.o; gcc -Wall -Wextra -Werror -no-pie -nostartfiles Sully_%3$c1$d.o -o Sully_%3$c1$d; rm -rf Sully_%3$c1$d.o%4$c%1$c%3$cdefine		EXECUTE			%4$c./Sully_%3$c1$d%4$c%1$c%1$c_start:%1$c	mov rcx, %2$d%1$c%1$c	cmp rcx, 0%1$c	jle exit%1$c%3$cifdef CHILD%1$c	dec rcx%1$c%3$cendif%1$c	sub rsp, 256%1$c%1$c	mov rdi, rsp%1$c	lea rsi, [rel filename]%1$c	mov rdx, rcx%1$c	mov r13, rcx%1$c	call sprintf%1$c%1$c	mov rdi, rsp%1$c	mov rsi, 420%1$c	mov rax, 90%1$c	syscall%1$c%1$c	mov rdx, rcx%1$c	push rsi%1$c	pop rdx%1$c	mov rsi, 577%1$c	mov rax, 2%1$c	syscall%1$c%1$c	cmp rax, 0%1$c	jl exit%1$c%1$c	push r13%1$c	pop rcx%1$c%1$c	mov r12, rax%1$c	mov rdi, rax%1$c	lea rsi, [rel code]%1$c	mov rdx, 10%1$c	mov r13, rcx%1$c	mov r8, 37%1$c	mov r9, 96%1$c	lea rax, [rel code]%1$c	push rax%1$c	xor rax, rax%1$c	call dprintf%1$c	pop rax%1$c%1$c	push r12%1$c	pop rdi%1$c	mov rax, 3%1$c	syscall%1$c%1$c	mov rdi, rsp%1$c	lea rsi, [rel compile]%1$c	mov rdx, r13%1$c	call sprintf%1$c%1$c	mov rdi, rsp%1$c	call system%1$c%1$c	cmp r13, 0x0%1$c	je .not_execute%1$c	mov rdi, rsp%1$c	lea rsi, [rel execute]%1$c	mov rdx, r13%1$c	call sprintf%1$c%1$c	mov rdi, rsp%1$c	call system%1$c	.not_execute:%1$c%1$c	add rsp, 256%1$c%1$cexit:%1$c	xor rdi, rdi%1$c	mov rax, 60%1$c	syscall%1$c%1$cfilename db FILENAME, 0x0%1$ccompile db COMPILE, 0x0%1$cexecute db EXECUTE, 0x0%1$ccode db %4$c%5$s%4$c, 0x0%1$c`, 0x0