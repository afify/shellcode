; See LICENSE file for copyright and license details.

%ifndef SYSCALLS_INC
%define SYSCALLS_INC

%ifdef Linux
	%define SYS_read 0
	%define SYS_write 1
	%define SYS_execve 59
	%define SYS_sigaction 13
	%define SYS_exit 60
%elifdef OpenBSD
	%define SYS_read 3
	%define SYS_write 4
	%define SYS_execve 59
	%define SYS_sigaction 49
	%define SYS_exit 1
	%define SYS_pledge 108
%else
	%fatal "OS not supported"
%endif

%endif ;SYSCALLS_INC
