# See LICENSE file for copyright and license details.

SRC = execve.s hi.s
BIN = ${SRC:%.s=%}
OBJ = ${SRC:%.s=%.o}

ASM     = nasm
LNK     = ld
AFLAGS  = -f elf64 -w+all -D$$(uname)
LFLAGS  = -m elf_x86_64 -s

all: options ${BIN}

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

clean:
	rm -rf *.o ${BIN}

raw:
	printf '\\x'
	printf '\\x' && objdump -d ./execve | grep "^ " | cut -f2 | tr -d ' ' | tr -d '\n' | sed 's/.\{2\}/&\\x /g'| head -c-3 | tr -d ' ' && echo ' '

x:
	 objdump -d ./execve|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

.PHONY: all options clean
