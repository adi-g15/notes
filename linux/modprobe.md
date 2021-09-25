# `modprobe`

> Source: https://linoxide.com/linux-modprobe-command/

The linux kernel has a modular design.
Modules are small pieces of code that may be loaded/unloaded by the kernel w/o having to restart the kernel.

When a new device eg USB/PCI is connected/removed, the kernel sends uevents.

The **uevents** contain info about the device such as vendor and model details.

Udev (device manager) is listening to these uevents, and _passes them to **modprobe**_

**modprobe** intelligently identifies the driver by searching under modules directory /lib/modules/$(uname -r)

## Useful commands

* Blacklisted & disabled modules: `modprobe -showconfig | grep "^(blacklist|install)"`
* Find modules: `find /lib/modules/$(uname -r) -print`
* Show loaded modules: `lsmod`
* Load module: `modprobe module`
* Unload module: `modprobe -r module`
* Module details: `modinfo module`

## Related commands

* `lsmod`
* `insmod` - modprobe is more intelligent considering it also loads module dependencies based on symbols in the module, but we still need insmod to add our own module, since modprobe only looks in standard module directories
* `rmmod` - Removes a kernel name based on name from /proc/modules
* `modinfo` - accepts filename, or filename without .ko in /lib/modules/$(uname -r)

Syntax - `modprobe [options] [Module Name]`

