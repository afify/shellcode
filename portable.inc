; See LICENSE file for copyright and license details.

%ifndef PORTABLE_INC
%define PORTABLE_INC

%ifdef OpenBSD
section .note.openbsd.ident note
	align   2
	dd 8, 4, 1
	db "OpenBSD", 0
	dd 0
	align   2
%elifdef NetBSD
section .note.openbsd.ident note
	dd 7, 4, 1
	db "NetBSD", 0, 0
	dd 0
%endif

%endif ;PORTABLE_INC
