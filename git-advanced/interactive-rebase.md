# Interactive Rebase

Can make changes to commits after they have been made.

**ALL commits above base commit will have different hashes, in a way they are different
commits now**

1. Change commit message
2. Delete commits
3. Reorder commits
4. Compine multiple commits into one (squashing)
5. Edit/Split existing commit into multiple

> Should NOT use interactive rebase on commits already pushed to a remote repo,
> use for cleaning local commit history, before merging to the shared team remote

```sh
git rebase -i HEAD~3
```

> Note 0:
> 
> Alternative to change latest commit message - `git commit ammend`
>

> Note 1:
>
> The interactive rebase edit text will have commits in opposite order (from
> BASE (old) commit to latest)

> Note 2:
> To do an interactive rebase, chose the PREVIOUS commit than the latest one we
> want to change (ie. chosing the _BASE_ commit)
> 
> HEAD~3 refers to the 4th latest, so that works too

After the command, ONLY change `pick` with other command, for eg. `reword` (to
change commit message, another window pops up, edit there)

Other commands:
`squash` - Merge with one older commit (with the one previous)


