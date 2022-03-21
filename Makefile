# See LICENSE file for copyright and license details.
.PHONY: all options clean
.SUFFIXES: .hex .o

BIN = execve hi abc
SRC = ${BIN:=.s}
OBJ = ${BIN:=.o}
HEX = ${BIN:=.hex}

ASM     = nasm
LNK     = ld
CC      = cc
CFLAGS  = -Wall -fno-stack-protector -z execstack
AFLAGS  = -f elf64 -w+all -D$$(uname)
LFLAGS  = -m elf_x86_64 -s

all: options ${BIN} ${HEX} tiny loader

options:
	@echo ${BIN} build options:
	@echo "AFLAGS  = ${AFLAGS}"
	@echo "LFLAGS  = ${LFLAGS}"
	@echo "ASM     = ${ASM}"
	@echo "LNK     = ${LNK}"

${BIN}: ${OBJ}
	${LNK} ${LFLAGS} -o $@ $@.o

.s.o:
	${ASM} ${AFLAGS} -o $@ $<

.o.hex:
	@echo "objdump -d $< -o $@"
	@objdump -d $< | grep '[0-9a-f]:'|\
		grep -v 'file'| cut -f2 |\
		sed 's/^/\\x/g'|\
		sed "s/ *$$//g" |\
		sed 's/ /\\x/g'|\
		tr -d '\n'|\
		fold -w 32 |\
		sed 's/^/"/'|\
		sed 's/$$/"/'> $@
		@echo ";" >> $@

loader:
	${CC} ${CFLAGS} $@.c -o $@

tiny:
	rm -rf tiny
	nasm -f bin -o tiny tiny.s
	chmod +x tiny
	./tiny ; echo $$?
	nasm -f bin -o tiny64 tiny64.s
	chmod +x tiny64
	./tiny64 ; echo $$?

clean:
	rm -rf *.o *.hex ${BIN} loader
