# SkiftOS

## Kernel

The main.cpp is at `kernel/system/main.cpp`. It has the `void system_main(Handover *handover)` function, seemingly the entrypoint.

The steps it does:

1. Slash screen (just log many lines using `Kernel::login("str")` to create the logo)
2. _Initialise_ System
3. _Initialise_ Memory
4. _Initialise_ Sheduler
5. _Initialise_ Tasking
6. _Initialise_ Interrupts
7. _Initialise_ Modules
8. _Initialise_ Drivers
9. _Initialise_ Devices
10. _Initialise_ Partitions
11. _Initialise_ Process Info (maybe some PCBs or something)
12. _Initialise_ Device Info
13. _Initialise_ Filesystem devices
14. _Initialise_ Graphics
15. _Initialise_ Userspace

