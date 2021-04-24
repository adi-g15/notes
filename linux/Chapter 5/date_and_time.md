## Date & Time

By default, Linux always uses Coordinated Universal Time (UTC) _for its own internal timekeeping_.

Displayed or stored time values rely on the system time zone setting to get the proper time.

> UTC is similar to, but more accurate than, Greenwich Mean Time (GMT).

## Network Time Protocol (NTP)

NTP is the most popular and reliable protocol for setting the local time by consulting established Internet servers.
Linux distributions always come with a working NTP setup, which refers to specific time servers run or relied on by the distribution.

Configuration file - `/etc/ntp.conf`
