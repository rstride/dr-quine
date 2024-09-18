section.text:
	global _start
	extern system
	extern sprintf
	extern dprintf

%define		FILENAME		`Sully_%d.s`
%define		COMPILE			`nasm -felf64 -DCHILD Sully_%1$d.s -o Sully_%1$d.o; gcc -Wall -Wextra -Werror -no-pie -nostartfiles Sully_%1$d.o -o Sully_%1$d; rm -rf Sully_%1$d.o`
%define		EXECUTE			`./Sully_%1$d`

_start:
	mov rcx, 5

	cmp rcx, 0
	jle exit
%ifdef CHILD
	dec rcx
%endif
	sub rsp, 256

	mov rdi, rsp
	lea rsi, [rel filename]
	mov rdx, rcx
	mov r13, rcx
	call sprintf

	mov rdi, rsp
	mov rsi, 420
	mov rax, 90
	syscall

	mov rdx, rcx
	push rsi
	pop rdx
	mov rsi, 577
	mov rax, 2
	syscall

	cmp rax, 0
	jl exit

	push r13
	pop rcx

	mov r12, rax
	mov rdi, rax
	lea rsi, [rel code]
	mov rdx, 10
	mov r13, rcx
	mov r8, 37
	mov r9, 96
	lea rax, [rel code]
	push rax
	xor rax, rax
	call dprintf
	pop rax

	push r12
	pop rdi
	mov rax, 3
	syscall

	mov rdi, rsp
	lea rsi, [rel compile]
	mov rdx, r13
	call sprintf

	mov rdi, rsp
	call system

	cmp r13, 0x0
	je .not_execute
	mov rdi, rsp
	lea rsi, [rel execute]
	mov rdx, r13
	call sprintf

	mov rdi, rsp
	call system
	.not_execute:

	add rsp, 256

exit:
	xor rdi, rdi
	mov rax, 60
	syscall

filename db FILENAME, 0x0
compile db COMPILE, 0x0
execute db EXECUTE, 0x0
code db `section.text:%1$c	global _start%1$c	extern system%1$c	extern sprintf%1$c	extern dprintf%1$c%1$c%3$cdefine		FILENAME		%4$cSully_%3$cd.s%4$c%1$c%3$cdefine		COMPILE			%4$cnasm -felf64 -DCHILD Sully_%3$c1$d.s -o Sully_%3$c1$d.o; gcc -Wall -Wextra -Werror -no-pie -nostartfiles Sully_%3$c1$d.o -o Sully_%3$c1$d; rm -rf Sully_%3$c1$d.o%4$c%1$c%3$cdefine		EXECUTE			%4$c./Sully_%3$c1$d%4$c%1$c%1$c_start:%1$c	mov rcx, %2$d%1$c%1$c	cmp rcx, 0%1$c	jle exit%1$c%3$cifdef CHILD%1$c	dec rcx%1$c%3$cendif%1$c	sub rsp, 256%1$c%1$c	mov rdi, rsp%1$c	lea rsi, [rel filename]%1$c	mov rdx, rcx%1$c	mov r13, rcx%1$c	call sprintf%1$c%1$c	mov rdi, rsp%1$c	mov rsi, 420%1$c	mov rax, 90%1$c	syscall%1$c%1$c	mov rdx, rcx%1$c	push rsi%1$c	pop rdx%1$c	mov rsi, 577%1$c	mov rax, 2%1$c	syscall%1$c%1$c	cmp rax, 0%1$c	jl exit%1$c%1$c	push r13%1$c	pop rcx%1$c%1$c	mov r12, rax%1$c	mov rdi, rax%1$c	lea rsi, [rel code]%1$c	mov rdx, 10%1$c	mov r13, rcx%1$c	mov r8, 37%1$c	mov r9, 96%1$c	lea rax, [rel code]%1$c	push rax%1$c	xor rax, rax%1$c	call dprintf%1$c	pop rax%1$c%1$c	push r12%1$c	pop rdi%1$c	mov rax, 3%1$c	syscall%1$c%1$c	mov rdi, rsp%1$c	lea rsi, [rel compile]%1$c	mov rdx, r13%1$c	call sprintf%1$c%1$c	mov rdi, rsp%1$c	call system%1$c%1$c	cmp r13, 0x0%1$c	je .not_execute%1$c	mov rdi, rsp%1$c	lea rsi, [rel execute]%1$c	mov rdx, r13%1$c	call sprintf%1$c%1$c	mov rdi, rsp%1$c	call system%1$c	.not_execute:%1$c%1$c	add rsp, 256%1$c%1$cexit:%1$c	xor rdi, rdi%1$c	mov rax, 60%1$c	syscall%1$c%1$cfilename db FILENAME, 0x0%1$ccompile db COMPILE, 0x0%1$cexecute db EXECUTE, 0x0%1$ccode db %4$c%5$s%4$c, 0x0%1$c`, 0x0