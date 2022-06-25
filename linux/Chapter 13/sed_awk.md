> Note - Many linux users/admins will write scripts using other languages such as Python/Perl, rather than using sed and awk.

# sed

> Abbreviation for **s**tream **ed**itory

Input Stream -> Working Stream -> Output Stream

## Command syntax

```sh
sed -e command <file> - Specify editing commands on commandline

sed -f scriptfile <file> - Specify a scriptfile containing 'sed' commands
```

> -e option allows to specify multiple commands too.
>
> It is unnecessary if only one operation invoked

## Basic Operations

* Replacing string
  ```sh
  sed s/str1/str2/ file		# Replace first occurrence
  sed s/str1/str2/g file	# Replace all occurrences
  sed 4,7s/str1/str2/g file	# Replace all in a range (4-7 here)
  ```

> Saving changes to same file -> Use `-i` option, though be careful, safer is to write to another file like this-
>
> sed ... > file2
> # Check if file2 is okay (maybe with cat or diff)
> mv file2 file

For multiple operations, just use -e ( Note, it wasn't used in examples since it;s not required for single operation)

# awk

awk is used to extract and then print.

> Name derived from last name first char of its devs

> It is a powerful utility and interpreted programming language

### Usage

Same as sed, short commands can be directly passed, but more complex script can be specified using -f option.
```sh
awk 'command' file
awk -f scriptfile file
```

### Basic Operations

Use `-F` option to change delimiting character. For example /etc/passwd uses ':' as delims

```sh
awk -F: '{print $1}' /etc/passwd	# Print first field (column) of every line
```

