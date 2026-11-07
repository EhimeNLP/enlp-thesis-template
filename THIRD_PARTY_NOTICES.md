# Third-party notices

Third-party material retains its respective copyright and license terms.
This includes the Ehime University NLP Lab logo and the fonts embedded in the sample and documentation PDFs.

## BibTeX standard aliases

The month and journal abbreviations in `src/enlp.bst` come from `plain.bst` 0.99b, copyright 1984, 1985, 1988 and 2010 Howard Trickey and Oren Patashnik.
The upstream terms permit redistribution of modified material under a filename other than `btxbst.doc`, `plain.bst`, `unsrt.bst`, `alpha.bst` or `abbrv.bst`. [Original `plain.bst`](https://mirrors.ctan.org/biblio/bibtex/base/plain.bst)

## BibLaTeX

`src/enlp.bbx` adapts BibLaTeX's `standard.bbx` to group proceedings titles, volumes and pages, change editor labels and reorder publisher and location details.
It also adjusts journal and issue punctuation.
`src/enlp.cbx` adapts `authoryear-comp.cbx` to preserve citation order and repeat the year when a same-year suffix is printed.

BibLaTeX copyright belongs to Philipp Lehman and Philip Kime, as recorded upstream.
The adapted material remains under the LaTeX Project Public License, version 1.3 or later. [Original BibLaTeX sources and license](https://github.com/plk/biblatex#copyright-and-licence), [LPPL text](https://www.latex-project.org/lppl/)

## jlreq

The template loads `jlreq` as a base class from the user's TeX distribution.
`jlreq` is copyright Noriyuki Abe and is distributed under BSD-2-Clause. [Upstream license](https://github.com/abenori/jlreq/blob/master/LICENSE)
