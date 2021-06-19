# Disk-to-Disk Copying (dd)

The `dd` program is very useful for making copies of raw disk space.

For eg, to backup the MBR (Master Boot Record, first 512-byte sector of the disk, that contains a table describing the partitions on that disk) ->

```sh
dd if=/dev/sda of=sda.mbr bs=512 count=1
```

> What the name `dd` stands for is an often-argued item.
>
> The word 'data definition' is most popular 'theory' has roots in early IBM history
>
> Though people joke it means 'disk destroyer' or 'delete data' 🤣

