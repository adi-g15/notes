# Booting with device tree

OS Dev Ref: https://wiki.osdev.org/Devicetree

Device tree is a standard for describing the layout of devices attached to a computer.
Kernels which use device tree, are handed a static device tree blob by the
bootloader, instead of discovering devices for eg. by enumerating PCI devices,
as in x86.

> U-Boot and Barebox sounded like bootloaders

## Normally:

* Kernel contains entire hardware description
* Bootloader loads a single binary, the kernel image
  * `uImage` or `zImage`
* Bootloader passes additional info, called ATAGS to kernel through register r2
  * Contains info as memory size, location, kernel command line, etc.

* Bootloader tells _machine type_ through register r1

* U-Boot command: `bootm <kernel_img_addr>`
* Barebox variable: `bootm.image`

## With device tree

* Hardware description moves to separate binary, the DTB (device tree blob)
* Bootloader loads 2 binaries: kernel image and dtb
  * Kernel image: `uImage`/`zImage`
  * DTB located in arch/arm/boot/dts (Not only my system, since it's not arm),
    one per board (?)

* Bootloader now passes DTB address through r2.
  * It will adjust the DTB with memory info, kernel command line, etc.
* No need for machine type in r1

* U-Boot command: `bootm <kernel_img_addr> - <dtb_addr>`
* Barebox variables: `bootm.image,bootm.oftree`

### Compatibility mode for DT booting (appended DTB)

Some bootloaders don't support Device Tree, or old bootloaders

So, a compatibility mechanism was added: `CONFIG_ARM_APPENDED_DTB`
  * tells kernel to look for DTB right after kernel image

No Makefile rule currently to produce such kernel, do this instead:
```sh
cat arch/arm/boot/zImage arch/arm/boot/dts/myboard.dtb > my-zImage
mkimage ... -d my-zImage my-uImage
```

And `CONFIG_ARM_ATAG_DTB_COMPAT` tells kernel to read ATAGS info passed by
bootloader and update DT itself

# Device Tree syntax

Device tree's nodes describe physical devices in a system, and generally
describes device info that cannot be dynamically detected.

!(syntax.png)

```
{
    node@0 {
        // 'node' is the node name
        // The @0 is a unit address, and is generally memory address where the
        // device is mapped, for memory-mapped devices

        // Device tree syntax doesn't impose any specific name of property name
        // or value
        a-string-property "Some String";
        a-string-list = "first","second";
        a-byte-data = [0x01 0x23 0x34 0x56];    // bytestring

        child-node@0 {
                prop2 = <1>;
                ref = <&nodelabel>; // this is also called a 'phandle'
        };
    };

    nodelabel: node@2 {
        empty-property;
        cell-property = <1 2 3 4>;  // Four cells (32 bit values)

        child-node@0 {

        };  // Q. Does this child node refer to same node as the child node of
            // node@0 ?
    };

    leds {...};
};

```

# From source to binary

**Device Tree Source** (DTS) files located in arch/arm/boot/dts:
  * `.dts` - files for board-level definitions  _(The one combiled to DTB)_
  * `.dtsi` - included files, generally containing SoC-level (one SoC is shared
    by multiple boards) definitions

**Device Tree Compiler** (DTC) compiles source to binary:
`scripts/dtc`

To let Make do this, we can edit list of .dtb in arch/arm/boot/dts/Makefile (of
all board that are part of the platform)

.dtsi files - Generally SoC level info

'compatibility' key describes the 'programming model', which helps allow the OS
to identify corresponding device driver (so important)

DMA - ?

```c17
static struct of_device mxs_auart_dt_ids[] = {
    {
        .compatible = "fsl.imx28-auart",
        .data = &mxs_auart_devtype[IMX28_AUART]
    },
    ...
}
```
Ref: drivers/tty/serial/mxs-auart.c

Many functions expect some named properties in the dts, for eg.

* Described by the 'clocks' property
`s->clk = clk_get(&pdev->dev, NULL);`

* Getting IO registers resource, described by 'reg' property
`r = platform_get_resource(pdev, IORESOURCE_MEM, 0);`

etc.

All APIs used by platform drivers to retrieve resources, clocks, irq, etc. all
have device tree support

* Checking some custom property:

  * `struct device_node *np = pdev->dev.of_node;`
  * `if ( of_get_property(np,"fs1,uart-has-rtscts", NULL) )`

# Organisation of a device tree

**Overlay**: device trees also overlay (overwrite the previous one) with other.

**Binding**: specification, that specifies specific types of property and
possible values etc.
`compatible` property describes specific binding(s) to which the node
_complies_. (most-specific first, to least-specific last)
When creating a new device tree representation, a binding should be created that
fully describes the required properties, and values of the device.
 Docs: Documentation/devicetree/bindings

Bindings are design once and should stay forever, so be bit future proof and
allow for two to exist for a while

## Top-level nodes
Typically there top-level nodes are there
* cpus   : sub-nodes describe each CPU in system
* memory : defines location & size of RAM
* chosen : defines 'parameters chosen' or defined by system firmware at boot
  time. One of its use if pass 'kernel command line' (compatible bootloader will
  update this)
* aliases: aliases to some nodes
* buses
* on-board devices


`of_machine_is_compatible("some-compatibility-string")`

```
apbh@8000000 {
    compatibility  "simple-bus";    // a simple memory-mapped bus with no
    specific handling or driver, child nodes registered as platform devices
    #address-cells  <1>;
    #size-cells  <1>;
    reg  <0x8000000 0x3c900>
    ranges;

    ...

}
```

## Interrupt Handling

* `interrupt-controller`: indicates current driver is interrupt controller
* `interrupts`: list of interrupt specifiers
* `interrupt-parent`: phandle pointing to interrupt-controller of current node
* `#interrupt-cells`: number of cells in interrupt specifier for this int contr.

# Example Usage

## Clock examples

## pinctrl binding
pinctrl subsystem allows to manage pin muxing

# General Considerations

* Device Tree is a hardware *description* language, describe the hardware
  layout, and how it works.
* Don't describe configuration, for eg. shouldn't describe in the DT if
  _wanting_ to use DMA or not, just describe if the hardware supports or not

* OS Independent

* Once a Device Tree binding is defined and used in DTBs, it shouldn't be
  changed anymore, only extend. This means the Device Tree bindings become part
  of the kernel ABI

* Keep compatible string to be precise
  For eg. instead of t3xx use t320, since maybe t330 is compatible (in that case
  may use the 't320' compatible string for t330 too), but when t340 it may not
  be compatible.

* Subsystems lacking DT bindings: DRM, audio

Ref: https://www.youtube.com/watch?v=u-2gudXTTTQ

> All addressable device use 'reg' property, a list of tuples representing
> address ranges (address is a 32-bit integer called 'cell'), while length is a
> list of cells or empty (64-bit addressing need 2 cells for each field)
>
> `reg = <addr1 len1 [addr2 len2]...>`


