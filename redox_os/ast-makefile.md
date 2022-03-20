#### Unhandled:
❗ Unhandled: -include .config
❗ Unhandled: ifneq ($(audio),no)
❗ Unhandled: ifneq ($(usb),no)

## Context: 
        AR       : $(TARGET)-gcc-ar
        ARCH    ?: x86_64
        AR_$(subst -,_,$(TARGET))        : $(TARGET)-ar
        AS       : $(TARGET)-as
        BUILD    : build/userspace
        CARGO_CONFIG_VERSION     : 0.1.1
        CC       : $(TARGET)-gcc
        CC_$(subst -,_,$(TARGET))        : $(TARGET)-gcc
        CXX      : $(TARGET)-g++
        CXX_$(subst -,_,$(TARGET))       : $(TARGET)-g++
        EFI_TARGET       : $(ARCH)-unknown-uefi
        FILESYSTEM_SIZE ?: 256
        INITFS_RM_BINS   : alxd e1000d ihdad ixgbed pcspkrd redoxfs-ar redoxfs-mkfs rtl8168d usbctl
        INSTALLER        : export PATH="$(PREFIX_PATH):$$PATH" && installer/target/release/redox_installer $(INSTALLER_FLAGS)
        INSTALLER_FLAGS ?: --cookbook=cookbook
        KBUILD   : build/kernel
        KTARGET  : $(ARCH)-unknown-kernel
        LD       : $(TARGET)-ld
        NM       : $(TARGET)-gcc-nm
        NPROC    : nproc
        OBJCOPY  : $(TARGET)-objcopy
        OBJDUMP  : $(TARGET)-objdump
        PARTED   : /sbin/parted
        PATH     : "$(PREFIX_PATH):$$PATH" && $(OBJDUMP) -C -M intel -D $< > $@
        PREFIX   : prefix/$(TARGET)
        PREFIX_BINARY   ?: 1
        PREFIX_INSTALL   : $(PREFIX)/relibc-install
        PREFIX_PATH      : $(ROOT)/$(PREFIX_INSTALL)/bin
        PREFIX_RUSTFLAGS         : -L $(ROOT)/$(PREFIX_INSTALL)/$(TARGET)/lib
        PREFIX_STRIP     : mkdir -p bin libexec "$(TARGET)/bin" && find bin libexec "$(TARGET)/bin" "$(TARGET)/lib" -type f -exec strip --strip-unneeded {} ';' 2> /dev/null
        QEMU     : SDL_VIDEO_X11_DGAMOUSE=0 qemu-system-$(ARCH)
        QEMUFLAGS        : -d cpu_reset -smp 4 -m 2048 -device ich9-intel-hda -device hda-duplex -device nec-usb-xhci,id=xhci
        QEMU_EFI         : /usr/share/OVMF/OVMF_CODE.fd
        RANLIB   : $(TARGET)-gcc-ranlib
        READELF  : $(TARGET)-readelf
        REDOXER_TOOLCHAIN        : $(RUSTUP_TOOLCHAIN)
        REDOX_MAKE       : make
        ROOT     : $(CURDIR)
        RUSTUP_TOOLCHAIN         : $(ROOT)/$(PREFIX_INSTALL)
        RUST_COMPILER_RT_ROOT    : $(ROOT)/rust/src/llvm-project/compiler-rt
        RUST_TARGET_PATH         : $(ROOT)/kernel/targets
        STRIP    : $(TARGET)-strip
        TARGET   : $(ARCH)-unknown-redox
        UNAME   ::  $(shell uname)
        XARGO_RUST_SRC   : $(ROOT)/rust/src


## Nodes:
        Comment { comment: "# Configuration and variables" }
        IncludeASTNode { include_path: "mk/config.mk" }
        Comment { comment: "# Configuration" }
        Comment { comment: "## Architecture to build Redox for (aarch64 or x86_64)" }
        Comment { comment: "## Flags to pass to the installer (empty to download binary packages)" }
        Comment { comment: "## Enabled to use binary prefix (much faster)" }
        Comment { comment: "## Filesystem size in MB (256 is the default)" }
        Comment { comment: "# Per host variables" }
        If: ($(UNAME),Darwin)
            Steps:
                0: FUMOUNT=sudo umount
                1: ExportASTNode { name: "NPROC", value: "sysctl -n hw.ncpu" }
                2: ExportASTNode { name: "REDOX_MAKE", value: "make" }
                3: PREFIX_BINARY=0
                4: VB_AUDIO=coreaudio
                5: VBM=/Applications/VirtualBox.app/Contents/MacOS/VBoxManage
                6: HOST_TARGET ?= $(ARCH)-apple-darwin
        Else If: ($(UNAME),FreeBSD)
            Steps:
                0: FUMOUNT=sudo umount
                1: ExportASTNode { name: "NPROC", value: "sysctl -n hw.ncpu" }
                2: ExportASTNode { name: "REDOX_MAKE", value: "gmake" }
                3: PREFIX_BINARY=0
                4: VB_AUDIO=pulse # To check, will probaly be OSS on most setups
                5: VBM=VBoxManage
                6: HOST_TARGET ?= $(ARCH)-unknown-freebsd
        Else:
            Steps:
                0: FUMOUNT=fusermount -u
                1: ExportASTNode { name: "NPROC", value: "nproc" }
                2: ExportASTNode { name: "REDOX_MAKE", value: "make" }
                3: VB_AUDIO=pulse
                4: VBM=VBoxManage
                5: HOST_TARGET ?= $(ARCH)-unknown-linux-gnu

        Comment { comment: "# Automatic variables" }
        ExportASTNode { name: "RUST_COMPILER_RT_ROOT", value: "$(ROOT)/rust/src/llvm-project/compiler-rt" }
        ExportASTNode { name: "RUST_TARGET_PATH", value: "$(ROOT)/kernel/targets" }
        ExportASTNode { name: "XARGO_RUST_SRC", value: "$(ROOT)/rust/src" }
        Comment { comment: "## Kernel variables" }
        Comment { comment: "## Userspace variables" }
        ExportASTNode { name: "TARGET", value: "$(ARCH)-unknown-redox" }
        Comment { comment: "## Bootloader variables" }
        If: ($(ARCH),x86_64)
            Steps:
                0: BOOTLOADER_TARGET=x86-unknown-none
        Else:
            Steps:
                0: BOOTLOADER_TARGET=$(ARCH)-unknown-none

        Comment { comment: "## Cross compiler variables" }
        Comment { comment: "## Rust cross compile variables" }
        ExportASTNode { name: "AR_$(subst -,_,$(TARGET))", value: "$(TARGET)-ar" }
        ExportASTNode { name: "CC_$(subst -,_,$(TARGET))", value: "$(TARGET)-gcc" }
        ExportASTNode { name: "CXX_$(subst -,_,$(TARGET))", value: "$(TARGET)-g++" }
        Comment { comment: "# Dependencies" }
        IncludeASTNode { include_path: "mk/depends.mk" }
        Comment { comment: "# Dependencies" }
        If: ($(shell which rustup),)
            Steps:
                0: Target: $(error rustup not found, install from "https
            Deps: ["//rustup.rs/\")"]
            Defined in: "mk/depends.mk"
            Steps:


        If: ($(shell which nasm),)
               Steps:
                0: $(error nasm not found, install from your package manager)

        If: ($(shell env -u RUSTUP_TOOLCHAIN cargo install --list | grep '^cargo-config v$(CARGO_CONFIG_VERSION):$$'),)
            Steps:
                0: $(error cargo-config $(CARGO_CONFIG_VERSION) not found, run "cargo install --force --version $(CARGO_CONFIG_VERSION) cargo-config")

        Target: all
            Deps: ["build/harddrive.bin"]
            Defined in: "Makefile"
            Steps:

        Target: coreboot
            Deps: ["build/coreboot.elf"]
            Defined in: "Makefile"
            Steps:

        Target: live
            Deps: ["build/livedisk.bin"]
            Defined in: "Makefile"
            Steps:

        Target: iso
            Deps: ["build/livedisk.iso"]
            Defined in: "Makefile"
            Steps:

        Target: clean
            Deps: []
            Defined in: "Makefile"
            Steps:
                0: cd cookbook  && \
                 ./clean.sh

                1: Cargo: CLEAN cookbook/cookbook/pkgutils
                Original: "cargo clean --manifest-path cookbook/pkgutils/Cargo.toml"

                2: Cargo: CLEAN cookbook/installer
                Original: "cargo clean --manifest-path installer/Cargo.toml"

                3: Cargo: CLEAN cookbook/kernel
                Original: "cargo clean --manifest-path kernel/Cargo.toml"

                4: Cargo: CLEAN cookbook/kernel/syscall
                Original: "cargo clean --manifest-path kernel/syscall/Cargo.toml"

                5: Cargo: CLEAN cookbook/redoxfs
                Original: "cargo clean --manifest-path redoxfs/Cargo.toml"

                6: -$(FUMOUNT) build/filesystem/ || true
                7: rm -rf build

        Target: distclean
            Deps: []
            Defined in: "Makefile"
            Steps:
                0: $(MAKE) clean
                1: cd cookbook  && \
                 ./unfetch.sh


        Target: pull
            Deps: []
            Defined in: "Makefile"
            Steps:
                0: git pull --recurse-submodules
                1: git submodule sync --recursive
                2: git submodule update --recursive --init

        Target: update
            Deps: []
            Defined in: "Makefile"
            Steps:
                0: cd cookbook  && \
                 ./update.sh "$$(cargo run --manifest-path ../installer/Cargo.toml -- --list-packages -c ../initfs.toml)" "$$(cargo run --manifest-path ../installer/Cargo.toml -- --list-packages -c ../filesystem.toml)"

                1: Cargo: UPDATE_DEPS cookbook/cookbook/pkgutils
                Original: "cargo update --manifest-path cookbook/pkgutils/Cargo.toml"

                2: Cargo: UPDATE_DEPS cookbook/installer
                Original: "cargo update --manifest-path installer/Cargo.toml"

                3: Cargo: UPDATE_DEPS cookbook/kernel
                Original: "cargo update --manifest-path kernel/Cargo.toml"

                4: Cargo: UPDATE_DEPS cookbook/redoxfs
                Original: "cargo update --manifest-path redoxfs/Cargo.toml"


        Target: fetch
            Deps: []
            Defined in: "Makefile"
            Steps:
                0: Cargo: BUILD cookbook
                Original: "cargo build --manifest-path cookbook/Cargo.toml --release"

                1: cd cookbook  && \
                 ./fetch.sh "$$(cargo run --manifest-path ../installer/Cargo.toml -- --list-packages -c ../initfs.toml)" "$$(cargo run --manifest-path ../installer/Cargo.toml -- --list-packages -c ../filesystem.toml)"


        Comment { comment: "# Cross compiler recipes" }
        IncludeASTNode { include_path: "mk/prefix.mk" }
        ExportASTNode { name: "PREFIX_RUSTFLAGS", value: "-L $(ROOT)/$(PREFIX_INSTALL)/$(TARGET)/lib" }
        ExportASTNode { name: "RUSTUP_TOOLCHAIN", value: "$(ROOT)/$(PREFIX_INSTALL)" }
        ExportASTNode { name: "REDOXER_TOOLCHAIN", value: "$(RUSTUP_TOOLCHAIN)" }
        Target: prefix
            Deps: ["$(PREFIX_INSTALL)"]
            Defined in: "mk/prefix.mk"
            Steps:

        Target: $(PREFIX)/relibc-install
            Deps: ["$(ROOT)/relibc", "|", "$(PREFIX)/rust-install"]
            Defined in: "mk/prefix.mk"
            Steps:
                0: rm -rf "$@.partial" "$@"
                1: cp -r "$(PREFIX)/rust-install" "$@.partial"
                2: rm -rf "$@.partial/$(TARGET)/include/"*
                3: cp -r "$(PREFIX)/rust-install/$(TARGET)/include/c++" "$@.partial/$(TARGET)/include/c++"
                4: cp -r "$(PREFIX)/rust-install/lib/rustlib/$(HOST_TARGET)/lib/" "$@.partial/lib/rustlib/$(HOST_TARGET)/"
                5: rm -rf $@.partial/lib/rustlib/src
                6: mkdir $@.partial/lib/rustlib/src
                7: ln -s $(ROOT)/rust $@.partial/lib/rustlib/src
                8: cd "$<"  && \
                 export PATH="$(ROOT)/$@.partial/bin:$$PATH" && \
                 export CARGO="env -u CARGO cargo" && \
                 $(MAKE) -j `$(NPROC)` all && \
                 $(MAKE) -j `$(NPROC)` install DESTDIR="$(ROOT)/$@.partial/$(TARGET)"

                9: cd "$@.partial"  && \
                 $(PREFIX_STRIP)

                10: touch "$@.partial"
                11: mv "$@.partial" "$@"

        Target: $(PREFIX)/relibc-install.tar.gz
            Deps: ["$(PREFIX)/relibc-install"]
            Defined in: "mk/prefix.mk"
            Steps:
                0: tar --create --gzip --file "$@" --directory="$<" .

        If: ($(PREFIX_BINARY),1)
            Steps:
                0: Target: $(PREFIX)/rust-install.tar.gz
            Deps: []
            Defined in: "mk/prefix.mk"
            Steps:

                1: mkdir -p "$(@D)"
                2: Comment { comment: "#TODO: figure out why rust-install.tar.gz is missing /lib/rustlib/$(HOST_TARGET)/lib" }
                3: Target: wget -O $@.partial "https
            Deps: ["//static.redox-os.org/toolchain/$(TARGET)/relibc-install.tar.gz\""]
            Defined in: "mk/prefix.mk"
            Steps:
                0: wget -O $@.partial "https://static.redox-os.org/toolchain/$(TARGET)/relibc-install.tar.gz"
                1: mv $@.partial $@

                4: rm -rf "$@.partial" "$@"
                5: mkdir -p "$@.partial"
                6: tar --extract --file "$<" --directory "$@.partial" --strip-components=1
                7: touch "$@.partial"
                8: mv "$@.partial" "$@"
        Else:
            Steps:
                0: PREFIX_BASE_INSTALL=$(PREFIX)/rust-freestanding-install
                1: PREFIX_FREESTANDING_INSTALL=$(PREFIX)/gcc-freestanding-install
                2: PREFIX_BASE_PATH=$(ROOT)/$(PREFIX_BASE_INSTALL)/bin
                3: PREFIX_FREESTANDING_PATH=$(ROOT)/$(PREFIX_FREESTANDING_INSTALL)/bin
                4: Target: $(PREFIX)/binutils.tar.bz2
            Deps: []
            Defined in: "mk/prefix.mk"
            Steps:

                5: mkdir -p "$(@D)"
                6: Target: wget -O $@.partial "https
            Deps: ["//gitlab.redox-os.org/redox-os/binutils-gdb/-/archive/redox/binutils-gdb-redox.tar.bz2\""]
            Defined in: "mk/prefix.mk"
            Steps:
                0: wget -O $@.partial "https://gitlab.redox-os.org/redox-os/binutils-gdb/-/archive/redox/binutils-gdb-redox.tar.bz2"
                1: mv $@.partial $@

                7: rm -rf "$@.partial" "$@"
                8: mkdir -p "$@.partial"
                9: tar --extract --file "$<" --directory "$@.partial" --strip-components=1
                10: touch "$@.partial"
                11: mv "$@.partial" "$@"
                12: Target: $(PREFIX)/binutils-install
            Deps: ["$(PREFIX)/binutils"]
            Defined in: "mk/prefix.mk"
            Steps:

                13: rm -rf "$<-build" "$@.partial" "$@"
                14: mkdir -p "$<-build" "$@.partial"
                15: cd "$<-build"  && \
                 "$(ROOT)/$</configure" --target="$(TARGET)" --program-prefix="$(TARGET)-" --prefix="" --disable-werror && \
                 $(MAKE) -j `$(NPROC)` all && \
                 $(MAKE) -j `$(NPROC)` install DESTDIR="$(ROOT)/$@.partial"

                16: rm -rf "$<-build"
                17: cd "$@.partial"  && \
                 $(PREFIX_STRIP)

                18: touch "$@.partial"
                19: mv "$@.partial" "$@"
                20: Target: $(PREFIX)/gcc.tar.bz2
            Deps: []
            Defined in: "mk/prefix.mk"
            Steps:

                21: mkdir -p "$(@D)"
                22: Target: wget -O $@.partial "https
            Deps: ["//gitlab.redox-os.org/redox-os/gcc/-/archive/redox/gcc-redox.tar.bz2\""]
            Defined in: "mk/prefix.mk"
            Steps:
                0: wget -O $@.partial "https://gitlab.redox-os.org/redox-os/gcc/-/archive/redox/gcc-redox.tar.bz2"
                1: mv "$@.partial" "$@"

                23: mkdir -p "$@.partial"
                24: tar --extract --file "$<" --directory "$@.partial" --strip-components=1
                25: cd "$@.partial"  && \
                 ./contrib/download_prerequisites

                26: touch "$@.partial"
                27: mv "$@.partial" "$@"
                28: Target: $(PREFIX)/gcc-freestanding-install
            Deps: ["$(PREFIX)/gcc", "|", "$(PREFIX)/binutils-install"]
            Defined in: "mk/prefix.mk"
            Steps:

                29: rm -rf "$<-freestanding-build" "$@.partial" "$@"
                30: mkdir -p "$<-freestanding-build"
                31: cp -r "$(PREFIX)/binutils-install" "$@.partial"
                32: Target: cd "$<-freestanding-build" && export PATH="$(ROOT)/$@.partial/bin
            Deps: ["$$PATH\"", "&&", "\"$(ROOT)/$</configure\"", "--target=\"$(TARGET)\"", "--program-prefix=\"$(TARGET)-\"", "--prefix=\"\"", "--disable-nls", "--enable-languages=c,c++", "--without-headers", "&&", "$(MAKE)", "-j", "`$(NPROC)`", "all-gcc", "&&", "$(MAKE)", "-j", "`$(NPROC)`", "install-gcc", "DESTDIR=\"$(ROOT)/$@.partial\""]
            Defined in: "mk/prefix.mk"
            Steps:
                0: cd "$<-freestanding-build"  && \
                 export PATH="$(ROOT)/$@.partial/bin:$$PATH" && \
                 "$(ROOT)/$</configure" --target="$(TARGET)" --program-prefix="$(TARGET)-" --prefix="" --disable-nls --enable-languages=c,c++ --without-headers && \
                 $(MAKE) -j `$(NPROC)` all-gcc && \
                 $(MAKE) -j `$(NPROC)` install-gcc DESTDIR="$(ROOT)/$@.partial"

                1: rm -rf "$<-freestanding-build"
                2: cd "$@.partial"  && \
                 $(PREFIX_STRIP)

                3: touch "$@.partial"
                4: mv "$@.partial" "$@"

                33: rm -rf "$(PREFIX)/rust-freestanding-build" "$@.partial" "$@"
                34: mkdir -p "$(PREFIX)/rust-freestanding-build"
                35: cp -r "$(PREFIX)/binutils-install" "$@.partial"
                36: Target: cd "$(PREFIX)/rust-freestanding-build" && export PATH="$(ROOT)/$@.partial/bin
            Deps: ["$$PATH\"", "&&", "\"$</configure\"", "--prefix=\"/\"", "--disable-docs", "--enable-cargo-native-static", "--enable-extended", "--enable-llvm-static-stdcpp", "--tools=cargo", "&&", "$(MAKE)", "-j", "`$(NPROC)`", "&&", "$(MAKE)", "-j", "`$(NPROC)`", "install", "DESTDIR=\"$(ROOT)/$@.partial\""]
            Defined in: "mk/prefix.mk"
            Steps:
                0: cd "$(PREFIX)/rust-freestanding-build"  && \
                 export PATH="$(ROOT)/$@.partial/bin:$$PATH" && \
                 "$</configure" --prefix="/" --disable-docs --enable-cargo-native-static --enable-extended --enable-llvm-static-stdcpp --tools=cargo && \
                 $(MAKE) -j `$(NPROC)` && \
                 $(MAKE) -j `$(NPROC)` install DESTDIR="$(ROOT)/$@.partial"

                1: rm -rf "$(PREFIX)/rust-freestanding-build"
                2: mkdir -p "$@.partial/lib/rustlib/x86_64-unknown-linux-gnu/bin"
                3: cd "$@.partial"  && \
                 $(PREFIX_STRIP)

                4: touch "$@.partial"
                5: mv "$@.partial" "$@"
                6: mkdir $@/lib/rustlib/src
                7: ln -s $(ROOT)/rust $@/lib/rustlib/src

                37: rm -rf "$@.partial" "$@"
                38: mkdir -p "$@.partial"
                39: cd "$<"  && \
                 export PATH="$(PREFIX_BASE_PATH):$(PREFIX_FREESTANDING_PATH):$$PATH" && \
                 export CARGO="env -u CARGO -u RUSTUP_TOOLCHAIN cargo" && \
                 export CC_$(subst -,_,$(TARGET))="$(TARGET)-gcc -isystem $(ROOT)/$@.partial/$(TARGET)/include" && \
                 $(MAKE) -j `$(NPROC)` all && \
                 $(MAKE) -j `$(NPROC)` install DESTDIR="$(ROOT)/$@.partial/$(TARGET)"

                40: cd "$@.partial"  && \
                 $(PREFIX_STRIP)

                41: touch "$@.partial"
                42: mv "$@.partial" "$@"
                43: Target: $(PREFIX)/gcc-install
            Deps: ["$(PREFIX)/gcc", "|", "$(PREFIX)/relibc-freestanding-install"]
            Defined in: "mk/prefix.mk"
            Steps:

                44: rm -rf "$<-build" "$@.partial" "$@"
                45: mkdir -p "$<-build"
                46: cp -r "$(PREFIX_BASE_INSTALL)" "$@.partial"
                47: Target: cd "$<-build" && export PATH="$(ROOT)/$@.partial/bin
            Deps: ["$$PATH\"", "&&", "\"$(ROOT)/$</configure\"", "--target=\"$(TARGET)\"", "--program-prefix=\"$(TARGET)-\"", "--prefix=\"\"", "--with-sysroot", "--with-build-sysroot=\"$(ROOT)/$(PREFIX)/relibc-freestanding-install/$(TARGET)\"", "--with-native-system-header-dir=\"/include\"", "--disable-multilib", "--disable-nls", "--disable-werror", "--enable-languages=c,c++", "--enable-shared", "--enable-threads=posix", "&&", "$(MAKE)", "-j", "`$(NPROC)`", "all-gcc", "all-target-libgcc", "all-target-libstdc++-v3", "&&", "$(MAKE)", "-j", "`$(NPROC)`", "install-gcc", "install-target-libgcc", "install-target-libstdc++-v3", "DESTDIR=\"$(ROOT)/$@.partial\"", "&&", "rm", "$(ROOT)/$@.partial/$(TARGET)/lib/*.la"]
            Defined in: "mk/prefix.mk"
            Steps:
                0: cd "$<-build"  && \
                 export PATH="$(ROOT)/$@.partial/bin:$$PATH" && \
                 "$(ROOT)/$</configure" --target="$(TARGET)" --program-prefix="$(TARGET)-" --prefix="" --with-sysroot --with-build-sysroot="$(ROOT)/$(PREFIX)/relibc-freestanding-install/$(TARGET)" --with-native-system-header-dir="/include" --disable-multilib --disable-nls --disable-werror --enable-languages=c,c++ --enable-shared --enable-threads=posix && \
                 $(MAKE) -j `$(NPROC)` all-gcc all-target-libgcc all-target-libstdc++-v3 && \
                 $(MAKE) -j `$(NPROC)` install-gcc install-target-libgcc install-target-libstdc++-v3 DESTDIR="$(ROOT)/$@.partial" && \
                 rm $(ROOT)/$@.partial/$(TARGET)/lib/*.la

                1: rm -rf "$<-build"
                2: cd "$@.partial"  && \
                 $(PREFIX_STRIP)

                3: touch "$@.partial"
                4: mv "$@.partial" "$@"

                48: tar --create --gzip --file "$@" --directory="$<" .
                49: Target: $(PREFIX)/rust-install
            Deps: ["$(ROOT)/rust", "|", "$(PREFIX)/gcc-install", "$(PREFIX)/relibc-freestanding-install"]
            Defined in: "mk/prefix.mk"
            Steps:

                50: rm -rf "$(PREFIX)/rust-build" "$@.partial" "$@"
                51: mkdir -p "$(PREFIX)/rust-build"
                52: cp -r "$(PREFIX)/gcc-install" "$@.partial"
                53: cp -r "$(PREFIX)/relibc-freestanding-install/$(TARGET)" "$@.partial"
                54: Target: cd "$(PREFIX)/rust-build" && export PATH="$(ROOT)/$@.partial/bin
            Deps: ["$$PATH\"", "&&", "\"$</configure\"", "--prefix=\"/\"", "--disable-docs", "--enable-cargo-native-static", "--enable-extended", "--enable-llvm-static-stdcpp", "--tools=cargo", "--target=\"$(HOST_TARGET),$(TARGET)\"", "&&", "$(MAKE)", "-j", "`$(NPROC)`", "&&", "rm", "-rf", "\"$(ROOT)/$@.partial/lib/rustlib\"", "\"$(ROOT)/$@.partial/share/doc/rust\"", "&&", "$(MAKE)", "-j", "`$(NPROC)`", "install", "DESTDIR=\"$(ROOT)/$@.partial\""]
            Defined in: "mk/prefix.mk"
            Steps:
                0: cd "$(PREFIX)/rust-build"  && \
                 export PATH="$(ROOT)/$@.partial/bin:$$PATH" && \
                 "$</configure" --prefix="/" --disable-docs --enable-cargo-native-static --enable-extended --enable-llvm-static-stdcpp --tools=cargo --target="$(HOST_TARGET),$(TARGET)" && \
                 $(MAKE) -j `$(NPROC)` && \
                 rm -rf "$(ROOT)/$@.partial/lib/rustlib" "$(ROOT)/$@.partial/share/doc/rust" && \
                 $(MAKE) -j `$(NPROC)` install DESTDIR="$(ROOT)/$@.partial"

                1: rm -rf "$(PREFIX)/rust-build"
                2: mkdir -p "$@.partial/lib/rustlib/x86_64-unknown-linux-gnu/bin"
                3: cd "$@.partial"  && \
                 find . -name *.old -exec rm {} ';' && \
                 $(PREFIX_STRIP)

                4: touch "$@.partial"
                5: mv "$@.partial" "$@"

                55: tar --create --gzip --file "$@" --directory="$<" .

        Comment { comment: "# Bootloader recipes" }
        IncludeASTNode { include_path: "mk/bootloader.mk" }
        Target: bootloader/build/$(BOOTLOADER_TARGET)/bootloader.bin
            Deps: ["FORCE"]
            Defined in: "mk/bootloader.mk"
            Steps:
                0: env --unset=RUST_TARGET_PATH --unset=RUSTUP_TOOLCHAIN --unset=XARGO_RUST_SRC $(MAKE) -C bootloader build/$(BOOTLOADER_TARGET)/bootloader.bin TARGET=$(BOOTLOADER_TARGET)

        Target: build/bootloader.bin
            Deps: ["bootloader/build/$(BOOTLOADER_TARGET)/bootloader.bin"]
            Defined in: "mk/bootloader.mk"
            Steps:
                0: mkdir -p build
                1: cp -v $< $@

        Target: bootloader/build/$(BOOTLOADER_TARGET)/bootloader-live.bin
            Deps: ["FORCE"]
            Defined in: "mk/bootloader.mk"
            Steps:
                0: env --unset=RUST_TARGET_PATH --unset=RUSTUP_TOOLCHAIN --unset=XARGO_RUST_SRC $(MAKE) -C bootloader build/$(BOOTLOADER_TARGET)/bootloader-live.bin TARGET=$(BOOTLOADER_TARGET)

        Target: build/bootloader-live.bin
            Deps: ["bootloader/build/$(BOOTLOADER_TARGET)/bootloader-live.bin"]
            Defined in: "mk/bootloader.mk"
            Steps:
                0: mkdir -p build
                1: cp -v $< $@

        Target: bootloader/build/$(EFI_TARGET)/bootloader.efi
            Deps: ["FORCE"]
            Defined in: "mk/bootloader.mk"
            Steps:
                0: env --unset=RUST_TARGET_PATH --unset=RUSTUP_TOOLCHAIN --unset=XARGO_RUST_SRC $(MAKE) -C bootloader build/$(EFI_TARGET)/bootloader.efi TARGET=$(EFI_TARGET)

        Target: build/bootloader.efi
            Deps: ["bootloader/build/$(EFI_TARGET)/bootloader.efi"]
            Defined in: "mk/bootloader.mk"
            Steps:
                0: mkdir -p build
                1: cp -v $< $@

        Target: bootloader/build/$(EFI_TARGET)/bootloader-live.efi
            Deps: ["FORCE"]
            Defined in: "mk/bootloader.mk"
            Steps:
                0: env --unset=RUST_TARGET_PATH --unset=RUSTUP_TOOLCHAIN --unset=XARGO_RUST_SRC $(MAKE) -C bootloader build/$(EFI_TARGET)/bootloader-live.efi TARGET=$(EFI_TARGET)

        Target: build/bootloader-live.efi
            Deps: ["bootloader/build/$(EFI_TARGET)/bootloader-live.efi"]
            Defined in: "mk/bootloader.mk"
            Steps:
                0: mkdir -p build
                1: cp -v $< $@

        Target: bootloader-coreboot/build/bootloader
            Deps: ["build/kernel_coreboot"]
            Defined in: "mk/bootloader.mk"
            Steps:
                0: env --unset=RUST_TARGET_PATH --unset=RUSTUP_TOOLCHAIN --unset=XARGO_RUST_SRC $(MAKE) -C bootloader-coreboot clean build/bootloader KERNEL="$(ROOT)/$<"

        Target: build/coreboot.elf
            Deps: ["bootloader-coreboot/build/bootloader"]
            Defined in: "mk/bootloader.mk"
            Steps:
                0: mkdir -p build
                1: cp -v $< $@

        Comment { comment: "# Kernel recipes" }
        IncludeASTNode { include_path: "mk/kernel.mk" }
        Target: build/libkernel.a
            Deps: ["kernel/Cargo.lock", "kernel/Cargo.toml", "kernel/src/*", "kernel/src/*/*", "kernel/src/*/*/*", "kernel/src/*/*/*/*", "build/initfs.tag"]
            Defined in: "mk/kernel.mk"
            Steps:
                0: ExportASTNode { name: "PATH", value: "\"$(PREFIX_PATH):$$PATH\" && export INITFS_FOLDER=$(ROOT)/build/initfs && cd kernel && cargo rustc --lib --target=$(ROOT)/kernel/targets/$(KTARGET).json --release -- -C soft-float -C debuginfo=2 -C lto --emit link=../$@" }

        Target: build/kernel
            Deps: ["kernel/linkers/$(ARCH).ld", "mk/kernel_ld.sh", "build/libkernel.a"]
            Defined in: "mk/kernel.mk"
            Steps:
                0: ExportASTNode { name: "PATH", value: "\"$(PREFIX_PATH):$$PATH\" && $(ROOT)/mk/kernel_ld.sh $(LD) --gc-sections -z max-page-size=0x1000 -T $< -o $@ build/libkernel.a && $(OBJCOPY) --only-keep-debug $@ $@.sym && $(OBJCOPY) --strip-debug $@" }

        Comment { comment: "# Filesystem recipes" }
        IncludeASTNode { include_path: "mk/initfs.mk" }
        Target: build/initfs.tag
            Deps: ["initfs.toml", "prefix"]
            Defined in: "mk/initfs.mk"
            Steps:
                0: Cargo: BUILD cookbook
                Original: "cargo build --manifest-path cookbook/Cargo.toml --release"

                1: Cargo: BUILD installer
                Original: "cargo build --manifest-path installer/Cargo.toml --release"

                2: rm -f build/libkernel.a
                3: rm -rf build/initfs
                4: mkdir -p build/initfs
                5: $(INSTALLER) -c $< build/initfs/
                6: Comment { comment: "#TODO: HACK FOR SMALLER INITFS, FIX IN PACKAGING" }
                7: for bin in $(INITFS_RM_BINS); do rm -f build/initfs/bin/$$bin; done
                8: touch $@

        IncludeASTNode { include_path: "mk/filesystem.mk" }
        Target: build/filesystem.bin
            Deps: ["filesystem.toml", "build/kernel", "prefix"]
            Defined in: "mk/filesystem.mk"
            Steps:
                0: Cargo: BUILD cookbook
                Original: "cargo build --manifest-path cookbook/Cargo.toml --release"

                1: Cargo: BUILD installer
                Original: "cargo build --manifest-path installer/Cargo.toml --release"

                2: Cargo: BUILD redoxfs
                Original: "cargo build --manifest-path redoxfs/Cargo.toml --release"

                3: -$(FUMOUNT) build/filesystem/ || true
                4: rm -rf $@  $@.partial build/filesystem/
                5: dd if=/dev/zero of=$@.partial bs=1048576 count="$(FILESYSTEM_SIZE)"
                6: Cargo: RUN redoxfs
                Original: "cargo run --manifest-path redoxfs/Cargo.toml --release --bin redoxfs-mkfs $@.partial"

                7: mkdir -p build/filesystem/
                8: redoxfs/target/release/redoxfs $@.partial build/filesystem/
                9: sleep 2
                10: pgrep redoxfs
                11: cp $< build/filesystem/filesystem.toml
                12: cp build/kernel build/filesystem/kernel
                13: cp -r $(ROOT)/$(PREFIX_INSTALL)/$(TARGET)/include build/filesystem/include
                14: cp -r $(ROOT)/$(PREFIX_INSTALL)/$(TARGET)/lib build/filesystem/lib
                15: $(INSTALLER) -c $< build/filesystem/
                16: sync
                17: -$(FUMOUNT) build/filesystem/ || true
                18: rm -rf build/filesystem/
                19: mv $@.partial $@

        Target: mount
            Deps: ["FORCE"]
            Defined in: "mk/filesystem.mk"
            Steps:
                0: mkdir -p build/filesystem/
                1: Cargo: BUILD redoxfs
                Original: "cargo build --manifest-path redoxfs/Cargo.toml --release --bin redoxfs"

                2: redoxfs/target/release/redoxfs build/harddrive.bin build/filesystem/
                3: sleep 2
                4: pgrep redoxfs

        Target: mount_extra
            Deps: ["FORCE"]
            Defined in: "mk/filesystem.mk"
            Steps:
                0: mkdir -p build/filesystem/
                1: Cargo: BUILD redoxfs
                Original: "cargo build --manifest-path redoxfs/Cargo.toml --release --bin redoxfs"

                2: redoxfs/target/release/redoxfs build/extra.bin build/filesystem/
                3: sleep 2
                4: pgrep redoxfs

        Target: unmount
            Deps: ["FORCE"]
            Defined in: "mk/filesystem.mk"
            Steps:
                0: sync
                1: -$(FUMOUNT) build/filesystem/ || true
                2: rm -rf build/filesystem/

        Comment { comment: "# Disk images" }
        IncludeASTNode { include_path: "mk/disk.mk" }
        Target: build/harddrive.bin
            Deps: ["build/bootloader.bin", "build/filesystem.bin"]
            Defined in: "mk/disk.mk"
            Steps:
                0: dd if=/dev/zero of=$@.partial bs=1M count=$$(expr $$(du -m build/filesystem.bin | cut -f1) + 2)
                1: $(PARTED) -s -a minimal $@.partial mklabel msdos
                2: $(PARTED) -s -a minimal $@.partial mkpart primary 2048s $$(expr $$(du -m build/filesystem.bin | cut -f1) \* 2048 + 2048)s
                3: dd if=$< of=$@.partial bs=1 count=446 conv=notrunc
                4: dd if=$< of=$@.partial bs=512 skip=1 seek=1 conv=notrunc
                5: dd if=build/filesystem.bin of=$@.partial bs=1M seek=1 conv=notrunc
                6: mv $@.partial $@

        Target: build/livedisk.bin
            Deps: ["build/bootloader-live.bin", "build/filesystem.bin"]
            Defined in: "mk/disk.mk"
            Steps:
                0: dd if=/dev/zero of=$@.partial bs=1M count=$$(expr $$(du -m build/filesystem.bin | cut -f1) + 2)
                1: $(PARTED) -s -a minimal $@.partial mklabel msdos
                2: $(PARTED) -s -a minimal $@.partial mkpart primary 2048s $$(expr $$(du -m build/filesystem.bin | cut -f1) \* 2048 + 2048)s
                3: dd if=$< of=$@.partial bs=1 count=446 conv=notrunc
                4: dd if=$< of=$@.partial bs=512 skip=1 seek=1 conv=notrunc
                5: dd if=build/filesystem.bin of=$@.partial bs=1M seek=1 conv=notrunc
                6: mv $@.partial $@

        Target: build/livedisk.iso
            Deps: ["build/livedisk.bin.gz"]
            Defined in: "mk/disk.mk"
            Steps:
                0: rm -rf build/iso/
                1: mkdir -p build/iso/
                2: cp -RL isolinux build/iso/
                3: cp $< build/iso/livedisk.gz
                4: genisoimage -o $@ -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table build/iso/
                5: isohybrid $@

        Target: build/harddrive-efi.bin
            Deps: ["build/bootloader.efi", "build/filesystem.bin"]
            Defined in: "mk/disk.mk"
            Steps:
                0: Comment { comment: "# TODO: Validate the correctness of this \\" }
                1: Comment { comment: "# Populate an EFI system partition \\" }
                2: dd if=/dev/zero of=$@.esp bs=1048576 count=$$(expr $$(du -m $< | cut -f1) + 1)  && \
                 mkfs.vfat $@.esp && \
                 mmd -i $@.esp efi && \
                 mmd -i $@.esp efi/boot && \
                 mcopy -i $@.esp $< ::efi/boot/bootx64.efi && \
                 dd if=/dev/zero of=$@ bs=1048576 count=$$(expr $$(du -m $< | cut -f1) + 2 + $$(du -m build/filesystem.bin | cut -f1)) && \
                 $(PARTED) -s -a minimal $@ mklabel gpt && \
                 efi_disk_size=$$(du -m $< | cut -f1) && \
                 efi_disk_blkcount=$$(expr $$efi_disk_size \* $$(expr 1048576 / 512)) && \
                 efi_end=$$(expr 2048 + $$efi_disk_blkcount) && \
                 efi_last=$$(expr $$efi_end - 1) && \
                 $(PARTED) -s -a minimal $@ mkpart EFI fat32 2048s "$${efi_last}s" && \
                 fs_disk_size=$$(du -m build/filesystem.bin | cut -f1) && \
                 fs_disk_blkcount=$$(expr $$fs_disk_size \* $$(expr 1048576 / 512)) && \
                 $(PARTED) -s -a minimal $@ mkpart redox ext4 "$${efi_end}s" $$(expr $$efi_end + $$fs_disk_blkcount)s && \
                 $(PARTED) -s -a minimal $@ set 1 boot on && \
                 $(PARTED) -s -a minimal $@ set 1 esp on && \
                 dd if=$@.esp bs=512 seek=2048 conv=notrunc count=$$efi_disk_blkcount of=$@ && \
                 dd if=build/filesystem.bin seek=$$efi_end bs=512 conv=notrunc of=$@ count=$$fs_disk_blkcount


        Target: build/livedisk-efi.bin
            Deps: ["build/bootloader-live.efi", "build/filesystem.bin"]
            Defined in: "mk/disk.mk"
            Steps:
                0: Comment { comment: "# TODO: Validate the correctness of this \\" }
                1: Comment { comment: "# Populate an EFI system partition \\" }
                2: dd if=/dev/zero of=$@.esp bs=1048576 count=$$(expr $$(du -m $< | cut -f1) + 1)  && \
                 mkfs.vfat $@.esp && \
                 mmd -i $@.esp efi && \
                 mmd -i $@.esp efi/boot && \
                 mcopy -i $@.esp $< ::efi/boot/bootx64.efi && \
                 dd if=/dev/zero of=$@ bs=1048576 count=$$(expr $$(du -m $< | cut -f1) + 2 + $$(du -m build/filesystem.bin | cut -f1)) && \
                 $(PARTED) -s -a minimal $@ mklabel gpt && \
                 efi_disk_size=$$(du -m $< | cut -f1) && \
                 efi_disk_blkcount=$$(expr $$efi_disk_size \* $$(expr 1048576 / 512)) && \
                 efi_end=$$(expr 2048 + $$efi_disk_blkcount) && \
                 efi_last=$$(expr $$efi_end - 1) && \
                 $(PARTED) -s -a minimal $@ mkpart EFI fat32 2048s "$${efi_last}s" && \
                 fs_disk_size=$$(du -m build/filesystem.bin | cut -f1) && \
                 fs_disk_blkcount=$$(expr $$fs_disk_size \* $$(expr 1048576 / 512)) && \
                 $(PARTED) -s -a minimal $@ mkpart redox ext4 "$${efi_end}s" $$(expr $$efi_end + $$fs_disk_blkcount)s && \
                 $(PARTED) -s -a minimal $@ set 1 boot on && \
                 $(PARTED) -s -a minimal $@ set 1 esp on && \
                 dd if=$@.esp bs=512 seek=2048 conv=notrunc count=$$efi_disk_blkcount of=$@ && \
                 dd if=build/filesystem.bin seek=$$efi_end bs=512 conv=notrunc of=$@ count=$$fs_disk_blkcount


        Comment { comment: "# Emulation recipes" }
        IncludeASTNode { include_path: "mk/qemu.mk" }
        If: ($(serial),no)
            Steps:
                0: QEMUFLAGS+=-chardev stdio,id=debug -device isa-debugcon,iobase=0x402,chardev=debug
        Else:
            Steps:
                0: QEMUFLAGS+=-chardev stdio,id=debug,signal=off,mux=on,"$(if $(qemu_serial_logfile),logfile=$(qemu_serial_logfile))"
                1: Target: QEMUFLAGS+=-serial chardev
            Deps: ["debug", "-mon", "chardev=debug"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: QEMUFLAGS+=-serial chardev:debug -mon chardev=debug

                2: ifeq ($(iommu),yes)
                3: QEMUFLAGS+=-machine q35,iommu=on
                4: else
                5: QEMUFLAGS+=-machine q35

        If: ($(net),no)
            Steps:
                0: QEMUFLAGS+=-net none
        Else:
            Steps:
                0: ifneq ($(bridge),)
                1: QEMUFLAGS+=-netdev bridge,br=$(bridge),id=net0 -device e1000,netdev=net0,id=nic0
                2: else
                3: ifeq ($(net),redir)
                4: Comment { comment: "# port 8080 and 8083 - webservers" }
                5: Comment { comment: "# port 64126 - our gdbserver implementation" }
                6: Target: QEMUFLAGS+=-netdev user,id=net0,hostfwd=tcp
            Deps: [":8080-:8080,hostfwd=tcp::8083-:8083,hostfwd=tcp::64126-:64126", "-device", "e1000,netdev=net0,id=nic0"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: QEMUFLAGS+=-netdev user,id=net0,hostfwd=tcp::8080-:8080,hostfwd=tcp::8083-:8083,hostfwd=tcp::64126-:64126 -device e1000,netdev=net0,id=nic0
                1: else
                2: QEMUFLAGS+=-netdev user,id=net0 -device e1000,netdev=net0 -object filter-dump,id=f1,netdev=net0,file=build/network.pcap
                3: endif
                4: endif

                7: ifeq ($(vga),no)
                8: QEMUFLAGS+=-nographic -vga none

        If: ($(gdb),yes)
            Steps:
                0: QEMUFLAGS+=-s

        If: ($(UNAME),Linux)
            Steps:
                0: ifneq ($(kvm),no)
                1: QEMUFLAGS+=-enable-kvm -cpu host
        Else:
            Steps:
                0: QEMUFLAGS+=-cpu max

        Comment { comment: "#,int,pcall" }
        Comment { comment: "#-device intel-iommu" }
        If: ($(UNAME),Linux)
            Steps:
                0: Target: build/extra.bin
            Deps: []
            Defined in: "mk/qemu.mk"
            Steps:

                1: fallocate --posix --length 1G $@
        Else:
            Steps:
                0: Target: build/extra.bin
            Deps: []
            Defined in: "mk/qemu.mk"
            Steps:

                1: truncate -s 1g $@

        Target: qemu
            Deps: ["build/harddrive.bin", "build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -drive file=build/harddrive.bin,format=raw -drive file=build/extra.bin,format=raw

        Target: qemu_no_build
            Deps: ["build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -drive file=build/harddrive.bin,format=raw -drive file=build/extra.bin,format=raw

        Target: qemu_efi
            Deps: ["build/harddrive-efi.bin", "build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -bios $(QEMU_EFI) -drive file=build/harddrive-efi.bin,format=raw -drive file=build/extra.bin,format=raw

        Target: qemu_efi_no_build
            Deps: ["build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -bios $(QEMU_EFI) -drive file=build/harddrive-efi.bin,format=raw -drive file=build/extra.bin,format=raw

        Target: qemu_nvme
            Deps: ["build/harddrive.bin", "build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -drive file=build/harddrive.bin,format=raw,if=none,id=drv0 -device nvme,drive=drv0,serial=NVME_SERIAL -drive file=build/extra.bin,format=raw,if=none,id=drv1 -device nvme,drive=drv1,serial=NVME_EXTRA

        Target: qemu_nvme_no_build
            Deps: ["build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -drive file=build/harddrive.bin,format=raw,if=none,id=drv0 -device nvme,drive=drv0,serial=NVME_SERIAL -drive file=build/extra.bin,format=raw,if=none,id=drv1 -device nvme,drive=drv1,serial=NVME_EXTRA

        Target: qemu_nvme_efi
            Deps: ["build/harddrive-efi.bin", "build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -bios $(QEMU_EFI) -drive file=build/harddrive-efi.bin,format=raw,if=none,id=drv0 -device nvme,drive=drv0,serial=NVME_SERIAL -drive file=build/extra.bin,format=raw,if=none,id=drv1 -device nvme,drive=drv1,serial=NVME_EXTRA

        Target: qemu_nvme_efi_no_build
            Deps: ["build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -bios $(QEMU_EFI) -drive file=build/harddrive-efi.bin,format=raw,if=none,id=drv0 -device nvme,drive=drv0,serial=NVME_SERIAL -drive file=build/extra.bin,format=raw,if=none,id=drv1 -device nvme,drive=drv1,serial=NVME_EXTRA

        Target: qemu_nvme_live
            Deps: ["build/livedisk.bin", "build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -drive file=build/livedisk.bin,format=raw,if=none,id=drv0 -device nvme,drive=drv0,serial=NVME_SERIAL -drive file=build/extra.bin,format=raw,if=none,id=drv1 -device nvme,drive=drv1,serial=NVME_EXTRA

        Target: qemu_nvme_live_no_build
            Deps: ["build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -drive file=build/livedisk.bin,format=raw,if=none,id=drv0 -device nvme,drive=drv0,serial=NVME_SERIAL -drive file=build/extra.bin,format=raw,if=none,id=drv1 -device nvme,drive=drv1,serial=NVME_EXTRA

        Target: qemu_live
            Deps: ["build/livedisk.bin", "build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -drive file=build/livedisk.bin,format=raw -drive file=build/extra.bin,format=raw

        Target: qemu_live_no_build
            Deps: ["build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -drive file=build/livedisk.bin,format=raw -drive file=build/extra.bin,format=raw

        Target: qemu_live_efi
            Deps: ["build/livedisk-efi.bin", "build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -bios $(QEMU_EFI) -drive file=build/livedisk-efi.bin,format=raw -drive file=build/extra.bin,format=raw

        Target: qemu_live_efi_no_build
            Deps: ["build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -bios $(QEMU_EFI) -drive file=build/livedisk-efi.bin,format=raw -drive file=build/extra.bin,format=raw

        Target: qemu_iso
            Deps: ["build/livedisk.iso", "build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -boot d -cdrom build/livedisk.iso -drive file=build/extra.bin,format=raw

        Target: qemu_iso_no_build
            Deps: ["build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -boot d -cdrom build/livedisk.iso -drive file=build/extra.bin,format=raw

        Target: qemu_extra
            Deps: ["build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -drive file=build/extra.bin,format=raw

        Target: qemu_nvme_extra
            Deps: ["build/extra.bin"]
            Defined in: "mk/qemu.mk"
            Steps:
                0: $(QEMU) $(QEMUFLAGS) -drive file=build/extra.bin,format=raw,if=none,id=drv1 -device nvme,drive=drv1,serial=NVME_EXTRA

        IncludeASTNode { include_path: "mk/bochs.mk" }
        Target: bochs
            Deps: ["build/harddrive.bin"]
            Defined in: "mk/bochs.mk"
            Steps:
                0: bochs -f bochs.$(ARCH)

        IncludeASTNode { include_path: "mk/virtualbox.mk" }
        Target: virtualbox
            Deps: ["build/harddrive.bin"]
            Defined in: "mk/virtualbox.mk"
            Steps:
                0: echo "Delete VM"
                1: -$(VBM) unregistervm Redox --delete; if [ $$? -ne 0 ]; then if [ -d "$$HOME/VirtualBox VMs/Redox" ]; then echo "Redox directory exists, deleting..."; $(RM) -rf "$$HOME/VirtualBox VMs/Redox"; fi fi
                2: echo "Delete Disk"
                3: -$(RM) harddrive.vdi
                4: echo "Create VM"
                5: $(VBM) createvm --name Redox --register
                6: echo "Set Configuration"
                7: $(VBM) modifyvm Redox --memory 2048
                8: $(VBM) modifyvm Redox --vram 32
                9: if [ "$(net)" != "no" ]; then $(VBM) modifyvm Redox --nic1 nat; $(VBM) modifyvm Redox --nictype1 82540EM; $(VBM) modifyvm Redox --cableconnected1 on; $(VBM) modifyvm Redox --nictrace1 on; $(VBM) modifyvm Redox --nictracefile1 "$(ROOT)/$(BUILD)/network.pcap"; fi
                10: $(VBM) modifyvm Redox --uart1 0x3F8 4
                11: $(VBM) modifyvm Redox --uartmode1 file "$(ROOT)/$(BUILD)/serial.log"
                12: $(VBM) modifyvm Redox --usb off # on
                13: $(VBM) modifyvm Redox --keyboard ps2
                14: $(VBM) modifyvm Redox --mouse ps2
                15: $(VBM) modifyvm Redox --audio $(VB_AUDIO)
                16: $(VBM) modifyvm Redox --audiocontroller hda
                17: $(VBM) modifyvm Redox --nestedpaging on
                18: echo "Create Disk"
                19: $(VBM) convertfromraw $< build/harddrive.vdi
                20: echo "Attach Disk"
                21: $(VBM) storagectl Redox --name ATA --add sata --controller IntelAHCI --bootable on --portcount 1
                22: $(VBM) storageattach Redox --storagectl ATA --port 0 --device 0 --type hdd --medium build/harddrive.vdi
                23: echo "Run VM"
                24: $(VBM) startvm Redox

        Comment { comment: "# CI image target" }
        Target: ci-img
            Deps: ["FORCE"]
            Defined in: "Makefile"
            Steps:
                0: $(MAKE) INSTALLER_FLAGS= build/harddrive.bin.gz build/livedisk.bin.gz build/livedisk.iso.gz build/harddrive-efi.bin.gz build/livedisk-efi.bin.gz
                1: rm -rf build/img
                2: mkdir -p build/img
                3: cp "build/harddrive.bin.gz" "build/img/redox_$(IMG_TAG)_harddrive.bin.gz"
                4: cp "build/livedisk.bin.gz" "build/img/redox_$(IMG_TAG)_livedisk.bin.gz"
                5: cp "build/livedisk.iso.gz" "build/img/redox_$(IMG_TAG)_livedisk.iso.gz"
                6: cp "build/harddrive-efi.bin.gz" "build/img/redox_$(IMG_TAG)_harddrive-efi.bin.gz"
                7: cp "build/livedisk-efi.bin.gz" "build/img/redox_$(IMG_TAG)_livedisk-efi.bin.gz"
                8: cd build/img  && \
                 sha256sum -b * > SHA256SUM


        Comment { comment: "# CI packaging target" }
        Target: ci-pkg
            Deps: ["prefix", "FORCE"]
            Defined in: "Makefile"
            Steps:
                0: Cargo: BUILD cookbook
                Original: "cargo build --manifest-path cookbook/Cargo.toml --release"

                1: ExportASTNode { name: "PATH", value: "\"$(PREFIX_PATH):$$PATH\" && PACKAGES=\"$$(cargo run --manifest-path installer/Cargo.toml -- --list-packages -c ci.toml)\" && cd cookbook && ./fetch.sh \"$${PACKAGES}\" && ./repo.sh \"$${PACKAGES}\"" }

        Comment { comment: "# CI toolchain" }
        Target: ci-toolchain
            Deps: ["FORCE"]
            Defined in: "Makefile"
            Steps:
                0: $(MAKE) PREFIX_BINARY=0 "prefix/$(TARGET)/gcc-install.tar.gz" "prefix/$(TARGET)/relibc-install.tar.gz" "prefix/$(TARGET)/rust-install.tar.gz"
                1: rm -rf "build/toolchain/$(TARGET)"
                2: mkdir -p "build/toolchain/$(TARGET)"
                3: cp "prefix/$(TARGET)/gcc-install.tar.gz" "build/toolchain/$(TARGET)/gcc-install.tar.gz"
                4: cp "prefix/$(TARGET)/relibc-install.tar.gz" "build/toolchain/$(TARGET)/relibc-install.tar.gz"
                5: cp "prefix/$(TARGET)/rust-install.tar.gz" "build/toolchain/$(TARGET)/rust-install.tar.gz"
                6: cd "build/toolchain/$(TARGET)"  && \
                 sha256sum -b * > SHA256SUM


        Target: env
            Deps: ["prefix", "FORCE"]
            Defined in: "Makefile"
            Steps:
                0: ExportASTNode { name: "PATH", value: "\"$(PREFIX_PATH):$$PATH\" && bash" }

        Target: gdb
            Deps: ["FORCE"]
            Defined in: "Makefile"
            Steps:
                0: gdb build/kernel.sym --eval-command="target remote localhost:1234"

        Comment { comment: "# An empty target" }
        Target: FORCE
            Deps: []
            Defined in: "Makefile"
            Steps:

        Comment { comment: "# Gzip any binary" }
        Target: %.gz
            Deps: ["%"]
            Defined in: "Makefile"
            Steps:
                0: gzip -k -f $<

        Comment { comment: "# Create a listing for any binary" }
        Target: %.list
            Deps: ["%"]
            Defined in: "Makefile"
            Steps:
                0: ExportASTNode { name: "PATH", value: "\"$(PREFIX_PATH):$$PATH\" && $(OBJDUMP) -C -M intel -D $< > $@" }

        Comment { comment: "# Wireshark" }
        Target: wireshark
            Deps: ["FORCE"]
            Defined in: "Makefile"
            Steps:
                0: wireshark build/network.pcap

 
