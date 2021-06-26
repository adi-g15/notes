# Finding and using previous commands

> Not typing the history file part

These keys/combination used:

* Up/Down
* !! (bang-bang) - Execute previous command
* CTRL-R - Search previously used commands

## Executing previous commands

The syntax used:

* `!` -> Start a history substitution
* `!$` -> Refer to last argument in line 
* `!n` -> Refer to nth command line
* `!str` -> Refer to most recent command starting with str

> For example, when typing `ls -l /bin /etc /var`, !$ will refer to '/var'

