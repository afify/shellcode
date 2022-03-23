BITS 64
%include "syscalls.inc"
%include "macros.inc"
%include "signals.inc"
%include "portable.inc"

section .rodata
	usage_msg:	db "usage: azan [-AaNnUuv]", 10, 0
	usage_len:	equ $ - usage_msg

section .data
	dchar: db 1
	SIGACTION sigaction

section .bss

section .text
	global _start

_start:

signal:
	mov rax,sigFPEHandler                       ;set handler to pointer to procSigInt
	mov qword[sigaction.sa_handler],rax         ;in sigaction structure
	mov rax,SA_RESTORER | SA_SIGINFO            ;sa_flags
	mov qword [sigaction.sa_flags],rax
	mov rax,exit
	mov qword[sigaction.sa_restorer],rax

	mov rax, SYS_sigaction
	mov rdi, SIGUSR1	;int sig
	mov rsi, sigaction		;const struct sigaction * act
	mov rdx, 0		;struct sigaction * oact
	mov r10, NSIG_WORDS	;size_t sigsetsize
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

sigFPEHandler:
    ; rdi=signum, rsi=siginfo_t pointer, rdx=sigcontext*
    mov     rax,[rdx+UCONTEXT_STRUC.uc_mcontext+SIGCONTEXT_STRUC.rip]       ; get rip where error occured
	mov rax, SYS_write
	mov rdi, STDOUT		;unsigned int fd 
	mov rsi, usage_msg,		;char *buf
	mov rdx, usage_len		;size_t count
	syscall
    ;syscall write,stderr,msgDivisionByZero,msgDivisionByZero.len
    ret
