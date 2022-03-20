# Some squeezing i did

## Actively used modules

These are some of the modules **I** set to builtin instead of as modules:

* `ext4` & `vfat` - This reduces time of dev-nvme0n1p7.device and efi.mount by a lot of ms, eg. about 80-100 ms, since home partition can be directly mounted maybe, without waiting for these modules to be mounted
* `bluetooth`, `rfkill`, `CONFIG_BT_HCIBTUSB` - Always loaded, even if bluetooth.service disabled, rfkill as built-in required by bluetooth to be built as built-in
* `nls_ascii`, `nls_cp437` - Native language support, ascii and codepage 437 always being loaded
* `usb_hid` - For any HID based device connected via USB, eg. USB keyboard, mouse

> @adi dont do all built-in, even if it takes some more milliseconds, dont go on making all in use modules as built-in, it's much easier with lsmod to see what modules being used

## Removed

* DeviceDrivers -> I2C -> Multiplexer I2C Chip support
* Pin controllers, GPIO

## Extras

* Changing `Storage=` to volatile in journald.conf, to even lessen the boot time, in case of bugs change it to persistent, to see messages of last time
* Changed RequiredBy from graphical.target to sddm.service, of `upower.service` and `NetworkManager.service`. This also improved time
* To disable vendor logo: `fbcon=nodefer` to kernel parameters

* Used hugepages using huge=advise in /etc/fstab for /var/cache/pacman, and in /lib/systemd/system/tmp.mount, following Documentation/admin-guide/mm/transhuge.rst and tmpfs(5).

* `CONFIG_CROSS_MEMORY_ATTACH` - PROCESS_VM_READV(2) are interesting syscalls... reducing double copy as in pipes
