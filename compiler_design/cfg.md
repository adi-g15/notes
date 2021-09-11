# Context-free Grammar

> A brief of http://infolab.stanford.edu/~ullman/ialc/spr10/slides/cfl1.pdf

* It's a notation for describing languages
* It's more powerful than finite automata, & regular expressions, but still can't define all possible languages
* Useful for nested structures, eg. parentheses in prog. langs.

* Basic idea is to use "variables" to stand for **set of strings (ie. languages)**
* Recursive rules ("productions") involve only concatenation.
* Alternative rules for variable allow union

#### Example: CFG for {0<sup>n</sup>1<sup>n</sup>;}
