# User Accounts

### User IDs

* UID 0 -> reserved for `root`
* UID 1-99 -> other predefined accounts
* UID 100-999 -> system accounts and groups

* UID 1000-... -> normal users

## Types of Accounts on Linux

1. root
2. system
3. normal
4. network

> `last` command shows last time each user logged in

## "Run as"

SUID (Set owner User ID upon execution - similar to the Windows "run as" feature) is a special kind of file permission given to a file. Use of SUID provides temporary permissions to a user to run a program with the permissions of the file owner (which may be root) instead of the permissions held by the user.

For eg. executing programs such as `passwd` is Running SUID-root applications

# sudo

A message like this is saved to a system log file (usually /var/log/secure), when failed to execute "sudo bash" without successfully authenticating the user:

```log
authentication failure; logname=op uid=0 euid=0 tty=/dev/pts/6 ruser=op rhost= user=op
conversation failed
auth could not identify password for [op]
op : 1 incorrect password attempt ;
TTY=pts/6 ; PWD=/var/log ; USER=root ; COMMAND=/bin/bash
```

> Mere lappy pe /var/log/secure nahi tha :(

## The sudoers file

Whenever **sudo** is invoked, a trigger will look at `/etc/sudoers` and the files in `/etc/sudoers.d/` if the user can use sudo, and what is the scope of their privilege.

> TIP: Prefer adding a file in /etc/sudoers.d with your username, instead of editing the master configuration file (/etc/sudoers)

> **visudo** -> It ensures that only 1 person is editing that file, has proper permissions, and before saving it also checks if there are syntax errors.
>
> visudo -f /etc/sudoers.d/adityag

### Command Logging

By default, sudo commands and any failures are logged in /var/log/auth.log under the Debian distribution family, and in /var/log/messages and/or /var/log/secure on other systems.

> I have NONE of them on my arch :(

# Hardware Access

Linux limits user access to **non-networking** hardware devices in similar manner to files.

> root can read and write to the disk in a raw fashion,
>
> for eg. even this is possible
>
> ```sh
> echo "namaste aditya" > /dev/sda
> ```

# Password ageing and strength check 

There are tools like `chage` to remind about old passwords that should be changed.

There are tools likes, the **PAM** (Pluggable Authentication Modules) to check whether typed password is strong enough.

> The passwords in /etc/shadow are SHA-512 hashed

# Securing the boot process and Hardware

There are more ways to ensure safety like, setting BIOS and bootloader passwords, working on secure networks, protecting your keyboard from tampering to prevent keylogging from this side, etc. etc.
