## Removing /boot completely

Instead using the /efi partition

1. Edit /etc/mkinitcpio.d/\* to specify /efi/{vmlinuz,initram}\* instead of the ones in /boot
2. ...TODO Next is edit pacman hook or config to install the kernel image in /efi not /boot (actually the linux-zen package itself doesn't have /boot path, instead it has the kernel image at /lib/modules/_version_/vmlinuz
3. ...TODO For custom kernel, install to /efi not /boot, for this can use a **custom install script**

Basically the install script of linux - arch/x86/boot/install.sh is like:

```sh
# User may have a custom install script

if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi

# Default install - same as make zlilo

if [ -f $4/vmlinuz ]; then
        mv $4/vmlinuz $4/vmlinuz.old
fi

if [ -f $4/System.map ]; then
        mv $4/System.map $4/System.old
fi

cat $2 > $4/vmlinuz
cp $3 $4/System.map
```

4. grub

Actually grub by default uses `/boot/grub/grub.cfg` file for configuration, so even moving all images etc to efi will still need this file to let grub know that they are in efi.

Initially i thought, i may have re-compile grub myself to change default from /boot to /efi. But then in a SO answer to how grub finds grub.cfg, a person said, `grub-install` hardcodes the location, so i thought grub-install maybe providing such option.

And yes, there is `--boot-directory=DIR` (install GRUB images under the directory DIR/grub instead of the /boot/grub directory) option in `grub-install`, so it will require reinstallation :'), not much problem though

I did this:

> grub-install --target x86_64-efi --efi-directory /efi --boot-directory /efi/ --bootloader-id=GRUB --no-bootsector

Then moved grub.cfg, theme, kernel images, etc to /efi

Then, edit grub.cfg to remove /boot from paths of all theme, images etc (NOTE: %s/\/boot\//\// , no need to replace /boot with /efi, it should be replaced with /)
Set root to /efi partition not root, just before themes part, search --no-floppy --fs-uuid --set=root A068-166C

Should boot now :)

