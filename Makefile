# See LICENSE file for copyright and license details.

SRC = execve.s hi.s
BIN = ${SRC:%.s=%}
OBJ = ${SRC:%.s=%.o}
HEX = ${SRC:%.s=%.hex}

ASM     = nasm
LNK     = ld
AFLAGS  = -f elf64 -w+all -D$$(uname)
LFLAGS  = -m elf_x86_64 -s

all: options ${BIN} ${HEX}

options:
	@echo ${BIN} build options:
	@echo "AFLAGS  = ${AFLAGS}"
	@echo "LFLAGS  = ${LFLAGS}"
	@echo "ASM     = ${ASM}"
	@echo "LNK     = ${LNK}"

${OBJ}: %.o: %.s
	${ASM} ${AFLAGS} -o $@ $<

${BIN}: %: %.o
	${LNK} ${LFLAGS} -o $@ $<

${HEX}: %.hex: %
	objdump -d $< | grep '[0-9a-f]:'|\
		grep -v 'file'| cut -f2 |\
		sed 's/^/\\x/g'|\
		sed "s/ *$$//g" |\
		sed 's/ /\\x/g'|\
		tr -d '\n' > $@

clean:
	rm -rf *.o *.hex ${BIN}

.PHONY: all options clean
