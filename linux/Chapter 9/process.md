# Process

> It calls a 'non-responding' state, is also called a 'runaway' process

A process is simply an **instance of one or more related task (threads) executing on your computer**.

> NOTE- **It is not the same as a program or a command**, as a single command may actually start several processes simultaneously.

Some processes are independent, some are related to others. So failue of one may or may not affect the other.

## Resources

Processes use many system resources, such as
* Memory
* CPU cycles
* Peripheral devices (eg. network cards, hard drives, printer, display)

The OS (especially the Kernel) is responsible for allocating a proper share of these resources.

## Process Types

A terminal window (_a kind of command shell_) is a process that runs as long as needed. It is used to execute programs and access resources in an interactive environment.

We can also run programs in background (**which means they are detached from the shell**)

Process Types -
* Interactive - Need to be started by user (either by command or GUI, eg. Firefox)
* Batch - Automatic processes which are sheduled from and then disconnected from the terminal (these are queued and work on a **First In First Out** basis, eg. updatedb, ldconfig)
* Daemons - Sever processes that run continuously (eg. https, sshd, libvirtd)
* Threads - Lightweight processes. These are tasks that run under the umbrella of a main process. Many non-trivial programs are multi-threaded (for eg. firefox, gnome-terminal-server)
* Kernel threads - Users neither start nor terminate, and have little control over these.
  Perform actions like, moving a thread from one CPU to another, making sure IO operations to disk are completed (eg. kthreadd, migration, ksoftirqd)

#### States

I didn't write part I know, or read many times.

> Sometimes, a child dies, but its parent hasn't asked about its state. Amusingly, such a process is said to be in a zombie state; it isn't really alive, but still shows up in system's list fo processes.

## Process and Thread ID

* PID - The OS keeps track of them by assigning each process a unique Process ID (PID)

* PPID - Parent Process ID; process that started this process. If the parent dies, the PPID will refer to an adoptive parent, on recent kernels, this is the `kthreadd` which has PPID=2

* TID - Thread ID, same as PID for single-threaded processes.
  For multi-threaded processes, each thread has same PID but has a unique TID

### Terminating a Process

When process stopped working properly, to terminate a process, can type `kill -SIGKILL <pid>` or `kill -9 <pid>`


