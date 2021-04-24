## More about X

> Chapter 4

A desktop manager consists of a session manager, which 
  * start and maintains the components of the graphical session,
  * and the window manager, which
      * controls the placement and movement of windows
      * window title-bars
      * and controls.

Although these can be mixed, generally a set of utilities, session manager, and window manager are used together as a unit, and together provide a seamless experience.

If the display manager is not started by default in the default runlevel, you can start the graphical desktop different way, after logging on to a text-mode console, by running `startx` from the command line. Or, you can start the display manager (gdm, lightdm, kdm, xdm, etc.) manually from the command line. This differs from running `startx` as the display managers will project a sign in screen.

![](https://courses.edx.org/assets/courseware/v1/c4a2925d0a2d22c238c9f1d91f71635b/asset-v1:LinuxFoundationX+LFS101x+1T2020+type@asset+block/LFS01_ch03_screen29.jpg)

The X display manager starts at the end of the boot process (when you already installed a desktop environment)

Generally we can _select the Desktop Environment_ at login.

#### Desktop Environments

  * **gdm** (GNOME default)
  * **lightdm** (< Ubuntu 18.04 LTS )
  * **kdm** (KDE)

