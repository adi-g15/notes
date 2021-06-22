# Creating temporary files/directories

Use `mktemp`.

```sh
# The XXXXXXX is replaced by mktemp with random characters

TMP=$(mktemp /tmp/tempfile.XXXXXXX)
TMP_DIR=$(mktemp -d /tmp/tempdir.XXXXXXX)
```

# Discarding Output with /dev/null

Redirect the large output to a special file (a device node) called /dev/null.

`/dev/null` - Also called the `bit bucket` or `black hole`

```sh
command > /dev/null	# Only redirect stdout

command >& /dev/null	# Both stdout & stderr dumped into /dev/null
```

# Random Numbers

Use environment variable: `$RANDOM`

It is derived from the Linux kernel's built-in random number generator, or by the OpenSSL library function.

## HOW THE KERNEL GENERATES Random Numbers

> INTERESTING

> When hardware generators available -

Some servers have hardware random number generators that take as input different types of noise signals, such as thermal noise and photoelectric effect. A transducer converts this noise into an electric signal, which is again converted into a digital number by an A-D converter. This number is considered random.
However, most common computers do not contain such specialized hardware and, instead, rely on **events created during booting to create the raw data** needed.

Regardless of which of these two sources is used, the system maintains a so-called entropy pool of these digital numbers/random bits. Random numbers are created from this entropy pool.

The Linux kernel offers the /dev/random and /dev/urandom device nodes, which draw on the entropy pool to provide random numbers which are drawn from the estimated number of bits of noise in the entropy pool.

/dev/random is used where very high quality randomness is required, such as one-time pad or key generation, but it is relatively slow to provide values. /dev/urandom is faster and suitable (good enough) for most cryptographic purposes.

Furthermore, when the entropy pool is empty, /dev/random is blocked and does not generate any number until additional environmental noise **(network traffic, mouse movement, etc.)** is gathered, whereas /dev/urandom reuses the internal pool to produce more pseudo-random bits.

