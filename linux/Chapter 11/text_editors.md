# Text editors

'Word processors' are not really basic text editors, they add a lot of extra formatting information that will probably render system config files unusable.

# vim

> `vitutor` is very good to learn the basics, and is short, having only seven lessons.

### Modes

* Command -> Each key is an editor command. Keyboard strokes interpreted as commands that can modify file contents.
* Insert -> Type i to switch to insert mode from command mode
* Line -> Type : to switch to line mode from command mode. Each key is an external command, including operations such as writing the file contents or exiting.

Commands (only those i didn't know well or not at all) ->

* :r file2 -> Read in file2 and insert at current position
* :w myfile -> Write out to myfile
* :w! file2 -> Overrite file2
* :x or :wq

> **Type A to insert text at end of the line (append+turns on insert mode)**

## Changing Cursor positions in vim

* `h` or backspace -> Move left
* `j` or `<ret>` -> Move down
* `k` -> Move up
* `l` or space -> Move right

* w -> move to beginning of next word

* 0 -> move to beginning of line
* $ -> move to end of line
* :0 or 1G -> move to beginning of file
* :n or nG -> move to line n
* :$ or $G -> move to last line file

* Ctrl-F or Pg Down -> Move forward one page
* Ctrl-B or Pg Up -> Move backward one page

* ^l -> Refresh and center screen

## Searching in vim

* `/pattern` -> Search forward for pattern
* `?pattern` -> Search backward for pattern

* n -> Move to next occurence of search pattern
* N -> Move to previous occurence of search pattern

## Working with text in vi

* a -> Append after cursor
* i -> Insert before cursor

* A -> Append at end of line
* I -> Insert at beggining of line

* o -> Start a new line below
* O -> Start a new line above

* r -> Replace character at current position
* R -> Replace starting with current position
* x -> Delete character at current position

* dw -> Delete word at current position

* D -> Delete rest of line
* dd -> Delete current line
* Ndd -> Delete N lines
* yy -> Yank (copy) current line and put it in buffer
* Nyy -> Yank N lines and put in buffer
* p -> Paste at current position

* u - Undo

## External Commands

Typing ! executes a command from within vi. The command follows the exclamation point.

Best suited for non-interactive commands, such as `! wc %`

> NOTE- I didn't write down ANY part of Emacs pages, also ignored most commands for not confusing with the freshly leearnt vim ones. Waise bhi agar achha text editor hi chahiye to i will still prefer something like VS Code, agar vim se kaam nhi ban rha :D

