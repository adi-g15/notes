Chosing which recipes to use are likely in /filesystem.toml (default), and other options in /config/ directory, lekin us directory ka koi bhi mention nhi mila (using ripgrep)

* acid.toml  coreboot.toml  desktop.toml  jeremy.toml  maximal.toml  minimal.toml  resist.toml  server.toml

Update: Actually, filesystem.toml is symlinked to config/desktop.toml

In mk/filesystem.mk, `INSTALLER` is invoked passed with this list,
INSTALLER is `installer/target/release/redox_installer --cookbook=cookbook`

It is invoked with:
```sh
$INSTALLER -c filesystem.toml build/filesystem/
```

