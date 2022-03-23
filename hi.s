; See LICENSE file for copyright and license details.
BITS 64
%include "syscalls.inc"
%include "portable.inc"

section .text
	global _start

_start:
	push 0x34333231
	mov dword [rsp+4], 0x38373635

	xor rax, rax
	mov al, SYS_write
	xor rdi, rdi
	mov dil, 1	;unsigned int fd
	mov rsi, rsp	;const char *buf
	xor rdx, rdx
	mov dl, 8	;size_t count
	syscall

	xor rax, rax
	mov al, SYS_exit
	xor rdi, rdi
	syscall
