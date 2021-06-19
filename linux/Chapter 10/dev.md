# /dev directory

The /dev directory contains **device nodes**, a type of pseudo-file used by most hardware and software devices, except for network devices.

* It is empty on the disk partition when not mounted
* Contains entries which are created by the **udev** system, which creates and manages device nodes on Linux, **creating them dynamically when devices are found**.

Some entries:
* /dev/sda1 -> first partition on first harddisk
* /dev/lp1 -> second printer
* /dev/random -> a source of random numbers


