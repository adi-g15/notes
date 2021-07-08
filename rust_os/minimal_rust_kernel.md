# Boot Process

When computer turned on, it executes firmware code stored in the motherboard [ROM](https://en.wikipedia.org/wiki/Read-only_memory). This code also performs a **[power-on self-test (POST)](https://en.wikipedia.org/wiki/Power-on_self-test)**, detect RAM, pre-initialise CPU and hardware, looks for bootable disk, and start booting the kernel (or start the bootloader)

On x86, there are two **firmware standards**, BIOS and UEFI.

> A person in the UEFI boot issue pointed out, using it may also _spoil_ beginners as it does most of the work, which you otherwise will have to do it yourselves

## BIOS booting

For _compatibility with bootloaders from the 1980s_, the CPU is put into a 16-bit mode (aka [real-mode](https://en.wikipedia.org/wiki/Real_mode)).

Finds a bootable disk, it found, transfer control to its bootloader, which is a 512-byte portion of executable code in disk's beginning.

> Since most are larger than **512 bytes**, they split into a small first stage, and a second stage, which is subsequently loaded by the first stage.

> Also, its the job of bootloader to switch CPU from 16-bit to 32-bit (protected mode) or 64-bit (long mode); And also query some info (eg. memory map) from BIOS and pass it to the OS kernel

# Target

To provide the target specification for our custom `x86_64-unknown-none-none` target, we create a .json files, with details such as size of the data types, target-endian, etc.

```json
{
    "llvm-target": "x86_64-unknown-none",
    "data-layout": "e-m:e-i64:64-f80:128-n8:16:32:64-S128",
    "arch": "x86_64",
    "target-endian": "little",
    "target-pointer-width": "64",
    "target-c-int-width": "32",
    "os": "none",
    "executables": true,

    "linker-flavor": "ld.lld",
    "linker": "rust-lld",

    "panic-strategy": "abort",

    "disable-redzone": true,

    "features": "-mmx,-sse,+soft-float"
}
```

> Note that this **"panic-strategy": "abort"**, has same (and more) effect than in Cargo.toml, as it will also apply when we recompile 'core' library

> Note about "disable-redzone": When writing a kernel, always disable **red zone**, since we'll need to handle interrupts at some point. **[It is really khatarnak wala horrible thing !!](https://forum.osdev.org/viewtopic.php?t=21720)**. Read more https://os.phil-opp.com/red-zone/

### Note about "features"

`-mmx` and `-sse` (with minus sign), we disabled those features.
They determine support for SIMD instructions. We disabled it for our kernel code (NOT usercode, they will still be able to use them)
In little more detail at https://os.phil-opp.com/disable-simd/

Why ?
Because SIMD registers are large (8 bytes upto 64 bytes), and on each interrupt, the kernel requires to save all registers to restore later, including the complete SIMD state to main memory (the SIMD state is very large **512 - 1600 bytes**), and since interrupts can occur frequently we disable SIMD for our kernel.

A Problem Now:
Floating point operations on 'x86_64' require SIMD registers by default.
To solve this, we added 'soft-float' feature, which emulates FP operations through software functions based on normal integers.



