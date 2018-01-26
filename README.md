
# OSX building

In theory clang is a cross-compiler in particular we can specify:

* CC32="gcc -m32 --target=x86_64-pc-linux-elf" make 
* CC64="gcc -m64 --target=i686-pc-linux-elf" make -f Makefile.64

But there are some issues with the linking process:

1) unsupported link scripts -T . Actually clang lld supports scripts but not clang from Apple. The script of this example uses the script for specifying section ordering and entry point. 
2) unsupported option -z max-page-size=...  that "Set the emulation maximum page size to value"
3) unsupported option --eh-frame-hdr that "Request creation of ".eh_frame_hdr" section and ELF "PT_GNU_EH_FRAME" segment header."

Workaround for clang ld:
* -image_base 0x100000
* -init _start
* -section_order specifies section ordering

A solution is to use GCC in cross-compilation mode using docker. E.g. dockercross https://github.com/dockcross/dockcross 
