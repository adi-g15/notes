# String Manipulation

```sh
[[ str1 > str2 ]]	# Compares the sorting order of str1 & str2
[[ str1 == str2 ]]	# Compares the characters in str1 with str2
mylen=${#str1}		# Get length of string
```

# Parts of string

To extract first n characters:
```sh
${string:0:n}	# 0 is first offset, n is last offset
```

To get part of string after a dot (.), use the following expression:
```sh
${string#*.}
```

