; See LICENSE file for copyright and license details.
BITS 64
%include "syscalls.s"

section .text
	global _start

_start:
	push 0x34333231
	mov dword [rsp+4], 0x38373635
	mov rax, SYS_write
	mov rdi, 1	;unsigned int fd
	mov rsi, rsp	;const char *buf
	mov rdx, 8	;size_t count
	syscall

	mov rax, SYS_exit
	mov rdi, 0
	syscall
