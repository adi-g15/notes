# ps (System V style)

`ps` provides info about currently running processes, with PID.

### Options

* Without options -> it displays all processes **running under current shell**.
* `-u`  -> processes for specified username
* `-ef` -> **all processes** in system in full detail
* `-eLf`  -> also displays one extra line for each thread

# ps (BSD style)

It has another style of option specification, which stems from the BSD variety of UNIX, where, options dont' have preceding dashes.

### Options

* `axo` -> User defined format specifier (allows you to specify which attributes to show)
* `aux` -> Also prints user, and other details

# pstree -> The Process Tree

This command displayes running processes in form of a tree diagram

# top

Also highlights resource consuming processes.

### First line of `top`:

* uptime of system
* number of logged in users
* load average

### Second line of `top`:

* Tasks: 
  * Number of processes
  * Running, Sleeping, Stopped & Zombie

### Third line of `top`

* CPU Usage & How it's divided
  * Division between users (us) and kernel (sy) (for the most part this is in handling system calls), displaying percentage of CPU time used for each
  * (ni) -> percentage of user jobs running at lower priority (most nice processes)
  * (id) -> idle mode, should be low if load avg is high, and vice versa
  * (wa) -> waiting for I/O
  * (hi) -> hardware interrupts
  * (si) -> software interrupts
  * (st) -> `Steal time`, generally used with virtual machines, which has some of idle CPU time taken for other uses

### Fourth & Fifth line of `top`

* RAM & Swap

## Process Lise of output

* `PID` -> Process Identification Number
* `USER` -> Process owner
* `PR` & `NI` -> Priority & Nice value
* `VIRT` (virtual), `RES` (physical) and `SHR` (shared) memory
* `S` -> Status
* `CPU` * `MEM`
* `TIME+` -> Execution time
* `COMMAND`

## Commands

* t - Display/Hide summary (2nd & 3rd lines)
* m - Distlay/Hide memory (4th & 5th lines)
* A - Sort by top resource consumers
* r - renice (change priority of specific process)
* k - kill process
* f - configuration screen of top
* o - Interactively select new sort order


