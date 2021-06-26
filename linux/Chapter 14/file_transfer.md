# FTP

> Whole copied

> FileZilla is a good GUI client

Some command line FTP clients are:

* ftp
* sftp
* ncftp
* yafc (Yet Another FTP Client).

FTP has fallen into disfavor on modern systems, as it is intrinsically insecure, since passwords are user credentials that can be transmitted without encryption and are thus prone to interception.
Thus, it was removed in favor of using rsync and web browser https access for example.
As an alternative, sftp is a very secure mode of connection, which uses the Secure Shell (ssh) protocol, which we will discuss shortly. sftp encrypts its data and thus sensitive information is transmitted more securely. However, it does not work with so-called anonymous FTP (guest user credentials).

# SSH

It is a **cryptographic network protocol** used for secure data communication.

To login to remote system using your same username, just type `ssh some_system`. If wanting to run an another user, we can use `ssh some_system -l someone` or `ssh someone@some_system`.


## Copying files securely with `scp`

> scp - Secure Copy; uses the SSH protocol for transferring data

### Example Usage

> -r for recursive copy (copying directories)
> If usernames are not same, use user@some\_ip:/path
```sh
scp -r /home/adityag some_ip:/tmp
```



