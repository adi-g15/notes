# Embedded Boot Sequence

Ref: https://george-calin.medium.com/boot-sequence-on-embedded-devices-96b3451bb7c9

1. ROM Boot Loader (RBL) - Proprietary & Read-only
2. Secondary Program Loader (Memory LOader, MOL)
3. U-boot/Barebox (Tertiary Program Loader, TPL)

RBL is in a small memory that runs on the SoC, when power the board. Stored in
ROM section of SoC. Loads & execute SPL/MOL.

SPL -> Load & execute 3rd stage bootloader (u-boot)

4. Kernel

# Boot Process (another)

Ref: https://www.youtube.com/watch?v=u-2gudXTTTQ

ROM contains code that is executed just after reset/poweron.
ROM loads code from specific locations into SRAM as DRAM can't be used yet
(requires memory controller to be initialised)
After this, SPL is loaded in SRAM, and ROM points to start of the SPL code

Since SRAM is too small, we use an intermediate loader, the SPL

SPL configures memory controller, so TPL can be loaded. If it supports
filesystem drivers, it can also read files, ex u-boot.img
After this, TPL loaded in DRAM, and SPL can jump to it

## UEFI

Similar steps
1. UEFI initialises hardware (like BIOS)
2. UEFI firmware works as SPL, initialises memory controller, so EFI boot
   manager can be loaded from ESP (EFI System Partition) or via PXE boot.
3. TPL loads the kernel, and optionally a RAM disk into memory

UEFI compatible bootloaders: systemd-boot, Barebox

## Loading kernel

Bootloader passes some info to kernel:
1. Hardware, eg CPU clock speed, RAM size etc.
2. Machine number (for those not supporting [device trees](https://wiki.osdev.org/Devicetree))
3. Kernel commandline parameters
4. (optional) Size & location of device tree
5. (optional) Size & location of initramfs

Read More: [ATAGS]()
           [Device Trees]()
