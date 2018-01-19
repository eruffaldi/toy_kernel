CC32=gcc -m32
AS32=as --32
CC64=gcc -m64
AS64=as --64

CC=$(CC32)
AS=$(AS32)

CFLAGS=-fno-stack-protector -ffreestanding -g -Wall
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
	rm -f uvideo.s kmain.s printf.s
	rm -f kernel 
