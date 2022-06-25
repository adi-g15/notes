# Bash Shell and Basic Scripting / Syntax

> Didn't write most

* `$` indicates what follows is an environment variable

* `<` - Redirect input

## Multiple commands on single line

```sh
make; make install; make clean;		# Runs all

make && make install && make clean	# Further execution depends whether priveous must not fail

make || make install || make clean	# Only run commands till one of them succeeds
```

## Input Redirection

For eg. `wc < /etc/passwd`

## Built-in commands

bash has many built-in commands, which can only be used to display the output within a terminal shell or shell script. Sometimes, these commands have the same name as executable programs on the system, such as echo which can lead to subtle problems. bash built-in commands include and cd,  pwd, echo, read, logout, printf, let, and ulimit. Thus, **slightly different behavior can be expected from the built-in version of a command such as echo as compared to /bin/echo**.

> Type `help` to see commands built into the shell

## Parameters

`$0` - script name

`$*` - all parameters
`$#` - number of arguments

## Command Substitution

* Using `$(...)`
* [Deprecated] Enclosing in backticks `\``

Wichever method used, the command will be executed in a newly launched shell environment, and the stdout of the shell is inserted there.

The first way is also preferred now, as it **allows nesting**

## Exporting environment vars

> By default, the variables created within a script are available only to the subsequent steps of that script.
>
> Any child processes (sub-shells) do not have automatic access to the values of these variables.
>
> To make them available to child processes, they must be promoted to environment variables using the export statement

## Functions

> Also often called **subroutines**

```sh
func_name () {
	command...
}
```

## if

* '-f' -> `if [ -f "$1" ]` to check if file exists

> **Prefer to use double brackets**

> Notice the use of the square brackets ([]) to delineate the test condition
>
> In modern scripts, you may see doubled brackets as in [[ -f /etc/passwd ]]. This is not an error. It is never wrong to do so and it avoids some subtle problems, such as referring to an empty environment variable without surrounding it in double quotes;

## Testing for files

> The full list of conditionals can be used with `man 1 test`

* -e file 	Checks if the file exists.

* -d file 	Checks if the file is a directory.
* -f file 	Checks if the file is a regular file (i.e. not a symbolic link, device node, directory, etc.)

* -s file 	Checks if the file is of non-zero size.

* -g file 	Checks if the file has sgid set.
* -u file 	Checks if the file has suid set.

* -r file 	Checks if the file is readable.
* -w file 	Checks if the file is writable.
* -x file 	Checks if the file is executable.

## Boolean

> '&&', '||' and '!'

## Comparing numericals

'-eq', '-ne', '-gt', '-lt', '-ge', '-le'
For eg. 

```sh
if [[ $AGE -ge 20 ]] && [[ $AGE -lt 30 ]]; then
	echo
fi
```

The **operator -gt** returns TRUE if number1 is greater than number2

## Comparing strings

> Use double = signs.

```sh
if [ string1 == string2 ]; then
	ACTION
fi
```

> Using one = sign will also work, but some consider it deprecated usage

# Arithmetic

```sh
# expr is a standard but somewhat deprecated program. The syntax is as follows:
expr 8 + 8
echo $(expr 8 + 8)

# Using the $((...)) syntax 
echo $((x+1))

# Using the built-in shell command let. The syntax is as follows:
let x=( 1 + 2 ); echo $x
```

