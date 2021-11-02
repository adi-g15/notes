> @adig - Always read links i add

## A beast of a different nature

The kernel is coded in GNU C, not strict ANSI C and uses GCC extensions, for eg. inline functions, GCC supports inline functions, thus removing the overhead of invocation and returning.

Kernel memory is not pageable, therefore every byte of memory we consume is one less of available physical memory.

Kernel doesn't generally use floating point operations

Small **pre-processed** (not dynamic) **fixed** size stack: exact size varies by architecture, on x86 it's configured at compile time, and is 4KB or 8KB.
The kernel stack is 2 pages, which generally implies 8KB on 32-bit, and 16KB on 64-bit architecture, this size is fixed.

Concurrency: The kernel has async interrupts, it's preemtive and supports [SMP synchronisation](https://kernelnewbies.org/SMPSynchronisation) and concurrency, the kernel is susceptible to race conditions, unlike a single-threaded userspace process, a number of properties of the kernel allow for concurrent access of shared resources, and requires synchronisation to prevent traces.

## Tracking & Managing processes

Created using fork

Every process assigned a PID

> 'Task' & 'Process' used interchangeably
> There is also a 'Task traced' condition too, when a process is being traced by another process.

## Threads

Linux kernel implements all threads as standard processes.

## Sheduling

> Old sheduling logic: https://web.archive.org/web/20200928200241/https://cs.montana.edu/~chandrima.sarkar/AdvancedOS/CSCI560_Proj_main/index.html

> A good view into new code: https://josefbacik.github.io/kernel/scheduler/2017/07/14/scheduler-basics.html

Official docs: https://www.kernel.org/doc/html/latest/scheduler/index.html

Policy is the behaviour of the sheduler, we should have a good policy for a good design.

Policies:
* I/O bound vs Processor-bound: Give I/O bound process priority
* Priority: High priority (low nice) is preferred
* Timeslice: All processes get a time slice before being preemted

## System call

* In linux, each system call is assigned a number
* syscall
* System call performance is good, due to low context switch times

> We can add our own system call to Linux

