BITS 64
%include "syscalls.inc"
%include "macros.inc"
%include "signals.inc"
%include "portable.inc"

%define SIGUSR1      10       ; User-defined signal r1

section .rodata
	usage_msg:	db "usage: azan [-AaNnUuv]", 10, 0
	usage_len:	equ $ - usage_msg

section .data
	dchar: db 1
	SIGACTION sa

section .bss

section .text
	global _start

_start:

signal:
	mov rax, SYS_sigaction
	mov rdi, SIGUSR1	;int sig
	mov rsi, sa		;const struct sigaction * act
	mov rdx, 0		;struct sigaction * oact
	mov r10, 0		;size_t sigsetsize
	syscall

read:
	mov rax, SYS_read
	mov rdi, STDIN		;unsigned int fd 
	mov rsi, dchar		;char *buf
	mov rdx, 1		;size_t count
	syscall

cmpkey:
	cmp [dchar], byte 0x71	; if q => write
	je exit
	cmp [dchar], byte 0x73	; if s => write
	je writes
	jne read

writes:
	mov rax, SYS_write
	mov rdi, STDOUT		;unsigned int fd 
	mov rsi, usage_msg,		;char *buf
	mov rdx, usage_len		;size_t count
	syscall

exit:
	EEXIT EXIT_SUCCESS
