# The /boot directory

The /boot directory contains few essential files needed to boot the system.
For every alternative kernel installed on the system, there are four files:

> As per linux foundation, each of these has a kernel version appended to its name (though on my system, only "-linux" is appended, for eg. vmlinuz-linux, initramfs-linux.img

1. vmlinuz -> The compressed linux kernel, required for booting
2. initramfs (or initrd) -> The initial ram filesystem, required for booting

3. config -> Kernel configuration file, only used for debugging and bookkeeping
4. System.map -> **Kernel symbol table**, only used for debugging

GRUB (**Gr**and **U**nified **B**ootloader) files such as `/boot/grub/grub.conf` are also found

