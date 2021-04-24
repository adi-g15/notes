## X

The X server, which actually provides the GUI, uses `/etc/X11/xorg.conf` as its configuration file if it exists

In modern Linux distributions, this file is usually **NOT present**.
Only in few circumstances such as when certain less common graphic drivers are in use.

Changing this configuration file directly is usually for more advanced users. 

### Get current screen resolution:

```sh
xdpyinfo | grep dim
```


