# sort

* `-r` -> Sort lines in reverse order
* `-k 3` -> Sort acc. to 3rd field
* `-u` -> Checks for unique values after sorting; Same as running `uniq` on output of sort

# uniq

uniq removes duplicate **consecutive** lines in a text file.

> So, one often runs sort first, then pipes the output to uniq, or directly use the -u option

* `-c` -> Count number of duplicate lines

# paste

Merge multiple files line by line into one.
For eg. if one file contains names, second contains phone numbers, third contains email,
then using `paste -d ',' names numbers emails` we can get a new **CSV file** (with the -d, option) with these details all in one

# Options

* '-d' -> delim character or list of delims (string)
* '-s' -> sequential; ie. first file will be column names, rest data rows (ie. this is column major form kind of)

# join

Like an enhanced version of paste, ignores common column values, and 'joins' the rows (as in SQL tables) according to common row value

# split

Mostly used for Large files only, for easy viewing or manipulation.

```sh
split infile splitfile	# multiple 1000-line files will be created named... 'splitfilexx' where xx is aa,ab,...
```

# grep

Can take regular expressions too (Dekh bhai, tu pehle awk use karta tha kuchh bhi regex ke according filter karna ho to, bhale pura line chahiye ho)

* '-v' -> List lines in which the pattern was **not** found

# `strings`

**strings** is used to extract all printable character strings, found in a file (typically used on a binary file, to locate human-readable content embedded in binary files).
Then we may search the output as any normal text, using grep or other commands.

# Miscellaneous Text Utilities

## tee

`tee` takes output from any command, and, while sending to standard output, it also saves it to a file.

For eg. `ls -l | tee newfile`

