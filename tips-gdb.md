# TUI

Toggle: Ctrl-x + a/A/Ctrl-a, `tui enable`, or directly start with `gdb -tui`
Toggle through disassembly/registers in split window: Ctrl+x2

Toggle through split windows (including the gdb prompt window, register split
window, code split window): Ctrl-x + o

Previous command: Ctrl+P
Next command: Ctrl+n

There are many more commands, eg. for creating new window layout etc.

Can also use `termdebug` feature of neovim to use https://alpha2phi.medium.com/neovim-for-beginners-terminal-debugger-77e48428378d

# Python interpreter

> gdb has a python interpreter

```sh
(gdb) python
>import os
> print ('I am running on pid %d' % os.getpid())
> end
(gdb) python gdb.execute('n')
(gdb) python bp = gdb.Breakpoint('hello.c:9')
(gdb) python bp.enabled  = False
(gdb) python bps = gdb.breakpoints()
(gdb)
(gdb) python help(gdb)          # will explain all methods/variables in gdb module
```

# Shell

```
(gdb) shell ps
```

# Pretty Print

(gdb) set print pretty on

## Python Pretty Printers

> Python code, `pretty.py`

> Steps:
> 1. Create the prettyprinter class, with 3 methods: `_init_`, `to_string`,
>    `display_hint`, all take a self argument, except `_init_` also gets a `val`
>
> 2. Create gdb.printing.RegexpCollectionPrettyPrinter object
>
> 3. Add the pretty printer class for a regex to the gdb pretty printer object that
>    will handle it
>
> 4. `gdb.printing.register_pretty_printer`

```python3
import gdb.printing

class StudentPrinter(obj):
	"Pretty print a student object"

	def _init_(self, val):
		self.val = val

	def to_string(self):
		print("We can print something and/or return the next line")
		return ("id: %i, name=%s dob='%d/%d'" % self.val['id'], self.val['name'],
		self.val['dob']['tm_mday'], self.val['dob']['tm_year'])

	def display_hint(self):
		return 'student'

printer = gdb.printing.RegexpCollectionPrettyPrinter('student')
printer.add_printer('student', '^student$', StudentPrinter)

gdb.printing.register_pretty_printer(gdb.current_objfile(), printer)
```

> In gdb, just source this file

```gdb
(gdb) source pretty.py
(gdb) p some_obj
```

> For STL, and some other libraries, there are already default pretty printers,
> for example, the iterators. These might be there added by the distro

# 'Examine' command

Command: `x`

When we print something such as with `print $pc`, the output will be like
`$1 = (void(*)()) 0x5a452389`

Then, we can do `x $1` to examine that address, and know the instruction at that
address, or something like that

# Reversible Debugging

> sizeof arr will return in bytes, ie. for an int array, it might return
> `4*length_of_array`

Sometimes even the coredump stack trace becomes invalid, due to buffer overflow
or similar problems, say, there is an array on stack, and the return address is
generally put to the top of the stack, but if we access a wrong index in the
array, it might modify that return address itself, and so after crashing, since
the instruction pointer will be invalid, the backtrace shown will also be
incomplete and problematic.

> @ref: https://www.youtube.com/watch?v=-n9Fkq1e6sg, timestamp: 40:20

> Starting gdb with a coredump: `gdb -c coredump`... earlier gdb versions
> required executable name, but since that name is included in the coredump
> file, so we don't need that now

For this gdb supports `record` command, it record the inferior on a instruction
by instruction internally, and then we can go back in history with
`reverse-stepi`, ie. step back one machine instruction (i). That way even if the
backtrace was problematic, moving back in history can get us to a valid location

Can manually run the commands: `run`, `continue` and wait for it to complete or
crash to go back in history with `reverse-stepi` (reverse - step - instruction)

## Steps for automating recording on infinite runs until failure

1. Setup breakpoints, eg. at `main` and `_exit`.
2. Use `command` command to add list of commands to run when a breakpoint is
   hit, eg. `command 3` (3 being breakpoint at `main`), add `record`, `continue`,
   `end` (or Ctrl+D), and `command 4` (4 begin breakpoint at `_exit`), add
   `run` and `end` (or Ctrl+D)

# Hardware breakpoints on expressions

Instead of just value of a memory address, we can add breakpoint on expression
too, to be a bit more smart... eg `watch *(long**)0x7fff5a452389`, instead of
`watch -l *(long**)0x7fff5a452389` or `watch -l *(long**)$sp`

# `.gdbinit`

```gdb
set history save on
set print pretty on
set pagination off
set confirm off
```

> Putting `run` command in gdbinit or making it too complex may some years later
> be a cause of problem if i run into a gdb issue, and trying to debug

> The rest of the things after this have not been discussed in the video, just shown slides

# Remote Debugging

Debug over serial/sockets to a remote server

Start `gdbserver localhost:2000 ./a.out`

Then in your gdb, run `target remote localhost:2000`

# Multiprocess Debugging

Can debug multiple 'inferiors' simultaneously

Add new inferiors

Follow fork/exec

```gdb
set follow-fork-mode child|parent
set detach-on-fork off

info inferiors

inferior N
set follow-exec-mode new|same
add-inferior <count> <name>
remove-inferior N
clone-inferior
print $_inferior
```

# Non-stop mode

Other threads continue while you're at the prompt

```gdb
set non-stop on
continue -a
```

> Make sure pagination is off in this case, otherwise bad stuff happens (not my
> words @adi)

# Breakpoints and watchpoints

```gdb
watch foo   # stop when foo is modified
watch -l foo  # watch location
rwatch foo  # stop when foo is read
watch foo thread 3  # stop when thread 3 modifies foo
watch foo if foo > 10   # stop when foo is > 10
```

> Last is actually a good thing, i found some days ago by chance

> Software watchpoints are slow, sometimes we want to actually set hardware
> watchpoints, say instead of `watch array` (software breakpoint) do
> `watch array[0]` (hardware breakpoint)

# debuginfod

> This I found from reading patches to gdb-patches mailing list
>
> "Aaron Merey", "Tom Tromey" seem like major contributors with write access (gdb)
>
> "Aaron Merey" is contributing good ground level changes to debuginfod

By default, at beginning gdb may attempt to download debuginfo for all shared
libraries associated with process or core file being debugged.
This wastes time and space by downloading things we might not use during the
session.
A patch by Aaron Merey implements on-demand/lazy debuginfo downloading, to use
it:

```
set debuginfod enabled lazy
```

> @ref: https://www.youtube.com/watch?v=Rudz-uSdWHM

## Attaching to process

Say we have started the program and it is misbehaving, so instead of ending and
starting again in debugger (in this case the bug might not even show up next
time):

```sh
some-program
pgrep some-program

sudo gdb
```

```gdb
(gdb) attach <PID-of-'some-program'>

(gdb) detach
```

After `attach`, the process is paused, and will now be controlled by gdb, so we
can debug

After `detach`, the process simply resumes

# Saving breakpoints

Note that if program is changed, the breakpoints when restored might not be what
I want

Saving: 

```gdb
(gdb) save breakpoints bt.txt
```

Restoring: 

```gdb
(gdb) source bt.txt
```

## Changing to arbitrary frame

```
frame 4
```

# `gcore`

Generate a coredump of a program in execution

```gdb
(gdb) gcore mycoredump
```

Usecase: If you are debugging something late at night, just create a coredump
and continue debugging later morning

# Checkpoints

VERY VERY VERY useful feature.

What it does is basically clone the process by `fork`ing it, and then later try
it.

Usecase: When we have to try multiple things from a point onwards, instead of
ending and starting the gdb session/process again, we can just restart from that
common point

```
checkpoint

info checkpoints

restart 1 (checkpoint_id)
```

# Separate debuginfo file

Usecase: When releasing a proprietary software, you don't want to include debug
info when sending to client

```sh
# Compile program with debuginfo
gcc -g main.c

# Copy debug info to a separate file
objcopy --only-keep-debug a.out main.dgb

# Strip debug info from program
objcopy --strip-debug a.out
```

Then load inside gdb with:

```gdb
(gdb) symbol-file main.dbg
```

# Remote debugging

Usecase: client encountered issue, dev can remotely debug

On the server, start the gdbserver:

```sh
gdbserver <IP>:<PORT> a.out
```

On your system:

```gdb
(gdb) target remote <IP>:<PORT>

(gdb) symbol-file main.dbg
```

# Tracing

Set tracepoints, letting the program run instead of pause (which happens in case
of breakpoints)

> NOTE: Official gdb doc says that this is not supported as of now by any of
> stubs (for remote debugging) provided with gdb

Usecase: sometimes some bugs are time dependent, and might not show the bug if
paused and resumed

```gdb
(gdb) target remote <IP>:<PORT>

(gdb) trace main.cpp:10

(gdb) actions
>collect $regs
>end

(gdb) tstart
(gdb) continue
```

## Setting breakpoint programatically

Search for "Set breakpoint in C or C++ code programatically for gdb on Linux" on
StackOverflow, basically.

```c
#include <signal.h>
raise(SIGINT)
```

or

> but some person said SIGTRAP didn't work reliably for him

```c
raise(SIGTRAP)
```

or

```asm
asm("int $3")
```

# Ignoring/handling signals

While debugging crash tool, gdb will stop at many times due to some SIGTTOU
signal from different gdb worker threads.

Ignore them using:

```gdb
signal SIGTTOU nostop

// or

handle SIGTTIN nostop
```

