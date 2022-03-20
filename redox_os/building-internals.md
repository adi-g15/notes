## "How" the build process actually goes

> $ROOT refers to the location of redox source code directory on your computer
> TODO: Or say that all relative paths are relative to redox source code

> Taking make qemu for reference

> This should be arranged using a table of index

Firstly, it includes (from files in `mk/` directory), variables and targets to install some dependencies.

```
# Configuration and variables
include mk/config.mk

# Dependencies
include mk/depends.mk
```

To me atleast, variables of interest are:

> **If interested, see [Variable declarations in redox Makefiles](./variable-declarations.md)**

```
ARCH?=x86_64
## Flags to pass to the installer (empty to download binary packages)
INSTALLER_FLAGS?=--cookbook=cookbook

...

ROOT=$(CURDIR)    # in mk/config.mk, this is used in MANY makefile in the project, and refers to the root of the redox source code

...

## Kernel variables
KTARGET=$(ARCH)-unknown-kernel
KBUILD=build/kernel

...

## Userspace variables
export TARGET=$(ARCH)-unknown-redox
BUILD=build/userspace
INSTALLER=\
        export PATH="$(PREFIX_PATH):$$PATH" && \
        installer/target/release/redox_installer $(INSTALLER_FLAGS)

...

## Bootloader variables
ifeq ($(ARCH),x86_64)
        BOOTLOADER_TARGET=x86-unknown-none
else
        BOOTLOADER_TARGET=$(ARCH)-unknown-none
endif
EFI_TARGET=$(ARCH)-unknown-uefi
```

Rest are the usual cross compiling preparations:

```
CC=$(TARGET)-gcc
...
```

> Here, `TARGET` is by default "x86_64-unknown-redox"

`mk/depends.mk` has 3 if-else conditions, that check whether `rustup`, `nasm`, and `cargo-config` (rust crate) are available.

It went through the usual bootstrap.sh script, these should be installed already, so skipping those

### Debugging the Kernel

Likely these two:

```sh
make qemu

make gdb
```

## `all` target

## `qemu` target

It's defined in the `mk/qemu.mk` file, 

This requires `build/harddrive.bin` which is built by the `all` target. So, this target first needs that before it's run

Apart from harddrive.bin, it also requires `build/extra.bin`

> Note: `build/harddrive.bin` can be skipped 'explictly' if already built by calling the `qemu_no_build` target, I dont know why though

Apart from these `qemu_nvme_efi` and `qemu_live_efi` are of interest to me too, there many other combinations too, such as `qemu_nvme_live_no_build` etc.

### Others in `mk/qemu.mk`

There are interesting variables too in mk/qemu.mk, to pass certain flags to QEMU, for eg. --enable-kvm

## `gdb` target

```makefile
gdb: FORCE
	gdb build/kernel.sym --eval-command="target remote localhost:1234"
```

Kernel must have been built already.

Then `make gdb` just loads the symbols file `build/kernel.sym` in gdb and runs the given command **target remote localhost:1234**, ie. it connects to the GDB server at localhost:1234, which is started by redox and hence can be remotely debugged.

## mk/prefix.mk

It has instructions to cross-compile tools/libraries required for redox, for eg. gcc, binutils etc.

There's mainly one interesting if-else condition (apart from variable declarations), that decides whether to download pre-built binaries from redox-os.org, or compile them.

It puts them in the `$ROOT/prefix` directory

```makefile
ifeq ($(PREFIX_BINARY),1)
  … Download and extract https://static.redox-os.org/toolchain/$(TARGET)/relibc-install.tar.gz
else
  … a LOT of instructions, in brief they all are for building gcc, binutils, rust
endif
```

> I don't think explaining this one will help, if interested try reading the Makefile you will understand it :D

## mk/bootloader.mk

This has the `build/bootloader.bin`, `build/bootloader.efi` and `build/coreboot.elf` targets among many other targets.

They use the source code inside `$ROOT/bootloader` and `$ROOT/bootloader-coreboot` directories, and copy the built binaries inside build/ directory.

For eg.

```makefile
bootloader/build/$(BOOTLOADER_TARGET)/bootloader.bin: FORCE
	env --unset=RUST_TARGET_PATH --unset=RUSTUP_TOOLCHAIN --unset=XARGO_RUST_SRC \
	$(MAKE) -C bootloader build/$(BOOTLOADER_TARGET)/bootloader.bin TARGET=$(BOOTLOADER_TARGET)

build/bootloader.bin: bootloader/build/$(BOOTLOADER_TARGET)/bootloader.bin
	mkdir -p build
	cp -v $< $@
```

> On my pc, $BOOTLOADER_TARGET is "x86-unknown-none", so considering that

See the second target, it just copies `bootloader/build/x86-unknown-none/bootloader.bin` to `build/bootloader.bin`, and depends on the first target.

So, before building bootloader.bin, some environment variables are unset so they don't affect the bootloader build.

Then, it does `make -C bootloader`, where **-C** flag in make is to change directory to that folder before compiling, ie. in simple words, go inside bootloader/ directory, and build the code, and passes

The other targets such as for bootloader.efi, coreboot.elf are also similar, one target builds it, other target just copies it inside `$ROOT/build` directory

## mk/kernel.mk

TODO

## mk/initfs.mk

Runs redox_installer which creates a directory structure for root filesystem and installs some binaries on it.

## mk/filesystem.mk

TODO

## mk/disk.mk

TODO

## mk/qemu.mk

TODO

## mk/bochs.mk

TODO

## mk/virtualbox.mk

TODO

