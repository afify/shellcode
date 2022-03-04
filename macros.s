; See LICENSE file for copyright and license details.

%ifndef MACROS_S
%define MACROS_S

%define EXIT_SUCCESS	0
%define EXIT_FAILURE	1
%define STDOUT		1
%define STDERR		2

%macro CHECK_BSD 0
%ifdef OpenBSD
section .note.openbsd.ident note
	dd 8, 4, 1
	db "OpenBSD", 0
	dd 0
%elifdef NetBSD
section .note.openbsd.ident note
	dd 7, 4, 1
	db "NetBSD", 0, 0
	dd 0
%endif
%endmacro

%macro EEXIT 1
	mov rax, SYS_exit
	mov rdi, %1
	syscall
%endmacro

%macro DIE 2
	mov rax, SYS_write
	mov rdi, STDERR
	mov rsi, %1
	mov rdx, %2
	syscall
	EEXIT EXIT_FAILURE
%endmacro

%endif ;MACROS_S
