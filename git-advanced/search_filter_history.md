# Search & Find

> Filtering commit history

1. by date: `--before / --after`

```sh
git log --after="2021-11-2"
git log --before="2021-11-2"
```

2. by message: `--grep`

```sh
git log --grep="string in message"
```

3. by author: `--author`

```sh
git log --author="Gupta"
```

4. by file: `-- filename`

```sh
git log -- README.md        # to see what commits modified README
```

5. by branch: `branch A`

```sh
git log feature..main       # show all commits that ARE IN MAIN, but not in
feature
```


