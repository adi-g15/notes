## Linux Filesystem

Think of a refrigerator that has multiple shelves that can be used for storing various items. These shelves help you organize the grocery items by shape, size, type, etc. The same concept applies to a filesystem, which is the embodiment of a method of storing and organizing arbitrary collections of data in a human-usable form.

Different types of filesystem:
  * Conventional `Disk filesystems`: ext*, XFS, BtrFS, JFS, NTFS...
  * `Flash` storage filesystems: ubifs, JFFS2, YAFFS, etc
  * `Database` filesystems
  * `Special purpose` filesystem: 
    * procfs
    * sysfs
    * tmpfs
    * squashfs
    * debugfs,
    etc.

> Note about partitions:
> One can think of a partition as a container in which a filesystem resides, although in some circumstances, a filesystem can span more than one partition if one uses symbolic links.

### Filesystem Hierarchy Standard

Linux systems store their important files according to a standard layout called the Filesystem Hierarchy Standard (FHS), which has long been maintained by the Linux Foundation. For more information, take a look at the following document: [Filesystem Hierarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf) created by LSB Workgroup. Having a standard is designed to ensure that users, administrators, and developers can move between distributions without having to re-learn how the system is organized.

![](https://courses.edx.org/assets/courseware/v1/66def40e2774fd96011565107706da2d/asset-v1:LinuxFoundationX+LFS101x+1T2020+type@asset+block/dirtree.jpg)
