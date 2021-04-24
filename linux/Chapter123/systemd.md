## systemd

> Chapter 3

Now, `/sbin/init` just points to `/lib/systemd/systemd` (ie. systemd takes over init)

One **systemd** command (`systemctl`) is used for most basic tasks, for example:

    ```sh
    systemctl start/stop/restart nfs.service    ## Starting, stop, restart a service on a currently running system
    systemctl enable/disable nfs.service     ## Enable/Disable a service from starting at startup
    ```

> Note: In most cases, we don't need to mention the `.service` in service name

