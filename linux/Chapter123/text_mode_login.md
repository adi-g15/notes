## Text Mode Login

> Chapter 3: The Boot process

Near the end of the boot process, **init** starts a number of text-mode login prompts. These enale you to type your username, followed by your password, and to eventually get a command shell.
However, if your are running a system with graphical interface you will not see these at first.

The terminals which run the command shells can be accessed using the `ALT key` + `a function key`.

Most distros start 6 text terminals, and 1 graphical terminal starting with F1 or F2.

Within a graphical environment, switching to a text console requires pressing `Ctrl`+`Alt`+`a function key`. (with F7 _or_ F1 leading to the GUI)

Usually the default command shell is GNU **bash** (Bourne Again Shell), though other advanced command shells available.
1. The shell prints a text prompt, indicating it's ready to accept commands,
2. After the user types a command, and presses Enter, the command is executed
3. Another prompt is displayed after the command is done

![](https://courses.edx.org/assets/courseware/v1/e35bea5a8c6b9a41453a0e01c5ca3077/asset-v1:LinuxFoundationX+LFS101x+1T2020+type@asset+block/LFS01_ch03_screen26.jpg)

