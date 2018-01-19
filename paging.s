.text
.code32
.globl setup_page_tables
.globl init_paging

setup_page_tables:
	mov $PDP, %eax
	or  $0x03, %eax
	mov %eax, (PML4)

	mov $PDT, %eax
	or  $0x03, %eax
	mov %eax, (PDP)

	mov $0, %ecx

fill_PDT:
	mov $0x200000, %eax
	mul %ecx
	or $0x83, %eax
	mov %eax, PDT(,%ecx,8)

	inc %ecx
	cmp $512, %ecx
	jne fill_PDT 

	ret

init_paging:
/*
Disable paging -> already disabled by multiboot loader
Set the PAE enable bit in CR4
First do this! -> Load CR3 with the physical address of the PML4
Enable long mode by setting the EFER.LME flag in MSR 0xC0000080
Enable paging through cr0
*/
  mov %cr4, %eax
  or  $1 << 5, %eax
  mov %eax, %cr4

  mov $PML4, %eax
  mov %eax, %cr3

  mov $0xC0000080, %ecx
  rdmsr
  or  $1 << 8, %eax
  wrmsr

  mov %cr0, %eax
  or  $1 << 31, %eax
  mov %eax, %cr0

  ret

.bss
.align 4096		/* Page tables must be aligned to 4KB */
/* Page-Map Level-4 Table (PML4) */
PML4:
	.skip 4096

/* Page-Directory Pointer Table (PDP) */
PDP:
	.skip 4096

/* the Page-Directory Table (PD) */
PDT:
	.skip 4096
