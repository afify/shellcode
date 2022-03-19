; See LICENSE file for copyright and license details.
BITS 64
%include "syscalls.s"

section .text
	global _start

_start:
	mov rbx, 0x007A79
	push rbx
	mov rbx, 0x7877767574737271
	push rbx
	mov rbx, 0x706F6E6D6C6B6A69
	push rbx
	mov rbx, 0x6867666564636261
	push rbx

	xor rax, rax
	mov al, SYS_write
	xor rdi, rdi
	mov dil, 1	;unsigned int fd
	mov rsi, rsp	;const char *buf
	xor rdx, rdx
	mov dl, 26	;size_t count
	syscall

	xor rax, rax
	mov al, SYS_exit
	xor rdi, rdi
	syscall
