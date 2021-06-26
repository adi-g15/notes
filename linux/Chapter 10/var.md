# /var directory

The /var directory contains files that are expected to change in size and content, as the system is running (var stands for variable)

Some entries -
* /var/log -> System log files
* /var/lib -> Packages and database files
* /var/spool -> Print queues
* /var/ftp -> ftp service
* /var/www -> the HTTP web service
* /var/tmp -> Temporary files

The /var directory maybe put on its own filesystem, so that growth of files, and any exploding filesizes don't fatally affect the system.

