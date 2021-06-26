# diff

`diff` is used to compare files and directories.

### Options

* `-c` -> Include 3 lines of context before and after
* `-r` -> Recursively compare directories
* `-i` -> Ignore case (Case-insensitive)
* `-w` -> Ignore whitespace differences (spaces,tabs)
* `-q` -> Quiet Mode, only say different or not

> `diff` is meant for text files; For binary files, use `cmp`

# diff3

For comparing three files, the 2nd file is used as reference.

```sh
diff3 MY-FILE COMMON-FILE YOUR-FILE
```

For eg. i and you both made changes to a file independently, then this command can be used to find the difference.

# patch

Many modifications to source code and configuration files are distributed utilising patches, which are applied with the `patch` program.

The patch files are actually produced with diff, with correct options like
```sh
diff -Nur originalfile newfile > patchfile
```

> Distributing patch is more concise and efficient than distributing the entire file, in case of small changes.

## Applying patch

To apply a patch, we can just do either of these methods:

```sh
patch -p1 < patchfile
patch originalfile patchfile
```

> The first usage is more common, as it is often used to apply changes to entire directory tree, rather than just one file.

