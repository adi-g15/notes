## build/filesystem.bin

**Defined in:** mk/filesystem.bin

### The target

```makefile
build/filesystem.bin: filesystem.toml build/bootloader build/kernel prefix
```

Here, the `filesystem.bin` is basically a disk image, with the redoxfs filesystem on it (created with tools from `redoxfs` crate), and containing files and packages needed for the system (added by `cookbook` and `installer` crates together) 

* `filesystem.toml` -
  It is a config file, that will be used by `installer` to install specific packages only, and to create given users and files.
  
  In the redox source code, it is a symlink to config/desktop.toml, you can replace it with your own config also, or use any other config in the `config/` directory.

* `build/bootloader` and `build/kernel` are copied as is to the root of the created filesystem

### Steps

> Environment variables have been replaced for easier understanding
>
> And some commands have been simplified

```sh
	cargo build --manifest-path cookbook/Cargo.toml
	cargo build --manifest-path installer/Cargo.toml
	cargo build --manifest-path redoxfs/Cargo.toml
```

`--manifest-path` just specifies location of the Cargo.toml file for a cargo crate. It is 'similar' (but current directory will be different) to `cd cookbook && cargo build`.

Firstly it builds the cargo crates since they are required for next steps, namely `cookbook` (provides utilities to fetch, build packages), `installer` (provides utilities to install packages and more files required for a working redox install) and `redoxfs` (provides utilities to create/modify redox's own filesystem called **redoxfs**, like ext4 is to linux).

```sh
	fusermount -u build/filesystem/
	rm -rf build/filesystem.bin.partial build/filesystem/
```

These are just some cleaning up, **unmount** (for more about `fusermount`, read man page fusermount(1)) build/filesystem, and delete any incomplete files, and start over

#### Creating the filesystem

```sh
	dd if=/dev/zero of=build/filesystem.bin.partial bs=1M count=256
	redoxfs/target/release/redoxfs-mkfs build/filesystem.bin.partial
```

Here, firstly with `dd`, we created a 256MB file, with all 0s. (256 is the default value of `FILESYSTEM_SIZE`, you can change it in `mk/config.mk`).

Then, we use the `redoxfs-mkfs` tool from **redoxfs** crate we earlier built in this.

> If you have used mkfs.ext4 etc. it is similar to that

In short, `redoxfs-mkfs`, writes some _Nodes_, such as Header, a free node taking all space, etc, at specific locations. These _Nodes_ are data structure which the filesystem **Node** stores data internally in the form of a 4-level tree.

To read more (and is interesting), read [redoxfs](./redoxfs.md).

#### Creating a basic root directory

```sh
	mkdir -p build/filesystem/
	redoxfs/target/release/redoxfs-mount filesystem.bin.partial build/filesystem/
	cp -r filesystem.toml \
	      build/bootloader \
	      /build/kernel \
		  $(ROOT)/$(PREFIX_INSTALL)/$(TARGET)/include \
		  $(ROOT)/$(PREFIX_INSTALL)/$(TARGET)/lib \
	      build/filesystem/
```

We create the directory `build/filesystem`, **This will act as mountpoint of the redoxfs root directory**, and after we have copied and created config files etc in it, and unmounted it, **finally the filesystem.bin will contain these files**.

`redoxfs-mount` is a tool from the `redoxfs` crate, and it will mount the filesystem.bin.partial file, which was created in last step at build/filesystem. So, we can easily create files as we normally do in any other filesystem, **the reading and writing will be done internally by the `libfuse` library**.

To read more on `redoxfs-mount`'s code, read [](./redoxfs.md)

Then, there with `cp`, we copy the bootloader directory, kernel and /include and /lib directories, since redox expects them at root of the filesystem (by filesystem root i mean currently it is the build/filesystem, since filesystem.bin is mounted there, read more on 'mounting filesystems' to clear any doubts or ask).

```sh
	installer/target/release/redox_installer --cookbook=cookbook -c filesystem.toml build/filesystem/

	# Unmount the filesystem.bin mounted at build/filesystem
	fusermount -u build/filesystem/

	# Since filesystem.bin is complete now, all steps done, rename it to filesystem.bin
	mv filesystem.bin.partial filesystem.bin
```

You may recall we said at beginning **filesystem.toml contains list of packages, users, files etc**.

And, `cookbook` is the directory in redox source code, which contains **recipe** (basically how to build a package) of many packages.

And, finally the `redox_installer` binary from the `installer` crate does:
1. Uses scripts from `cookbook` crate (for example, cookbook/recipe.sh) to build packages given in **filesystem.toml** 
2. Install (ie. copy built binaries etc. to build/filesystem.bin) packages
3. Create files/directories given in filesystem.toml, with file content being also given in filesystem.toml itself. For eg. /etc/hostname, and /usr/bin symbolic links too
4. Create users. That is create corresponding user config files, for example /etc/passwd, and the home directories.

To read more on `redox_installer`'s code, read [](./installer.md)
