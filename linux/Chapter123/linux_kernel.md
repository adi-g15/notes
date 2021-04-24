## The linux kernel

> Chapter 3

The bootloader loads both
  * the kernel
  * and an inital RAM-based file system (initramfs)

so that it can directly be used by the kernel.

When kernel is loaded in RAM,
  * immediately initializes and configures the computer memory
  * configures all hardware attached to the system (including all `processors`, `I/O subsystems`, `storage devices`, etc.)
  * also loads some _necessary_ user space applications
