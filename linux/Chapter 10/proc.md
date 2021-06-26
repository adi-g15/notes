# The /proc filesystem

> A note about /bin and /usr/bin: History theoretically not important for boot binaries placed in /usr, and on different partition, to be able to mount later or even a network based filesystem, but now this is obsolete mostly, so they are symlinked now. (/bin -> /usr/bin)

Certain filesystems like the one mounted at /proc are called `pseudo-filesystems` because **they have no permanent presence** anywhere on the disk.

The /proc filesystem contains virtual files (files that exist only in memory) that **permit viewing constantly changing kernel data**.
/proc contains files & dirs that mimic kernel structures and config information.
It contains runtime system information, eg. system memory, devices mounted, hardware config, etc.

Some important entries:
* /proc/cpuinfo
* /proc/interrupts
* /proc/meminfo
* /proc/mounts
* /proc/partitions
* /proc/version

/proc also has subdirectories

* /proc/<PID-#> - contains vital information about each process
* /proc/sys - contains lot of info about **entire system**, in particular its hardware and configuration

The /proc filesystem is very useful because **the information it reports is gathered only as needed and never needs storage on the disk**

