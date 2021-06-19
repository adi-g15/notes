# /lib and /lib64

On modern systems, symlinked to counterparts in /usr.

Contain libraries required for essential programs in /bin and /sbin, filenames start with `ld` or `lib`, and most of these are **dynamically loaded libraries** (aka shared libraries or shared objects (SO))

> Kernel modules -> Kernel code, often device drivers (and that can be loaded or unloaded without restart) are located in `/lib/modules/<kernel-version>`

