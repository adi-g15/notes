# Removable Media - /media, /run and /mnt

Historically, `/media` directory was used to mount these removable media.
Though now, most are mounted inside `/run` directory, on major linux distros.

For example, a pendrive with label 'myusb' for user 'adity' would be mounted at '/run/media/adity/myusb'

## /mnt

It has been used since the early days on UNIX for **temporarily mounting filesystems**.
These can be those on removable media, but more often might be network filesystems, which are not normally mounted.
Or these can be temporary partitions, or so-called **loopback** filesystems, which are **files which pretend to be partitions**

