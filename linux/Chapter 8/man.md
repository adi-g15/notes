# man

`man` searches, formats, and displays info contained in the man page system, introduces in 1970s in UNIX.

Since there is large information many times, output is passed through a pager program (eg. less)

### Multiple pages

Given topic may have multiple pages associated, 

* Use `-f` option -> List all pages on the topic (same result as `whatis`)
* Use `-k` option -> List all pages that discuss the topic (even if not in name; same result as `apropos`)


> To view all pages on a topic, one after another -> Use `-a` option

Default order is specified in /etc/man\_db.conf

## Manual Chapters

Divided into chapters numbered from 1 through 9.

In some cases, a letter is appended to chapter number to identify specific topic. For example many pages are in chapter 3x

