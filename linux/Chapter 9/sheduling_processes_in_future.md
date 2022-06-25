# at

The `at` utility program used to execute any non-interactive command at a specified time.

> Note: Not installed in the base packages in arch

For eg.
```sh
$ at now+2 days
at> cat file1.txt
at> <EOT>
job 3 at 2021-06-20 11:58
```

> Command gives time to run
>
> Then we enter the command specifying the task to perform
>
> To end input, hit Ctrl+D (signals EOF or EOT here)

# cron

`cron` is a time-based scheduling utility program.

Very easy to schedule tasks, by just editing a `crontab` file; There are both system-wide crontab (`/etc/crontab`) files and user-based ones.

Typing crontab -e  will open the crontab editor to edit existing jobs or to create new jobs. Each line of the crontab file will contain 6 fields

MIN 	Minutes 	0 to 59
HOUR 	Hour field 	0 to 23
DOM 	Day of Month 	1-31
MON 	Month field 	1-12
DOW 	Day Of Week 	0-6 (0 = Sunday)
CMD 	Command 	Any command to be executed

Examples:

* The entry `* * * * * /usr/local/bin/execute/this/script.sh` will schedule a job to execute script.sh every minute of every hour of every day of the month, and every month and every day in the week.
* The entry `30 08 10 06 * /home/sysadmin/full-backup` will schedule a full-backup at 8.30 a.m., 10-June, irrespective of the day of the week.

