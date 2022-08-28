## Loader

> Man page: ld-linux

Programs on linux: `ld.so` (for a.out binaries, doesn't exist on my arch), `ld-linux.so.1` (for libc5 binaries, doesn't exist on my arch), and `ld-linux.so.2` (for glibc, exists). Both libc5 and glibc compiled in ELF format.

It resolves the shared object dependencies, they may be strings with slashes (ie. paths), or without slashes, in which case there is a searching order (read man:ld-linux for info).

All three above use same files and programs, eg. `ldd`, `ldconfig`, and `ld.so.conf` (includes libfakeroot libraries on my system).

> TO KNOW: Why ?

