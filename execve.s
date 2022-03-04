; See LICENSE file for copyright and license details.
BITS 64
%include "syscalls.s"

section .text
	global _start

_start:
	mov rbx, 0x0068732F6E69622F
	push rbx
	mov rax, SYS_execve
	mov rdi, rsp	;const char *filename
	xor rsi, rsi	;const char *const argv[]
	xor rdx, rdx	;const char *const envp[]
	syscall

	mov rax, SYS_exit
	mov rdi, 0
	syscall
