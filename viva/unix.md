
Features of UNIX:-
1) Multiuser capability
2) Multitasking capabilities
3) Portability
4) Hierarchial file structure (top to bottom)
5) Security
6) Communication

UNIX - File system basics

A file system is a logical collection of files on a partion or disk. 
A partition is a container for information and can span an entire hard drive if desired.

Directory structure:-
UNIX uses a hierarchical file system structure, much like an upside-down tree, with root / at the
base of the file system and all other directories spreading from there.

A UNIX file system is a collection of files and directories that has following properties:-
i) I has root directory / that contains other files and directories
ii) Each file or directory is uniquely identified by its name, the directory in which it resides,
    and a unique identifier, typically called an inode
iii) File inode numbers can be seen by specifing the -i option to ls command
iv) It is self contained. There are no dependencies between one file system and any other.

Following are the directories that exist on the major versions of UNIX:-
Directory   	Description        
/		This is the root directory which should contain only the directories needed
               	at the top level of the file structure
/bin 		It contains binary file and execuatble commands
/dev  		It contains input/output device files
/etc  		It contains valid user lists, groups etc.
/home  		It contains account files
/mnt		It is used to other temporary file systems, such as CD-ROM drive and 
                floppy diskette drive  
/boot  		It contains bootable files
/usr  		It contains administrative files/users
/lib  		It contains library files
/temp 		It contains temporary files
/var 		It contains variable-length files such as log and print files
/sbin		It contains binary executable files, usually for system administration. 
       		for example fdisk and ifconfig  utlities.
