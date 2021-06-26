# Backing Up data

Basic ways to do so include simple copying with 'cp', and use of the more robust `rsync`

`rsync` is more efficient, because:
* if file already exists, and there is no change in size or modification time, `rsync` will avoid an unnecessary copy
* `rsync` copies only the parts of files that have actually changed
* In recursive copying of directory tree to another, only the difference is transmitted over the network

Also, rsync can be used to copy files from one machine to another (which cp can't do, unless the destination is mounted using NFS).
Locations are designated in `target:path` form, where target is of the form of 'someone@host', though 'someone@' part is optional.

One often **synchronizes** the destination directory tree with the origin, with the -r option.

## Using `rsync`

A very useful way to backup a project directory -
```sh
rsync -r project-X archive-machine:archives/project-X
```

> NOTE - rsync can be very destructive, it's highly recommended to use '--dry-run' option to ensure the result is what we want.

A good combination of options are:
```sh
rsync --progress -avrxH --delete sourcedir destdir
```

