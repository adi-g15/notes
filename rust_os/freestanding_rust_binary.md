# The `#![no_std]` attribute

Disable linking to the standard library

After disabling the use of the standard library, we need 3 things atleast: 

1. `#[panic_handler]`

  The `panic_handler` attribute defines the function that should be invoked when a panic occurs
  Receives a 'PanicInfo' object

  For now we mark it as a **diverging function** by returning the 'never' type (`!`). For eg. infinite loop

2. `eh_personality` language item

  > Includes disabling stack unwinding for now

  > **Language Items** -> Special functions/types required internally by the compiler, for eg. the `Copy` trait is a language item that tells the compiler which types have copy semantics.

  The "eh_personality" language item marks a function used for implementing 'stack unwinding'.
  Though it requires OS specific libraries (eg. [libunwind](https://www.nongnu.org/libunwind/) on Linux or [structured exception handling](https://docs.microsoft.com/en-us/windows/win32/debug/structured-exception-handling))

  For now, just disable unwinding, with **panic = "abort"** lines in Cargo.toml

3. `start` language item

  > Involves overwriting the entry point, **implementing the start language item won't help, since it would still require crt0**, instead we overrite the `start` entrypoint directly

  There is generally a runtime system that calls the main or similar function, since we are not using a runtime here, `main` doesn't make sense without a runtime calling it

  **[Runtime system](https://en.wikipedia.org/wiki/Runtime_system)** -> It does the initialisation before calling main, and is responsible for things such as garbage collection
  `crt0` (C RunTime 0) work includes creating a stack and placing the arguments in the right registers. And for a rust binary, invoke the entry point of the Rust runtime (setting stack overflow gaurds or printing a backtrace on panic), which is marked by the `start` language item.

  **Solution** -> Tell the compiler we don't want the normal entrypoint chain, add `#![no_main]` attribute

  ```rs
    // extern "C" tells to use the [C calling convention](https://en.wikipedia.org/wiki/Calling_convention) for this function
    #[no_mangle]
    pub extern "C" fn _start() -> ! {
      loop {}
    }
  ```

  It is diverging, since it is directly call by the operating system or bootloader. So instead of returning, the entry point should eg. invoke the `exit` system call of the operating system, or shutdown the machine

## Linked Errors

Linker is a program that combines the generated code into an executable file.
Since executable formats differ between linux, windows and macOS, each system has its own linker that will throw different errors for now

> The fundamental cause of these errors are same: Linked default configurations expect that we require the C runtime, which we are not.
> So, solution is to tell don't include the C runtime

**Solution:** _Either build for bare matal (different target) or provide correct linker arguments_

### Building for bare metal target

The default target triple is like this: `x86_64-unknown-linux-gnu`, ie. arch-vendor-os-abi (where ABI, application binary interface is gnu) here, which assumes there is an OS that use the C runtime.

An example for bare metal environment is `thumbv7em-none-eabihf`, which describes an embedded ARM system

> To build for target `thumbv7em-non-eabihf`, add it in rustup, it downloads a copy of the standard (and core) library for the system.
>
> ```sh
>   rustup target add thumbv7em-none-eabihf
> ```

### Correcting linker arguments

> The linked errors are generally -> gcc expects some symbols of libc that we didn't include using our own _start and with no_std attribute
>                                    msvc can't find the entry name, nor guess the subsystem
>                                    clang can't find entry name, expects to link with libSystem.dylib, and crt0... Also for some reason, all functions have an additional '_' on macOS, so we set entry point to "__start" instead of "_start"

```toml
[target.'cfg(target_os = "linux")']
rustflags = ["-C", "link-arg=-nostartfiles"]

[target.'cfg(target_os = "windows")']
rustflags = ["-C", "link-args=/ENTRY:_start /SUBSYSTEM:console"]

[target.'cfg(target_os = "macos")']
rustflags = ["-C", "link-args=-e __start -static -nostartfiles"]
```

### Finally

```rs
// main.rs

#![no_std]
#![no_main]

use core::panic::PanicInfo;

#[no_mangle]
pub extern "C" fn _start() -> ! {
  // this function is the entry point, since the linked looks for a function named '_start' by default
  loop {}
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
  loop {}
}
```

```toml
# Cargo.toml

# Disable stack unwinding on panic
[profile.dev]
panic = "abort"

[profile.release]
panic = "abort"
```

