# Debugging bash scripts

* `set -x` -> turns on debugging
* `set +x` -> turns off debugging

# Redirecting errors to File and Screen

In \*nix, all programs that run are given three open file streams when they are started:

File stream (File Descriptor) - Description
* stdin (0) 	- Standard Input, by default the keyboard/terminal for programs run from the command line
* stdout (1) 	- Standard output, by default the screen for programs run from the command line
* stderr (2) 	- Standard error, where output error messages are shown or saved

```sh
command 2> error.log
```

