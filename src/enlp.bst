%%
%% This is file `enlp.bst',
%% BibTeX bibliography style for Ehime University NLP Lab theses
%%
%% Author: Eito Yoneyama
%% Created: 2026/11/08
%%
%% Implements the ENLP output conventions using the (u)pBibTeX language.
%% Entries are emitted in citation order. The first sort is used only for
%% author-year suffixes, so those suffixes are independent of citation order.
%%
ENTRY
  { address author booktitle chapter edition editor howpublished institution
    journal key month note number organization pages publisher school series
    title type url volume year }
  { position suffix.index }
  { cite.name cite.year collision year.suffix }

INTEGERS { counter name.index name.count japanese suffix.next separator }
STRINGS { names person formatted.names result value prefix page.text previous.group }
STRINGS { emphasis.tail }

FUNCTION {present}
{ duplicate$ empty$ { pop$ "" } 'skip$ if$ }

FUNCTION {required}
{ 'value :=
  duplicate$ empty$
    { "missing " value * " in " * cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {fallback}
{ swap$ duplicate$ empty$ { pop$ } { swap$ pop$ } if$ }

FUNCTION {and}
{ { } { pop$ #0 } if$ }

FUNCTION {either}
{ { pop$ #1 } 'skip$ if$ }

FUNCTION {without.article}
{ 'value :=
  value #1 #4 substring$ "The " =
    { value #5 global.max$ substring$ }
    { value #1 #3 substring$ "An " =
        { value #4 global.max$ substring$ }
        { value #1 #2 substring$ "A " =
            { value #3 global.max$ substring$ }
            { value }
          if$
        }
      if$
    }
  if$
}

FUNCTION {sort.text}
{ purify$ "l" change.case$ }

FUNCTION {start.names}
{ present 'names :=
  names is.kanji.str$ 'japanese :=
  names num.names$ 'name.count :=
}

FUNCTION {family.name}
{ japanese
    { names name.index "{ff}" format.name$
      names name.index "{ll}" format.name$ fallback }
    { names name.index "{vv~}{ll}" format.name$ }
  if$
}

FUNCTION {family.label}
{ start.names
  #1 'name.index :=
  name.count #0 =
    { "" }
    { family.name
      name.count #2 >
        { japanese { " 他" } { " et~al." } if$ * }
        { name.count #2 =
            { #2 'name.index :=
              names #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
                { japanese { "他" } { " et~al.{}" } if$ * }
                { japanese { "，" } { " and\ " } if$ * family.name * }
              if$
            }
            'skip$
          if$
        }
      if$
    }
  if$
}

FUNCTION {display.names}
{ start.names
  "" 'formatted.names :=
  #1 'name.index :=
  { name.index name.count > { #0 } { #1 } if$ }
  { names name.index
    japanese { "{ff}{~ll}" } { "{ff~}{vv~}{ll}{, jj}" } if$
    format.name$ 'person :=
    name.index #1 >
      { formatted.names
        person "others" =
          { japanese
              { " 他" }
              { name.count #2 > { ", et~al." } { " et~al." } if$ }
            if$
            *
          }
          { japanese
              { "，" }
              { name.index name.count =
                  { name.count #2 = { "\ and\ " } { ", and\ " } if$ }
                  { ", " }
                if$
              }
            if$
            * person *
          }
        if$
      }
      { person }
    if$
    'formatted.names :=
    name.index #1 + 'name.index :=
  }
  while$
  formatted.names
}

FUNCTION {editors}
{ editor empty$
    { "" }
    { editor display.names
      japanese
        { "（編）\inhibitglue{}" }
        { name.count #1 > { " (Eds.)" } { " (Ed.)" } if$ }
      if$
      *
    }
  if$
}

FUNCTION {label.names}
{ type$ "proceedings" =
    { editor present }
    { type$ "book" = type$ "inbook" = either
        { author editor fallback }
        { author present }
      if$
    }
  if$
}

FUNCTION {label.organization}
{ type$ "proceedings" = type$ "manual" = either
    { organization present without.article }
    { "" }
  if$
}

FUNCTION {name.sort.key}
{ start.names
  ""
  #1 'name.index :=
  { name.index name.count > { #0 } { #1 } if$ }
  { "   " *
    names name.index "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ sort.text *
    name.index #1 + 'name.index :=
  }
  while$
}

FUNCTION {prepare}
{ counter #1 + 'counter :=
  counter 'position :=
  label.names family.label
  key present #3 text.prefix$ fallback
  label.organization #3 text.prefix$ fallback
  cite$ #1 #3 substring$ fallback
  'cite.name :=
  year present purify$ 'cite.year :=
  cite.name sort.text cite.year sort.text * 'collision :=
  collision "    " *
  label.names name.sort.key
  label.organization sort.text fallback
  key present sort.text fallback *
  "    " * title present without.article sort.text *
  #1 entry.max$ substring$ 'sort.key$ :=
}

FUNCTION {assign.suffixes}
{ collision previous.group =
    { suffix.next #1 + 'suffix.next := suffix.next 'suffix.index := }
    { collision 'previous.group := #0 'suffix.next := #0 'suffix.index := }
  if$
}

FUNCTION {mark.first.suffix}
{ suffix.index #0 = suffix.next #1 = and
    { "a" }
    { suffix.index #0 >
        { suffix.index "a" chr.to.int$ + int.to.chr$ }
        { "" }
      if$
    }
  if$
  'year.suffix :=
  suffix.index 'suffix.next :=
  "000000000" position int.to.str$ * #-1 #9 substring$ 'sort.key$ :=
}

FUNCTION {emphasis.with}
{ 'emphasis.tail :=
  duplicate$ empty$
    'skip$
    { duplicate$ is.kanji.str$
        { "{" swap$ * "}" * }
        { "{\em " swap$ * emphasis.tail * "}" * }
      if$
    }
  if$
}

FUNCTION {emphasis}
{ "" emphasis.with }

FUNCTION {crossref.emphasis}
{ "\/" emphasis.with }

FUNCTION {quoted.title}
{ title present duplicate$ empty$
    'skip$
    { add.period$ duplicate$ is.kanji.str$
        'skip$
        { "``" swap$ * "''" * }
      if$
    }
  if$
}

FUNCTION {with.edition}
{ duplicate$ empty$ edition empty$ either
    'emphasis
    { duplicate$ is.kanji.str$
        { emphasis " (" * edition * " 版)." * }
        { crossref.emphasis " (" * edition * " edition)." * }
      if$
    }
  if$
}

FUNCTION {with.number}
{ duplicate$ text.length$ #3 < { "~" } { "\ " } if$
  swap$ * *
}

FUNCTION {page.range}
{ pages 'page.text :=
  "" #0
  { page.text empty$ { #0 } { #1 } if$ }
  { page.text #1 #1 substring$ 'value :=
    page.text #2 global.max$ substring$ 'page.text :=
    value "-" =
      { pop$ "-" *
        page.text #1 #1 substring$ "-" =
          { { page.text #1 #1 substring$ "-" = }
            { "-" * page.text #2 global.max$ substring$ 'page.text := }
            while$
          }
          { "-" * }
        if$
        #1
      }
      { value "," = value "+" = either
          { pop$ value * #1 }
          { swap$ value * swap$ }
        if$
      }
    if$
  }
  while$
  { "\mbox{pp." } { "\mbox{p." } if$
  swap$ with.number "}" *
}

FUNCTION {page.label}
{ pages empty$ { "" } 'page.range if$ }

FUNCTION {comma.join}
{ 'value :=
  duplicate$ empty$
    { pop$ value }
    { value empty$ 'skip$ { ", " * value * } if$ }
  if$
}

FUNCTION {article.location}
{ volume empty$
    { "" }
    { "\textbf{" volume * "}" * }
  if$
  number empty$
    'skip$
    { volume empty$
        { "number without volume in " cite$ * warning$ }
        'skip$
      if$
      "  (" * number * ")" *
    }
  if$
  page.label comma.join
}

FUNCTION {book.volume}
{ volume empty$
    { "" }
    { title is.kanji.str$
        { volume "巻" * series present emphasis comma.join }
        { "Vol." volume with.number
          series empty$ 'skip$ { " of " * series emphasis * } if$
        }
      if$
    }
  if$
}

FUNCTION {book.series}
{ volume empty$
    { number empty$
        { series present }
        { title is.kanji.str$
            { series present number "号" * comma.join }
            { separator #1 =
                { "No." }
                { "No." }
              if$
              number with.number
              series empty$ 'skip$ { " in " * series * } if$
            }
          if$
        }
      if$
    }
    { "" }
  if$
}

FUNCTION {chapter.pages}
{ chapter empty$
    { "" }
    { title is.kanji.str$
        { type empty$ { chapter " 章" * } { type "l" change.case$ } if$ }
        { type present "l" change.case$ "Chap." fallback chapter with.number }
      if$
    }
  if$
  page.label comma.join
}

FUNCTION {container.title}
{ booktitle empty$
    { "" }
    { booktitle is.kanji.str$ { "" } { "In " } if$ 'prefix :=
      editors booktitle with.edition comma.join
      prefix swap$ *
    }
  if$
}

FUNCTION {crossref.label}
{ 'value :=
  editor empty$ editor present author present = either
    { key value fallback }
    { editor family.label }
  if$
}

FUNCTION {crossref.year}
{ " \citeyear{" * crossref * "}" * }

FUNCTION {article.container}
{ crossref missing$
    { journal present emphasis "journal" required }
    { key empty$
        { journal present crossref.emphasis
          journal is.kanji.str$ 'skip$ { "In " swap$ * } if$
        }
        { "In " key * }
      if$
      crossref.year
    }
  if$
}

FUNCTION {book.crossref}
{ title is.kanji.str$
    { volume empty$ { "" } { volume "巻" * } if$ }
    { volume empty$ { "In " } { "Vol." volume with.number " of " * } if$ }
  if$
  series present crossref.emphasis crossref.label * crossref.year
}

FUNCTION {chapter.crossref}
{ booktitle present crossref.emphasis crossref.label
  booktitle is.kanji.str$ key empty$ and editor empty$ and
    'skip$
    { "In " swap$ * }
  if$
  crossref.year
}

% Separator values correspond to comma, block, sentence, space, and a
% block preceded by an explicit TeX space (used after quoted titles).
FUNCTION {write.separator}
{ 'separator :=
  separator #1 =
    { result ", " * write$ }
    { separator #2 =
        { result add.period$ write$ newline$ "\newblock " write$ }
        { separator #3 =
            { result add.period$ " " * write$ }
            { result "\ " * write$
              separator #5 = { newline$ "\newblock " write$ } 'skip$ if$
            }
          if$
        }
      if$
    }
  if$
}

% Pending text is kept until its following separator is known. Empty optional
% fields do not reset that separator, so they cannot introduce punctuation.
FUNCTION {field}
{ duplicate$ empty$
    'pop$
    { 'value :=
      result empty$
        'skip$
        { separator
            write.separator
        }
      if$
      value 'result :=
      #1 'separator :=
    }
  if$
}

FUNCTION {block}
{ result empty$ 'skip$ { #2 'separator := } if$ }

FUNCTION {sentence}
{ separator #2 = 'skip$ { #3 'separator := } if$ }

FUNCTION {space.field}
{ duplicate$ empty$
    'pop$
    { separator #2 = { #5 } { #4 } if$ 'separator := field }
  if$
}

FUNCTION {begin.item}
{ newline$
  "\bibitem[{{" cite.name * "}{" *
  author editor fallback family.label cite.name fallback *
  "}{" * cite.year * year.suffix * "}}]{" * cite$ * "}" * write$ newline$
  "" 'result :=
  #1 'separator :=
}

FUNCTION {author.line}
{ author display.names field
  author empty$ { key present field } 'skip$ if$
}

FUNCTION {book.author.line}
{ author empty$
    { editors "author or editor" required duplicate$ empty$ 'skip$ { "\" * } if$ field }
    { author display.names field }
  if$
}

FUNCTION {write.date}
{ year empty$
    { "missing year in " cite$ * warning$ }
    { result empty$ 'skip$ { result add.period$ " " * write$ } if$
      year year.suffix * 'result :=
    }
  if$
}

FUNCTION {date.line}
{ write.date block }

FUNCTION {finish.item}
{ result add.period$ write$ newline$ }

FUNCTION {finish.with.note}
{ block note present field finish.item }

FUNCTION {article}
{ begin.item author.line date.line
  quoted.title "title" required field block
  article.container space.field
  crossref missing$ { article.location } { page.label } if$ field
  finish.with.note
}

FUNCTION {book.details}
{ book.volume field block book.series field sentence
  publisher present "publisher" required field address present field
}

FUNCTION {book}
{ begin.item book.author.line date.line
  title present with.edition "title" required field
  crossref missing$ 'book.details { block book.crossref field } if$
  finish.with.note
}

FUNCTION {inbook}
{ begin.item book.author.line date.line
  title present with.edition "title" required field
  crossref missing$
    { book.volume field chapter.pages "chapter or pages" required field
      block book.series field sentence
      publisher present "publisher" required field address present field
    }
    { chapter.pages field block book.crossref field }
  if$
  finish.with.note
}

FUNCTION {booklet}
{ begin.item author.line date.line
  title present with.edition "title" required field block
  howpublished present field address present field
  finish.with.note
}

FUNCTION {incollection}
{ begin.item author.line date.line quoted.title "title" required field block
  crossref missing$
    { container.title "booktitle" required space.field
      book.volume field book.series field chapter.pages field sentence
      publisher present "publisher" required field address present field
    }
    { chapter.crossref space.field chapter.pages field }
  if$
  finish.with.note
}

FUNCTION {inproceedings}
{ begin.item author.line date.line quoted.title "title" required field block
  crossref missing$
    { container.title "booktitle" required space.field
      book.volume field book.series field page.label field
      address present field sentence organization present field publisher present field
    }
    { chapter.crossref field page.label field }
  if$
  finish.with.note
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ begin.item
  author empty$
    { organization present field
      organization empty$ 'skip$ { address present field } if$
    }
    { author display.names field }
  if$
  date.line title present with.edition "title" required field block
  author empty$
    { organization empty$ { address present field } 'skip$ if$ }
    { organization present field address present field }
  if$
  finish.with.note
}

FUNCTION {thesis.item}
{ 'prefix :=
  begin.item author.line date.line
  prefix #1 #6 substring$ "Master" =
    { quoted.title "title" required field block
      type present "t" change.case$ prefix fallback space.field
    }
    { title present with.edition "title" required field block
      type present "t" change.case$ prefix fallback field
    }
  if$
  school present "school" required field address present field
  finish.with.note
}

FUNCTION {mastersthesis} { "Master's thesis" thesis.item }
FUNCTION {mastersreport} { "Master's report" thesis.item }
FUNCTION {phdthesis} { "Ph.D.\ thesis" thesis.item }
FUNCTION {dbathesis} { "DBA thesis" thesis.item }
FUNCTION {eddthesis} { "Ed.D.\ thesis" thesis.item }

FUNCTION {report.number}
{ type present "t" change.case$
  title is.kanji.str$ { "テクニカル・レポート" } { "Tech.\ rep." } if$
  fallback
  number empty$ 'skip$ { number with.number } if$
}

FUNCTION {techreport}
{ begin.item author.line date.line quoted.title "title" required field block
  report.number space.field institution present "institution" required field
  address present field finish.with.note
}

FUNCTION {proceedings}
{ begin.item
  editor empty$ { organization present field } { editors "\" * field } if$
  author empty$ { key present field } 'skip$ if$
  date.line title present with.edition "title" required field
  book.volume field book.series field address present field sentence
  editor empty$ 'skip$ { organization present field } if$
  publisher present field finish.with.note
}

FUNCTION {misc}
{ begin.item author.line write.date
  title empty$ howpublished empty$ and 'skip$ 'block if$
  quoted.title "title" required field
  howpublished empty$ 'skip$ 'block if$
  howpublished present space.field note present space.field finish.item
}

FUNCTION {unpublished}
{ begin.item author.line date.line quoted.title "title" required field block
  note present "note" required space.field finish.item
}

FUNCTION {webpage}
{ begin.item author.line write.date
  title empty$ url empty$ and 'skip$ 'block if$
  quoted.title field
  url empty$ 'skip$ 'block if$
  url present "url" required
  duplicate$ empty$ 'skip$ { "\texttt{" swap$ * "}" * } if$
  space.field finish.with.note
}

FUNCTION {default.type} { misc }

% Standard aliases from BibTeX's plain.bst, version 0.99b.
% Copyright (C) 1984, 1985, 1988, 2010 Howard Trickey and Oren Patashnik.
% Modified redistribution is permitted under a different filename.
% See THIRD_PARTY_NOTICES.md for the original source and terms.
MACRO {jan} {"January"}

MACRO {feb} {"February"}

MACRO {mar} {"March"}

MACRO {apr} {"April"}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"August"}

MACRO {sep} {"September"}

MACRO {oct} {"October"}

MACRO {nov} {"November"}

MACRO {dec} {"December"}

MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

READ

FUNCTION {initialize}
{ #0 'counter := #0 'suffix.next := "" 'previous.group := }

EXECUTE {initialize}
ITERATE {prepare}
SORT
ITERATE {assign.suffixes}
REVERSE {mark.first.suffix}
SORT

FUNCTION {begin.bibliography}
{ preamble$ empty$ 'skip$ { preamble$ write$ newline$ } if$
  "\begin{thebibliography}{}" write$ newline$
}

FUNCTION {end.bibliography}
{ newline$ "\end{thebibliography}" write$ newline$ }

EXECUTE {begin.bibliography}
ITERATE {call.type$}
EXECUTE {end.bibliography}
