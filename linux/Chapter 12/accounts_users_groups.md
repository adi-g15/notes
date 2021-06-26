# Identifying current user

* `whoami` -> Current user
* `who` -> Currently logged-on users. Give -a option for more detailed information

# Order of startup files

These startup files are evaluated at shell creation

Is Login Shell ->
* Yes - .bash\_profile -> .bash\_login -> .profile
* No - .bashrc

Recent distros sometimes only have `.bashrc`, rest files just include this

> `alias`, `unalias`

# Users & Groups

Each user also has one or more GID, including _a default one which is same as the user ID_.
UID for normal users start from 1000.
**These numbers are associated with names through the files `/etc/passwd` and `/etc/group`**

> Typing `id` command, gives information about current user

## Adding and Removing users

`useradd` and `userdel`, by default a home directory is setup with basic files copied from /etc/skel/ and adds a line to /etc/passwd like:
```
bjmoose:x:1002:1002::/home/bjmoose:/bin/bash
```

> Adding groups ka bhi tha, mai skip kar diya, neend aa rha hai ab thoda, 2:19 am ho gaya hai...


