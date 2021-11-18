# Reflog

Git diary

Logs all movements of HEAD pointer

```sh
git reflog
```

Example Use case:
Removed last 2 commits, then realised I want them back :)

Restoring commits:

```sh
git reset --hard COMMIT_HASH # delete till the commit ref

git reflog  # Check what was the last commit's hash
git branch restored_branch OLD_COMMIT_HASH
```

Restoring branch:
Same as above, just get the newest commit's HASH of the deleted branch from
reflog

