* I am not writing everything, just new things

> Ref: https://trainingportal.linuxfoundation.org/learn/course/a-beginners-guide-to-linux-kernel-development-lfd103/building-and-installing-your-first-kernel/building-and-installing-your-first-kernel?page=4

## Trim down kernel modules

> I can't say if this is before or after oldconfig, or it will override it completely

```sh
lsmod > my-old-lsmod
make LSMOD=my-old-lsmod localmodconfig
```

## Looking for regressions and new errors

Save logs from current kernel to compare and look for regressions and new errors, if any.
dmesg with `-t` option generates logs without timestamps

```sh
dmesg -t > dmesg_current
dmesg -t -k > dmesg_kernel
dmesg -t -l emerg > dmesg_current_emerg
dmesg -t -l alert > dmesg_current_alert
dmesg -t -l crit > dmesg_current_crit
dmesg -t -l err > dmesg_current_err
dmesg -t -l warn > dmesg_current_warn
dmesg -t -l info > dmesg_current_info
```

NOTE: If the dmesg_current is zero length, it is very likely that secure boot is enabled on your system. When secure boot is enabled, you won’t be able to boot the newly installed kernel, as it is unsigned. You can disable secure boot temporarily on startup with MOK manager. Your system should already have mokutil.

## Secure Boot

Required to install `mokutil` on Arch Linux

```sh
mokutil --sb-state
```

If you see the following, you are all set to boot your newly installed kernel:

SecureBoot disabled
Platform is in Setup Mode

If you see the following, disable secure boot temporarily on startup with MOK manager:

SecureBoot enabled
SecureBoot validation is disabled in shim

Disable validation:

```sh
doas mokutil --disable-validation
root password
mok password: 12345678
mok password: 12345678
doas reboot
```

To enable validation again, it is `doas mokutil --enable-validation`

Ref: https://askubuntu.com/questions/1119734/how-to-replace-or-remove-kernel-with-signed-kernels

## Early Printing

Enable printing early boot messages to vga using the `earlyprintk=vga` kernel boot option.


