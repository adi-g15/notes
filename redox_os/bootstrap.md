## The bootloader script

> finally documenting this... !

At the beginning there's a function `banner` to display the header "Welcome to the redox bootstrap", and then you will see various `install_*_pkg` functions, these are functions to install required build dependencies, will see arch one later.

> Also, there are comments on many function regarding what they do

At commit `1d3202a`, the actual location where the script runs the commands are from line 560 onwards.

These are some assignments:

```sh
emulator="qemu"
defpackman="apt-get"
dependenciesonly=false
update=false
```

These are some defaults, and will likely be updated by the next logic:

```sh
while getopts ":e:p:udhs" opt
do
        case "$opt" in
                e) emulator="$OPTARG";;
                p) defpackman="$OPTARG";;
                d) dependenciesonly=true;;
                u) update=true;;
                h) usage;;
                s) statusCheck && exit;;
                \?) echo "I don't know what to do with that option, try -h for help"; exit;;
        esac
done
```

If you run `./bootstrap.md -h`, you will know what these maybe... try yourself :)

> Just as an extra, the while runs for each option you pass to bootstrap.sh, for eg. ./bootstrap.sh -u master -e virtualbox
>
> Tip: Why are the 'e', 'p', are separate while 'u', 'd', 'h', 's' are together... those 'seem' to not take any arguments, dont they

Then the script calls two functions,

```sh
rustInstall
cargoInstall cargo-config 0.1.1
cargoInstall xargo 0.3.20
```

You can see the `rustInstall()` function, it DOES NOT install anything as it may seem, it just checks if `rustc` (rust compiler) is available, and suggests to also install `rustup`, if not available (I also recommend you install it, if using rust for any development :)

The `cargoInstall()` function `cargo install --force --version $VERSION $NAME`, (the script uses $2 and $1, that's bash syntax to access passed arguments), so it install cargo-config@0.1.1 and xargo@0.3.20

Then mainly three if conditions till the end of file...

1. Update

Remember the `while getopts ":e:p:udhs" ` loop, if you ran `./bootstrap.md -u`, it sets the `update` to true, and so this if block will execute

```
if [ "$update" == "true" ]; ...
```

Update does this:

```
git pull upstream master                 # Pull latest commits
git submodule update --recursive --init  # Update git submodules (also dependencies), pulling latest commits of all of them
rustup update nightly                    # Update rust toolchain (nightly toolchain), mainly the rust compiler and cargo
```

> Here i suggest you to add `--depth=1` to the git commands, it will save a lot of data for you :)

2. Checking the running system

> `uname` is a command to get currently running system's information
>
> Run `uname -a` on your system, to see yourself

```
if [ "Darwin" == "$(uname -s)" ]; ...
```

It will be true for MacOS systems, in my case I go with the else block

In this, there are many if-else conditions, to check what package manager is available, for example, for "I use arch btw" users, it will find `pacman` and call `archLinux()` function, which will then call `pacman -S ...` to install dependencies such as `qemu` (to run redox in virtual machine) etc.

3. Cloning the repo (boot function)

> This runs by default when you run ./bootstrap.sh for the first time without any argument

```
if [ "$dependenciesonly" = false ]; ...
```

It will run if you **did not** chose _"Only install the dependencies, skip boot step"_ **(-d)**, it will call 'boot' function

> It DOES NOT do anything booting related, consider it called 'bootstrap'

This clones the `redox` repository (https://gitlab.redox-os.org/redox-os/redox.git), and gives instruction to run `make all`

## DONE

That's it now what happens in the build process (after running make all) internally is in [Building Internals](./building-internals.md)

