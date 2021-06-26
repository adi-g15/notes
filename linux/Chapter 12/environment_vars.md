# Environment Variables

Quantities that have specific values which maybe utilised by the command shell or other application.

Some are given preset values by the system.

They are actually just a character string.

## Viewing & Setting them

One can type `set`, `env`, or `export`, for these.

> 'set' may print out many more lines than the other two
>
> Don't pass any option to the three, to view variables

# Setting environ. vars.

> By default, **variables created within a script are only available to the current shell; EVEN child processes (sub-shells) will not have access to values that have been set OR modified**.
>
> To allow child processes (sub-shells) to see the values, use `export` command

To see value of a variable -> 
```sh
echo $SHELL
```

Export a new variable value
```sh
export VARIABLE=value

# OR

VARIABLE=value
export VARIABLE
```

> Environment variables can also be fed as a one shot to a command as in:
>
> ```sh
> VAR_A=s_* VAR_B=/bin/$(uname -r)_prog make install
> ```

## PATH

* PATH is an **ordered** list of directories, and each directory is separated by colons (:).
* A **null(empty) directory name (or ./)** indicates the current directory at any given time, for eg in `:path1:path2` or `path1::path2`

## PS1

* PS - Prompt Statement

* '\u' - Username, '\h' - Host name, '\w' - Current working directory, '\!' - History number of this command, '\d' - Date


