## Reference for default variables in Redox OS Makefile

> Variables with '?' at end of their names are default values, you can override the value

* ARCH?
  **Value**: x86_64

* TARGET
  **Value**: x86_64-unknown-redox

* FUMOUNT
  **Value**: fusermount -u

* REDOX_MAKE
  **Value**: make

* VB_AUDIO
  **Value**: pulse

* VBM
  **Value**: VBoxManage

* HOST_TARGET?
  **Value**: x86_64-unknown-linux-gnu

* BOOTLOADER_TARGET
  **Value**: x86-unknown-none

> TODO: For some reason, config.mk and many others variables not read

* PREFIX_BINARY?
  **Value**: 1

* FILESYSTEM_SIZE?
  **Value**: 256

* UNAME
  **Value**: $(shell uname)

* ROOT
  **Value**: $(CURDIR)

* KTARGET
  **Value**: $(ARCH)-unknown-kernel

* KBUILD
  **Value**: build/kernel

* BUILD
  **Value**: build/userspace

* INSTALLER
  **Value**: export PATH="$(PREFIX_PATH):$$PATH" && installer/target/release/redox_installer $(INSTALLER_FLAGS)

* INSTALLER_FLAGS?
  **Value**: --cookbook=cookbook

* BOOTLOADER_TARGET
  **Value**: x86-unknown-none

* EFI_TARGET
  **Value**: $(ARCH)-unknown-uefi

* PARTED
  **Value**: /sbin/parted

* AR
  **Value**: $(TARGET)-gcc-ar

* AS
  **Value**: $(TARGET)-as

* CC
  **Value**: $(TARGET)-gcc

* CXX
  **Value**: $(TARGET)-g++

* LD
  **Value**: $(TARGET)-ld

* NM
  **Value**: $(TARGET)-gcc-nm

* OBJCOPY
  **Value**: $(TARGET)-objcopy

* OBJDUMP
  **Value**: $(TARGET)-objdump

* RANLIB
  **Value**: $(TARGET)-gcc-ranlib

* READELF
  **Value**: $(TARGET)-readelf

* STRIP
  **Value**: $(TARGET)-strip

* CARGO_CONFIG_VERSION
  **Value**: 0.1.1

* PREFIX
  **Value**: prefix/$(TARGET)

* PREFIX_INSTALL
  **Value**: $(PREFIX)/relibc-install

* PREFIX_PATH
  **Value**: $(ROOT)/$(PREFIX_INSTALL)/bin

* PREFIX_STRIP
  **Value**: mkdir -p bin libexec "$(TARGET)/bin" && find bin libexec "$(TARGET)/bin" "$(TARGET)/lib" -type f -exec strip --strip-unneeded {} ';' 2> /dev/null

* PREFIX_BASE_INSTALL
  **Value**: $(PREFIX)/rust-freestanding-install

* PREFIX_FREESTANDING_INSTALL
  **Value**: $(PREFIX)/gcc-freestanding-install

* PREFIX_BASE_PATH
  **Value**: $(ROOT)/$(PREFIX_BASE_INSTALL)/bin

* PREFIX_FREESTANDING_PATH
  **Value**: $(ROOT)/$(PREFIX_FREESTANDING_INSTALL)/bin

* INITFS_RM_BINS
  **Value**: alxd e1000d ihdad ixgbed pcspkrd redoxfs-ar redoxfs-mkfs rtl8168d usbctl

* QEMU
  **Value**: SDL_VIDEO_X11_DGAMOUSE=0 qemu-system-$(ARCH)

* QEMUFLAGS
  **Value**: -d cpu_reset

* QEMUFLAGS+
  **Value**: -smp 4 -m 2048

* QEMU_EFI
  **Value**: /usr/share/OVMF/OVMF_CODE.fd

