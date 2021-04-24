## Start

First he created the stage0.s and Makefile

### stage0.s

```asm

.global start
start:
	xorw %ax, %ax   # @adi-g_note Nautanki ue to bas 0 kar rha tha mai smjha tha code hai :-(

```

First write a bootloader, it's kind of a preloader for the OS, and is a part we can control after the BIOS

First part of it lives on the First sector of the hard disk, ie. first 512 bytes

To get our emulator we will create a disk image, that acts as the hard disk for our OS



To get started with the bootloader, just create an asssembly file that just pauses the sustem

### Creating a disk image

```sh

## Write a couple 100 zeros in a file
dd if=/dev/zero of=boot.iso bs=512 count=2880

# Then take our bootloader, exactly 512 bytes in size and toss it right at the start
dd if=./bin/${BOOTSECT} of=boot.iso conv=notrunc bs=512 count=1

```

### Back to making

Then the first productive thing was... writing a bare metal hello world

Ie. print something on the screen, all this was done in binary
And used a BIOS interrupt we printed soemthing

Then, first priority was to get C running, so to write further code in C


Then what bootloader was doing is take anything after a particular location and run, no checks no anything, so safe :D 


We put the C code on the next sector following the bootloader, and the bootloader will run it no problem..


Then problem, the code is 16-bit... :-(
All x86 processors boot in legacy 16-bit mode, for backward compatibility

If you want to write any software after 1978, or want to use more than 64 KB of memory ! You would want to enter higher but modes

But for this, setting up a gdt and idt

also enabling a20 line, so we can use all of our memory


### The fancy instruction

```asm

ljmp $0x8, $((0x07C0 << 4) + entry32)

```

Takes the jump to a high level language ! ie. C

Now,...

first thing with C,... set the VGA memory to print message

### Writing our graphics driver

Using the same interrupt hex 10 from earlier , with Ah register set to 0 this time, we can request the BIOS to configure different modes, like a 320x200 pixel and a 8 bit color pallet

Pallete tester tried out

... Now... 

To get some animation or consistent motion, we need something like a clock or a timer

To do this, we need INTERRUPTS, ie. we need an IDT, a big list to tell the processor how to handle an interrupt

PROGRAMMABLE INTERRUPT TIMER -> PIT
Cruises along at precisely 1.193192 MHz

Related code in timer.h and util.h

NOW>>> the demo is moving

## Drawing text on the screen

Since we don't have a filesystem here, so we need to hardcode our font directly in binary

... search "gib font now", you get 8 by 8 font, on stackovetflow, that;s our font data

To use this, we do some bit fiddling, a font defined by 8 numbers for each glyph, so 8 by 8 bits

```c

void font_char(char c, size_t x, size_t y, u8 color) {
	
	u8 *glyph = FONT[(size_t) c];

	for (size_t yy = 0; yy < 8; ++yy) {
		for (size_t xx = 0; xx < 8; ++xx) {
			if(glyph[yy] & (1 << xx)) {
				screen_set(color, x + xx, y + yy);
			}
		}
	}

}

```

Successfully printed...


A problem... while using directly modified VGA buffer memory, it can cause the graphic's driver's buffer and what's on screen to go out of sync, to solve this what we do is an AGILE technique called Double Buffering, ie. having two buffers a front and a back buffer

Then again, after implementing this... we print a block on the screen

Also, we can't make any sprites in an image editor, so it is hard coded/ generated at runtime


After some tetris stuff, successfully configuring rotations of the blocks too...

Unfortunately, here we go again,

ab humko keyboard se imput bhi chahiye, matlab more os stuff...

After game was done...











AB CHAHIYE MUSIC!

So, we created a quick driver for the PC speaker

It didn't work, so created a modern driver, ... for a 1997 SoundBlaster


To create the sound, it used some sin waves cos waves etc.



