# NFS (Network FileSystems)

> Note: `mount` command without options lists mounted devices like in /etc/fstab`

A network (also called distributed) filesystem may have all its data on one machine, or have it spread out on more than one network node.

A variety of different filesystems can be used locally on the individual machines; a NFS can be thought of as a grouping of lower level filesystems of varying types.

![The Client-Server Architecture of NFS](https://courses.edx.org/assets/courseware/v1/b29a567ddecc954ea6440a9e4dedd067/asset-v1:LinuxFoundationX+LFS101x+1T2020+type@asset+block/nfs.png)


The most common such filesystem is simply named `NFS`. It was first developed by Sun Microsystems.
Another common implementation is `CIFS` (aka `SAMBA`), which has Microsoft roots.


## NFS on the Server (whole copied)

We will now look in detail at how to use NFS on the server.

On the server machine, NFS uses daemons (built-in networking and service processes in Linux) and other system servers are started at the command line by typing:

```sh
sudo systemctl start nfs
```

The text file /etc/exports contains the directories and permissions that a host is willing to share with other systems over NFS. A very simple entry in this file may look like the following:

```
/projects \*.example.com(rw)
```

This entry allows the directory /projects to be mounted using NFS with read and write (rw) permissions and shared with other hosts in the example.com domain. As we will detail in the next chapter, every file in Linux has three possible permissions: read (r), write (w) and execute (x).

After modifying the /etc/exports file, you can type exportfs -av to notify Linux about the directories you are allowing to be remotely mounted using NFS. You can also restart NFS with sudo systemctl restart nfs, but this is heavier, as it halts NFS for a short while before starting it up again. To make sure the NFS service starts whenever the system is booted, issue sudo systemctl enable nfs. (Note: On RHEL/CentOS 8, the service is called nfs-server, not nfs).


A sample /etc/exports file:
```
/usr/local	192.168.1.0/24(rw,no_root_squash,sync)
/tmp		192.168.1.0/24(rw,no_root_squash)
/var/ftp/pub	*(ro,insecure,all_squash)
```

Then we have to run `sudo exportfs`

## NFS on client

Mounting the remote fs on boot, add to /etc/fstab ->
```
servername:/projects /mnt/nfs/projects nfs defaults 0 0
```
For example `192.168.1.200:/projects /mnt/nfs/projects

> May want to use the `nofail` option in fstab, in case the NFS server isn't live at boot.

Mounting using mount command ->
```sh
sudo mount servername:/projects /mnt/lfs/projects
```

