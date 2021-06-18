# Process Priorities

> The 'nicer' the program, the 'lower' the priority (this convention dates back to earliest days of UNIX)

The priority for a process can be set by specifying a **nice value** for the process. The lower the nice value, the higher the priority. Lower values are assigned to important processes, while high nice value processes simply allow others to be executed first.

In Linux, nice values range from -20 to +19. Where **-20 is LEAST NICE, so higher priority**, and **+19 is MOST NICE, so least priority**

### Real-time priority

We can also assign a so called **real-time priority**, to time-sensitive tasks, such as controlling machines through a computer, or collecting incoming data.

> DONT CONFUSE WITH "HARD REAL-TIME", where there is a well-defined time window to make sure a job gets completed within.

## Seeing priorities

Run `ps lf`, see the **NI** value (Nice value)

Using **renice** to change NICE value,
```sh
ps lf # See previous state

renice +5 PID    # Set nice value of Process ID to +5

ps lf	# See the difference, also see that the NICE value of this child command, IF the process ID was of bash, or whatever shell that was running
```

Say, if i change nice value of `bash` from 0 to +5, then later commands (child processes) will also have this NICENESS value)

> NOTE - WE CAN'T DECREASE THE NICE VALUE (ie. we can't increase the priority of a process, we MUST BE root for that)

GUI like 'gnome-system-monitor' show NICENESS of -5 as High priority, 0 as normal, and +5 as Low
