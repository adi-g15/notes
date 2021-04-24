## /sbin/init

> Chapter 3, whole copied

Once the kernel has set up all its hardware and mounted the root filesystem, the kernel runs /sbin/init. This then becomes the initial process, which then starts other processes to get the system running. Most other processes on the system trace their origin ultimately to init; exceptions include the so-called kernel processes. These are started by the kernel directly, and their job is to manage internal operating system details.

Besides starting the system, init is responsible for keeping the system running and for shutting it down cleanly. One of its responsibilities is to act when necessary as a manager for all non-kernel processes; it cleans up after them upon completion, and restarts user login services as needed when users log in and out, and does the same for other background system services.

Traditionally, this process startup was done using conventions that date back to the 1980s and the System V variety of UNIX. This serial process has the system passing through a sequence of runlevels containing collections of scripts that start and stop services. Each runlevel supports a different mode of running the system. Within each runlevel, individual services can be set to run, or to be shut down if running.

However, all major recent distributions have moved away from this sequential runlevel method of system initialization, although they usually support the System V conventions for compatibility purposes. Next, we discuss the newer methods, systemd and Upstart.

## Alternatives of System V init (SysVinit)
  * Upstart
      * Developed by Ubuntu and first included in 2006
      * Adopted in Fedora 9 (in 2008) and in RHEL 6 and its clones.

  * systemd
      * Developed by Ubuntu and first included in 2006
      * Adopted in Fedora 9 (in 2008) and in RHEL 6 and its clones.


![](https://courses.edx.org/assets/courseware/v1/640a31713f9fded06718cb06c468f685/asset-v1:LinuxFoundationX+LFS101x+1T2020+type@asset+block/LFS01_ch03_screen24.jpg)
