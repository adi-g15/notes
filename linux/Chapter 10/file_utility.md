# Using the `file` utility

In Linux, a file's extension is generally not much meaningful to the system itself, like in Windows does (for eg. any '.exe' file represents an executable binary file).

In fact, most applications directly examine a file's contents to see what kind of object it is rather than relying on extension.

`file` - The real nature of a file can be ascertained by using the `file` utility.
It examines the content and certain characteristics to determine whether the files are plain text, shared libraries, executable programs, scripts, etc.

> On my system, it shows a .rs file as C source too. Though it really is good, can distinguish between C & C++ source too

> From a lab exercise -> dd cannot only copy directly from raw disk devices, but from regular files as well. Remember, in Linux, everything is pretty much treated as a file. dd can also perform various conversions. For example, the conv=ucase option will convert all of the characters to upper-case characters. We will use dd to copy the text file to a new file in /tmp while converting characters to upper-case, as in: student:/tmp> dd if=/tmp/group of=/tmp/GROUP conv=ucase.

