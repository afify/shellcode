; See LICENSE file for copyright and license details.

%ifndef SIGNALS_S
%define SIGNALS_S

%define NSIG            64
%define NSIG_BPW        8
%define NSIG_WORDS      NSIG / NSIG_BPW

STRUC SIGACTION_STRUC
	.sa_handler:      resq      1
	.sa_flags:        resq      1
	.sa_restorer:     resq      1
	.sa_mask:         resb      128
ENDSTRUC

%macro SIGACTION 1
	%1: ISTRUC SIGACTION_STRUC
		at  SIGACTION_STRUC.sa_handler,      dq 0
		at  SIGACTION_STRUC.sa_flags,        dq 0
		at  SIGACTION_STRUC.sa_restorer,     dq 0
		at  SIGACTION_STRUC.sa_mask,         times 128 db 0
	IEND
	%define %1.sa_handler     %1+SIGACTION_STRUC.sa_handler
	%define %1.sa_flags       %1+SIGACTION_STRUC.sa_flags
	%define %1.sa_restorer    %1+SIGACTION_STRUC.sa_restorer
	%define %1.sa_mask        %1+SIGACTION_STRUC.sa_mask
%endmacro

%endif ;SIGNALS_S
