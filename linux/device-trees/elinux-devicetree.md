# What is Device Tree

The primary purpose of Device Tree in Linux is to provide a way to describe
non-discoverable hardware. This information was previously hard coded in source
code.

The format of the data in the .dtb blob file is commonly referred to as a 
Flattened Device Tree (FDT).

Is expanded into a kernel internal data structure known as the Expanded Device
Tree (EDT) for more efficient access for later phases of the boot and after the
system has completed booting.

Linux kernel can read device tree information in the ARM, x86, Microblaze, 
PowerPC, and Sparc architectures

compatible specifies the name of the system. It contains a string in the form "<manufacturer>,<model>
Theoretically, compatible is all the data an OS needs to uniquely identify a machine. If all the machine details are hard coded, then the OS could look specifically for "acme,coyotes-revenge" in the top level compatible property.

