* I am not writing everything, just new things

> Ref: https://trainingportal.linuxfoundation.org/learn/course/a-beginners-guide-to-linux-kernel-development-lfd103/building-and-installing-your-first-kernel/building-and-installing-your-first-kernel?page=4

## Trim down kernel modules

> I can't say if this is before or after oldconfig, or it will override it completely

```sh
lsmod > my-old-lsmod
make LSMOD=my-old-lsmod localmodconfig
```

## Looking for regressions and new errors

Save logs from current kernel to compare and look for regressions and new errors, if any.
dmesg with `-t` option generates logs without timestamps

```sh
dmesg -t > dmesg_current
dmesg -t -k > dmesg_kernel
dmesg -t -l emerg > dmesg_current_emerg
dmesg -t -l alert > dmesg_current_alert
dmesg -t -l crit > dmesg_current_crit
dmesg -t -l err > dmesg_current_err
dmesg -t -l warn > dmesg_current_warn
dmesg -t -l info > dmesg_current_info
```

NOTE: If the dmesg_current is zero length, it is very likely that secure boot is enabled on your system. When secure boot is enabled, you won’t be able to boot the newly installed kernel, as it is unsigned. You can disable secure boot temporarily on startup with MOK manager. Your system should already have mokutil.

## Secure Boot

Required to install `mokutil` on Arch Linux

```sh
mokutil --sb-state
```

If you see the following, you are all set to boot your newly installed kernel:

SecureBoot disabled
Platform is in Setup Mode

If you see the following, disable secure boot temporarily on startup with MOK manager:

SecureBoot enabled
SecureBoot validation is disabled in shim

Disable validation:

```sh
doas mokutil --disable-validation
root password
mok password: 12345678
mok password: 12345678
doas reboot
```

To enable validation again, it is `doas mokutil --enable-validation`

Ref: https://askubuntu.com/questions/1119734/how-to-replace-or-remove-kernel-with-signed-kernels

## Early Printing

Enable printing early boot messages to vga using the `earlyprintk=vga` kernel boot option.

## Creating a Patch

Clone linux_mainline: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/

Create your branch, find driver to modify, use `git grep`, it's useful. eg. `git grep uvcvideo -- "*Makefile"` (btw, uvcvideo is a **USB Video Class** media driver, for video input devices.

* After recompiling modules, modules can be loaded without rebooting :) (I think only when kernel versions are same)

## checkpatch.pl

* Checks for coding style compliance
* Spelling errors
* Prompts for adding new files to MAINTAINERS files
* Checks mismatched "from" and "author" email addresses
* Does NOT check if patches will be applied successfully

* Sometimes may ignore it's suggestion too, end goal is for code to be more readable
* if a line is 81 characters long, but breaking it makes the resulting code look ugly, don't break that line.

## Get Maintainer

```sh
./scripts/get_maintainer.pl drivers/media/usb/uvc/uvc_driver.c
```

Example output:
```
Laurent Pinchart <laurent.pinchart@ideasonboard.com> (maintainer:USB VIDEO CLASS)
Mauro Carvalho Chehab <mchehab@kernel.org> (maintainer:MEDIA INPUT INFRASTRUCTURE (V4L/DVB))
linux-media@vger.kernel.org (open list:USB VIDEO CLASS)
linux-kernel@vger.kernel.org (open list)
```

While sending patch for review, the mailing lists are on **CC**, and rest are on the "To" list when patch is sent

### Generating a patch to send

```sh
git format-patch -1 <commit-id> --to=aurent.pinchart@ideasonboard.com --to=mchehab@kernel.org --cc=linux-media@vger.kernel.org --cc=linux-kernel@vger.kernel.org
```

## Review process

* Patch will get comments from reviewers with suggestions for improvements and, in some cases, learning to know more about the change itself.
* Wait for a minimum of one week before requesting a response. During merge windows and other busy times, it might take longer than a week to get a response.
* Make sure you sent the patch to the right recipients.
* Thank reviewers for their comments and address them.
* Don’t hesitate to ask a clarifying question if you don’t understand the comment.

* When you send a new version of your patch, add version history describing the changes made in the new version. The right place for the version history is after the "---" below the Signed-off-by tag and the start of the changed file list. Everything between the Signed-off-by and the diff is just for the reviewers, and will not be included in the commit. Please don’t include version history in the commit log.

* As a general rule, don't include change lines in commit log... but I saw one in subsequent versions of patches.

* When working on a patch based on a suggested idea, make sure to give credit using the Suggested-by tag. Other tags used for giving credit are Tested-by, Reported-by.

* If you don't hear any response back from the maintainer after a week, feel free to either send the patch again, or send a gentle "ping" - something like "Hi, I know you are busy, but have you found time to look at my patch?"

* Stay engaged and be ready to fix problems, if any, after the patch gets accepted into linux-next for integration into the mainline.

* When a patch gets accepted, you will either see an email from the maintainer or an automated patch accepted email with information on which tree it has been applied to, and some estimate on when you can expect to see it in the mainline kernel.

## Cover letters

When sending multiple related patches.

This is useful for grouping, say, to group driver clean up patches for one particular driver into a set, or grouping patches that are part of a new feature into one set. git format-patch -2 -s --cover-letter --thread --subject-prefix="PATCH v3" --to= “name” --cc=” name” will create a threaded patch series that includes the top two commits and generated cover letter template. It is a good practice to send a cover letter when sending a patch series.

Including patch series version history in the [cover letter](https://lkml.org/lkml/2019/9/17/657) will help reviewers get a quick snapshot of changes from version to version.

## Suggested Git Post-Commit

`.git/hooks/post-commit`. If already existing file, then that can be renamed to post-commit.sample. git doesn't execute hooks with .sample at end

```bash
#!bash
#!/bin/sh
exec git show --format=email HEAD | ./scripts/checkpatch.pl --strict --codespell
```

```sh
# Make sure the file is executable
chmod a+x .git/hooks/post-commit
```

## Partial compilation

Compiling single file or directory:

```sh
make <file-or-directory-path>
```

Compiling single module, use `M=` option:

```sh
make M=drivers/media/test-drivers/vimc
```

NOTE: Sometimes, it is hard to figure out all the dependencies for a module, or a driver, or a configuration option. Until all the dependencies are enabled, the driver you are looking to enable will not be enabled.

To know dependencies, look at the `Kconfig` file in that directory

## Kernel CI

* [Kernel CI Dashboard](https://kernelci.org/)
* [0-Day - Boot and Performance issues](https://lists.01.org/hyperkitty/)
* [0-Day - Build issues](https://lists.01.org/hyperkitty/)
* [Linaro QA](https://qa-reports.linaro.org/lkft/)
* [Buildbot](https://kerneltests.org/)

## Applying Patches

```sh
patch -p1 < file.patch
```

> OR

```sh
git apply --index file.patch
```

Main difference is in treatment of new files in patch, as when done with patch command, git will treat that file as untracked

## dmesg

As a general rule, there should be NO new **crit**, **alert** and **emerg** level messages in dmesg.

```sh
dmesg -t -l {emerg,crit,alert,err,warn}
```

```sh
dmesg -t -k
```

> `-t` is to show without timestamps

> NOTE: Are there any stack traces resulting from WARN_ON in the dmesg? These are serious problems that require further investigation.

Another way to find regressions is: Stress Testing, running multiple kernels simultaneously is a good test `time make all`, increased time may show some kernel module has performance regressions.

## Debug Options and Proactive testing

Important debug options:

```
CONFIG_KASAN
CONFIG_KMSAN
CONFIG_UBSAN
CONFIG_LOCKDEP
CONFIG_PROVE_LOCKING
CONFIG_LOCKUP_DETECTOR
```

Debugging:

[Debugging Analysis of Kernel panics and Kernel oopses using System Map](https://sanjeev1sharma.wordpress.com/tag/debug-kernel-panics/)

https://www.opensourceforu.com/2011/01/understanding-a-kernel-oops/

OOPS are due to the Kernel exception handler getting executed including macros such as BUG() which is defined as an invalid instruction. Each exception has a unique number. **Some “oops”es are bad enough that the kernel decides to execute the panic** feature to stop running immediately. This is a kernel crash optionally followed by invoking a panic.

## `decode_stacktrace`


Decode and Analyze the Panic Message

Panic messages can be decoded using the decode_stacktrace.sh tool. Please refer to decode_stacktrace: make stack dump output useful again for details on how to use the tool.

Usage:
      scripts/decode_stacktrace.sh -r <release> | <vmlinux> [base path] [modules path]

Save (cut and paste) the panic trace in the dmesg between the two following lines of text into a .txt file.

```
------------[ cut here ]------------
---[ end trace …. ]---
``` 

## Using Event Tracing to Debug

Using access to `/sys/kernel/debug`

[Event Tracing page in the Linux Kernel Documentation](https://www.kernel.org/doc/html/latest/trace/events.html)

```
An example usage is if you are debugging a networking problem, you can enable available events for that area. You can read up on how to use event tracing to get insight into the system. The file /sys/kernel/debug/tracing/available_events lists all the events you can enable. You will see several directories:sched, skb and many others in the /sys/kernel/debug/tracing/events directory.

You will see a file called enable under each of these directories and in the /sys/kernel/debug/tracing/events. These directories correspond to kernel areas and trace events they support. These events can be enabled at runtime to get insight into system activity. If you want to enable all skb events:

Enable all events:
      cd /sys/kernel/debug/tracing/events
      echo 1 > enable 

Enable the skb events:
      cd /sys/kernel/debug/tracing/events/skb
      echo 1 > enable

Before you run your reproducer, enable areas of interest one at a time. You can determine areas of interest based on the call trace. Run the reproducer. You can find the event traces in /sys/kernel/debug/tracing/trace.
```

Tip: Use `pr_debug` or `dev_debug` as it's a good way to gather information. BUT, avoid adding additional messages and enabling event tracing when debugging a time-sensitive problem.

Additional Resources:
* https://www.kernel.org/doc/html/latest/admin-guide/bug-hunting.html
* https://www.kernel.org/doc/html/latest/admin-guide/bug-bisect.html
* https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html

### Visualising contributors

https://cregit.linuxsources.org/

Or, may use `git gui` too

## How does one become a maintainer ?

Some paths:

* Write a new driver.
* Adopt an orphaned driver or a module (Hint: Check the MAINTAINERS file).
* Clean up a staging area driver to add it to the mainline.
* Work towards becoming an expert in an area of your interest by fixing bugs, doing reviews, and making contributions.
* Find a new feature or an enhancement to an existing feature that is important to the kernel and its ecosystem.
* Remember that new people bringing new and diverse ideas make the kernel better. We, as a community, welcome and embrace new ideas!

### Helpful scripts

> All Credits: Shuah Khan

pre_compile_setup.sh: Download and apply patch to stable then recompile

```sh
     #!/bin/bash
     ## SPDX-License-Identifier: GPL-2.0
     # Copyright(c) Shuah Khan <skhan@linuxfoundation.org>
     #
     # License: GPLv2
     # Example usage: pre_compile_setup.sh 5.2.11 1 5
     # Arg 1 is the stable release version which is typically 5.2.x
     # Arg2 is the 1 for rc1 or 2 for rc2
     # Arg3 is 4.x or 5.x used to call wget to get the patch file
     echo Testing patch-$1-rc$2
     wget https://www.kernel.org/pub/linux/kernel/v$3.x/stable-review/patch-$1-rc$2.gz 
     git reset --hard
     make clean
     git pull
     gunzip patch-$1-rc$2.gz
     git apply --index patch-$1-rc$2
     echo "Patch-$1-rc$2 applied"
     head Makefile
     make -j2 all
     rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
     su -c "make modules_install install"
     echo Ready for reboot test of Linux-$1-$2
```

`dmesg` log check for regressions:

```sh
dmesg -t > dmesg_current
dmesg -t -k > dmesg_kernel
dmesg -t -l emerg > dmesg_current_emerg
dmesg -t -l alert > dmesg_current_alert
dmesg -t -l crit > dmesg_current_crit
dmesg -t -l err > dmesg_current_err
dmesg -t -l warn > dmesg_current_warn
```

dmesg_checks.sh: Requires saved dmesg logs like above

```sh
     # !/bin/bash
     #
     #SPDX-License-Identifier: GPL-2.0
     # Copyright(c) Shuah Khan <skhan@linuxfoundation.org>
     #
     # License: GPLv2​

          if [ "$1" == "" ]; then
             echo "$0 " <old name -r>
             exit -1
     fi

release=`uname -r`
echo "Start dmesg regression check for $release" > dmesg_checks_results

echo "--------------------------" >> dmesg_checks_results

dmesg -t -l emerg > $release.dmesg_emerg
echo "dmesg emergency regressions" >> dmesg_checks_results
echo "--------------------------" >> dmesg_checks_results
diff $1.dmesg_emerg $release.dmesg_emerg >> dmesg_checks_results
echo "--------------------------" >> dmesg_checks_results

dmesg -t -l crit > $release.dmesg_crit
echo "dmesg critical regressions" >> dmesg_checks_results
echo "--------------------------" >> dmesg_checks_results
diff $1.dmesg_crit $release.dmesg_crit >> dmesg_checks_results 
echo "--------------------------" >> dmesg_checks_results

dmesg -t -l alert > $release.dmesg_alert
echo "dmesg alert regressions" >> dmesg_checks_results
echo "--------------------------" >> dmesg_checks_results
diff $1.dmesg_alert $release.dmesg_alert >> dmesg_checks_results
echo "--------------------------" >> dmesg_checks_results

dmesg -t -l err > $release.dmesg_err
echo "dmesg err regressions" >> dmesg_checks_results
echo "--------------------------" >> dmesg_checks_results
diff $1.dmesg_err $release.dmesg_err >> dmesg_checks_results
echo "--------------------------" >> dmesg_checks_results

dmesg -t -l warn > $release.dmesg_warn
echo "dmesg warn regressions" >> dmesg_checks_results
echo "--------------------------" >> dmesg_checks_results
diff $1.dmesg_warn $release.dmesg_warn >> dmesg_checks_results
echo "--------------------------" >> dmesg_checks_results

dmesg -t > $release.dmesg
echo "dmesg regressions" >> dmesg_checks_results
echo "--------------------------" >> dmesg_checks_results
diff $1.dmesg $release.dmesg >> dmesg_checks_results
echo "--------------------------" >> dmesg_checks_results

dmesg -t > $release.dmesg_kern
echo "dmesg_kern regressions" >> dmesg_checks_results
echo "--------------------------" >> dmesg_checks_results
diff $1.dmesg_kern $release.dmesg_kern >> dmesg_checks_results
echo "--------------------------" >> dmesg_checks_results

echo "--------------------------" >> dmesg_checks_results

echo "End dmesg regression check for $release" >> dmesg_checks_results
----------------------------------------------------------------------------------------------------------
```

## kselftest

NOTE: Don't run as root, it could reboot the system

`make kselftest`

## Documentation

Can contribute by fixing problems in building or improving documentation.

`make htmldocs`
`./scripts/sphinx-pre-install`

Checking for errors/warnings
`make htmldocs > doc_make.log 2>&1`

## Other ways of Getting Started

There are several ways to get started and contribute to the kernel. A few ideas:

* Subscribe to the Linux Kernel mailing list for the area of your interest.
* Follow the development activity reading the Linux Kernel Mailing List Archives.
* Join the `#kernelnewbies` IRC channel on the OFTC IRC network. Several of us developers hang out on that channel. This server is home to `#mm`, `#linux-rt`, and several other Linux channels.
* Join the `#linux-kselftest`, `#linuxtv`, `#kernelci`, or `#v4l` IRC channels on freenode.
  - This server recommends Nick registration. Server Name: irc.freenode.net/6667. You can register your Nick in the server tab with the command: identify /msg NickServ identify <password>
  - You can configure your chat client to auto-identify using the NickServ(/MSG NickServ+password) option - works on hexchat.
* Find spelling errors in kernel messages.
* Static code analysis error fixing: Static code analysis is the process of detecting errors and flaws in the source code. The Linux kernel Makefile can be invoked with options to enable to run the Sparse source code checker on all source files, or only on the re-compiled files. Compile the kernel with the source code checker enabled and find errors and fix as needed.
* Fix the Syzbot null pointer dereference and WARN bug reports which include the reproducer to analyze. Run the reproducer to see if you can reproduce the problem. Look ​​​​​​​at the crash report and walk through sources for a possible cause. You might be able to fix problems.
* Look for opportunities to add/update .gitignore files for tools and Kselftest. Build tools and Kselftest and run git status. If there are binaries, then it is time to add a new .gitignore file and/or an entry to an existing .gitignore file.
* Run mainline kernels built with the CONFIG_KASAN, Locking debug options mentioned earlier in the debugging section, and report problems if you see any. This gives you an opportunity to debug and fix problems. The community welcomes fixes and bug reports

### FAQ

1. `git send-email` fails with ERROR : STARTTLS failed! SSL connect attempt failed error:1416F086:SSL

Usually, this is due to 2-factor authentication. To solve this, can generate app specific password for authentication, eg. https://git-scm.com/docs/git-send-email.

