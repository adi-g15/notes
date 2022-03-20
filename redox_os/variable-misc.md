## Reference for default variables in Redox OS Makefile

> Variables with '?' at end of their names are default values, you can override the value

* NPROC
  **Value**: nproc

* RUST_COMPILER_RT_ROOT: $(ROOT)/rust/src/llvm-project/compiler-rt

* RUST_TARGET_PATH: $(ROOT)/kernel/targets

* XARGO_RUST_SRC: $(ROOT)/rust/src

* AR_x86_64_unknown_redox = x86_64-unknown-redox-ar

> Similarly for CC... -> ...gcc, CXX… -> ...g++

* PREFIX_RUSTFLAGS: -L $(ROOT)/$(PREFIX_INSTALL)/$(TARGET)/lib
* RUSTUP_TOOLCHAIN: $(ROOT)/$(PREFIX_INSTALL)
* REDOXER_TOOLCHAIN: $(RUSTUP_TOOLCHAIN)

