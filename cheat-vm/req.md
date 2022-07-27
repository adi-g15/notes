# Packages

Create partition, mkfs.ext4, mount

ip a, then passwd, then ssh
Copy /etc/pacman.conf inside ssh (later isko /mnt me bhi paste krdena)
chaotic-aur htana ho to hta dena, ya install ke liye follow steps

timedatectl set-ntp true

* pacstrap /mnt base linux-lts linux-firmware neovim firefox networkmanager sddm
* arch-chroot /mnt
* genfstab, ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime, hwclock --systohc, locale-gen, /etc/hostname, passwd
* mate (4-13), mate-extras(18-19), ncdu

grub-install and grub-mkconfig, decrease grub timeout

systemctl enable systemd-homed sddm NetworkManager

QEMU
* Add USB device hardware for usb video cam
* 2 GB RAM, 10 GM root
* virtio disk -> cachemode=unsafe, discardmode=unmap

scp localepurge localepurge-config

homectl create adi-child --storage=directory

* spice-vdagentd

systemctl enable NetworkManager sddm

Resolution: 1920x1080, 50Hz, 100%

Firefox - layout.css.devPixelsPerPx = 1.4, Remove bookmarks toolbar

Keyboard shortcuts - New terminal

Fonts - Sans Regular, 14; except title font 11

Terminal - Source Code Pro Regular 16

## pacman -Qe

```sh
[root@adi-child adi-child]# pacman -Qe
base 2-2
firefox 102.0.1-1
grub 2:2.06.r261.g2f4430cc0-1
linux-lts 5.15.55-1
mate-control-center 1.26.0-3
mate-desktop 1.26.0-1
mate-icon-theme 1.26.0-1
mate-menus 1.26.0-1
mate-notification-daemon 1.26.0-1
mate-panel 1.26.2-1
mate-polkit 1.26.0-1
mate-session-manager 1.26.0-1
mate-settings-daemon 1.26.0-1
mate-system-monitor 1.26.0-1
mate-terminal 1.26.0-1
mate-themes 3.22.23-1
ncdu 2.1.2-1
neovim 0.7.2-3
networkmanager 1.38.2-2
python 3.10.5-1
sddm 0.19.0-8
spice-vdagent 0.22.1-2
```
