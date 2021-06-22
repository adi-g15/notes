# Manipulating PostScript & PDF files

Postscript is a standard page description language (by Adobe, 1980s). Any modern printer supports Postscript.

It has been superseded by PDF, however one still has to deal with postscript documents, often as a intermediate format.

## `enscript`

Tool to convert text file to postscript and other formats.
Also supports RTF (Rich Text Format) and HTML.

For eg. 

* this converts a text file to two columns formatted PostScript using the command:
* rotates (-r) the output, so it is in landscape mode, thereby reducing number of pages for printing

```sh
enscript -2 -r -p psfile.ps textfile.txt
```

### Commands

* `enscript -p psfile.ps text.txt` -> Convert text file to postscript (saved to psfile.ps)
* `enscript -n -p psfile.ps text.txt` -> Convert text file to n columns (n=1-9)
* `enscript text.txt` -> Print a text file directly to the default printer

> There are powerful tools for converting -> eg. the very powerful convert program, which is part of the ImageMagick package. (Some newer distributions have replaced this with Graphics Magick, and the command to use is gm convert)

## Editing PDF files

Use

* qpdf -> Recommended
* pdftk -> DONT USE ;p
* ghostscript -> 'Little' Complex

* `pdfmod` -> Simple GUI; reorder, rotate, and remove pages; export images from a document; edit the title, subject, and author; add keywords; and combine documents using drag-and-drop action

### `qpdf`

* merge -> `qpdf --empty --pages 1.pdf 2.pdf -- 12.pdf`

* rotate -> `qpdf --rotate=+90:1-z 1.pdf 1r-all.pdf`
* selectively rotate -> `qpdf --rotate=+90:1 1.pdf 1r.pdf`	_Rotate page 1 of 1.pdf 90 degree clockwise_

* select -> `qpdf --empty --pages 1.pdf 1-2 -- new.pdf`	_Write only pages 1 and 2 of 1.pdf_

* encrypt -> `qpdf --encrypt mypw mypw 128 -- public.pdf private.pdf`
* decrypt -> `qpdf --decrypt --password=mypw private.pdf file-decrypted.pdf`

