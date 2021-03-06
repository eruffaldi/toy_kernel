
CC32?=gcc -m32 ${OSXSPECIFIC}
AS32=as --32
CC64?=gcc -m64 ${OSXSPECIFIC}
AS64=as --64

CC=$(CC32)
AS=$(AS32)

CFLAGS=-fno-pic -fno-stack-protector -ffreestanding -g -Wall
LDFLAGS=-nostdlib -T kern.ld 

.SUFFIXES:
kernel: kmain.o head.o trampoline64.o paging.o uvideo.o printf.o
	$(CC) $(LDFLAGS) kmain.o head.o trampoline64.o paging.o uvideo.o printf.o -o kernel

head.o: head.S
	$(CC) -c head.S

%.s: %.c
	$(CC32) $(CFLAGS) -fno-dwarf2-cfi-asm -S $<

%.o: %.s
	$(CC) -c $<

clean:
	rm -f *.o
	rm -f kmain.s uvideo.s printf.s
	rm -f kernel 
