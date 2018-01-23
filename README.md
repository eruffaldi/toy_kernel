



# Building on OSX: no

If we pass CC32="gcc -m32 --target=x86_64-pc-linux-gnu" make

We obtain:

- linker script missing -T ignored
- linker option -z for 64bit
- linker --eh-frame-hdr

Use real gcc? No because it has been built only for darwin

CC32="/usr/local/bin/gcc-7 -m32 " make 