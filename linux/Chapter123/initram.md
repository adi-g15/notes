## Initial RAM Disk

The `initramfs` _filesystem_ image contains programs and binaries (binary files) that perform all actions needed to mount the proper / (root) filesystem, like providing kernel functionality for the needed filesystem and device drivers for mass storage controllers with a facility called `udev` (user device), which actually figures out which devices are present, then find their device drivers, and load them.

After root filesystem is found, it is checked for errors, and is mount
After the mount is success, initramfs is **cleared** from RAM and the `init program` _on the root filesystem (/sbin/init_ is executed

THEN,
init handles the mounting and pivoting over to the real root filesystem


> NOTE - If special hardware drivers are needed before the mass storage can be accessed, they must be in the `initramfs`

![](https://courses.edx.org/assets/courseware/v1/13f8548b13ebe15a19aa1a6c3964fceb/asset-v1:LinuxFoundationX+LFS101x+1T2020+type@asset+block/LFS01_ch03_screen22.jpg)
