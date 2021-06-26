## Components of CUPS

* Configuration files
* Scheduler
* Job files
* Log files
* Filter
* Printer drivers
* Backend

![How CUPS work](https://courses.edx.org/assets/courseware/v1/28c1710704f1ec7b7ccd6077c7aa31f4/asset-v1:LinuxFoundationX+LFS101x+1T2020+type@asset+block/LFS01_ch13_screen_05.jpg)

## Sheduler

Manages print jobs, handles admin commands, allows querying printer status, manages flow of data through all CUPS components.

## Configuration files

The two main config files are `cupsd.conf` and `printers.conf`.

* `cupsd.conf` -> system-wide config; no printer-specific details. **Most of these settings relate to network security**, ie. which systems can access CUPS network capacbilities, how printers are advertised on the local network.

* `printers.conf` -> contains printer-specific settings. For every printer connected, a section describes the printer's status and capabilities. This file is generated or modified only after adding a printer to the system, and **SHOULD NOT BE MODIFIED BY HAND**.

## Job files

CUPS stores print requests under `/var/spool/cups` directory.

Do a `ls -l /var/spool/cups`, the files prefixed with `d` are **data files**, and those prefixed with `c` are **control files**.

## Log Files

Placed under `/var/log/cups`, and used by sheduler to record activities that have taken place.
Include access, error and page records.

## Filters, Printer Drivers, Backends

* Filters: CUPS uses **filters** to **convert job file formats to printable formats**.
* Printer drivers: contains descriptions for printers, usually stored under /etc/cups/ppd.
* Backend: The print data is send to the printer _through a filter_ and **via a backend** to help locate the connected **device**.

> 'gutenprint' is a famous printer driver, works for many

### Working of CUPS
> Whole copied

1. When you execute a print command, the scheduler validates the command and processes the print job, creating job files according to the settings specified in the configuration files.
2. Simultaneously, the scheduler records activities in the log files.
3. Job files are processed with the help of the filter, printer driver, and backend, and then sent to the printer.

# Printing from CLI

> Can be help for automating printing or when printing through scripts

CUPS provides two cli interfaces, descended from System V and BSD flavours of UNIX.

Use `lp` (System V) or `lpr` (BSD).
Can be used to print text, pdf, image files, etc.

> `lp` is just a CLI frontend to `lpr`, that passes input to lpr.

## Commands

* `lp <filename>` -> Print the file to default printer
* `lp -d printer <filename>` -> Print to specific printer
* `echo string | lp` -> Print output of command

* `lp -n 10 <filename>` -> Print multiple copies
* `lpoptions -d printer` -> Set default printer

* `lpq -a` -> Show queue status
* `lpadmin` -> Configure printer queues

> `lpoptions` can also set other options, such as printer options

> Example
> lp -d hp-laserjet test1.txt
> lpoptions -d hp-laserjet

## Managing Print Jobs

* `lpstat -p -d` -> Get list of available printers, and status
* `lpstat -a` -> Status of all connected printers
* `cancel jid` or `lprm jid` -> cancel a print job
* `lpmove jid otherprinter` -> move print job to other printer
