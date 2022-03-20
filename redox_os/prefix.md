## Cross compiler recipes

Defined in: `mk/prefix.mk`

This file defines the `prefix` target, which is a common dependency for many targets, including `all`.

So, let's see what it does. Basically it will create a directory `prefix/$TARGET`,
where **`TARGET` will be `x86_64-unknown-redox`, default on a 64-bit system** (defined in mk/config.mk).

There are two ways, depending on value of `PREFIX_BINARY`:

1. PREFIX_BINARY=1 -> Download pre-built cross-compiled rustc relibc etc. (maybe a bit older version)
2. else -> Build it all (will take more time)

See following dependency tree:

### Dependency Tree

1. Download pre-built (`PREFIX_BINARY == 1`)

![](./deptree-prefix.png)

2. Build it all, cross compile gcc and binutils (`PREFIX_BINARY != 1`)

![](./deptree-prefix-build.png)

### Pre-Built

`prefix` depends on `prefix/$TARGET/relibc-install`, which depends on `prefix/$TARGET/rust-install`.

Won't go in depth in building of relibc iself, basically, it defines an `all` target that depends on various library files, eg. libc.a, crt0.o etc., which are built and then compiled to form the.:

> Note, that this assignment in relibc/Makefile will likely be ignored:
>
> ```makefile
> TARGET?=$(shell rustc -Z unstable-options --print target-spec-json | grep llvm-target | cut -d '"' -f4)
> ```
>
> This is called a conditional assignment, it only has an effect if the variable is not yet defined, which 'likely' is not the case, it already got defined when make included `mk/config.mk`.
