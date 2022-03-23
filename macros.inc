; See LICENSE file for copyright and license details.

%ifndef MACROS_INC
%define MACROS_INC

%define EXIT_SUCCESS	0
%define EXIT_FAILURE	1
%define STDIN		0
%define STDOUT		1
%define STDERR		2

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

%endif ;MACROS_INC
