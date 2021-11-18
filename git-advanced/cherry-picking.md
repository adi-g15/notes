# Cherry Pick

> Use merge and rebase mostly, cherry picking should ONLY be used when required

Merge/Rebase: Choses all commits from other branch to HEAD

Cherry Pick: Chose a particular commit from other branch to HEAD

Example:
Accidently created a commit on main,
so we want to move that to our feature branch

For example, the latest commit was by mistake on master instead should have been
on feature,

```sh
git checkout feature
git cherry-pick COMMIT_ID  # Move the accidental commit (doesn't delete from
other)

git checkout master
git reset --hard HEAD~1    # Remove the accidental commit from main
```

