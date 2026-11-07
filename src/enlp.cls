%%
%% This is file `enlp.cls',
%% Academic thesis class for Ehime University NLP Lab
%%
%% Author: Eito Yoneyama
%% Created: 2025/11/20
%% Updated: 2026/11/08
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{enlp}[2026/11/08 v1.1.0 Academic thesis class for Ehime Univ. NLP Lab (based on jlreq)]

% Keep the thesis layout while inheriting the Japanese typesetting machinery
% and standard LaTeX environments from jlreq.
\RequirePackage{ifptex}
\RequirePackage{iftex}

\newif\if@ldebug
\newcommand*{\enlp@loadbibliography}{\RequirePackage{enlp-bibtex}}
\DeclareOption{ldebug}{\@ldebugtrue}
\DeclareOption{biblatex}{%
  \renewcommand*{\enlp@loadbibliography}{\RequirePackage[backend=biber,style=enlp]{biblatex}}}
\DeclareOption{leqno}{\PassOptionsToClass{leqno}{jlreq}}
\DeclareOption{fleqn}{\PassOptionsToClass{fleqn}{jlreq}}
\DeclareOption{disablejfam}{\PassOptionsToClass{disablejfam}{jlreq}}
\DeclareOption{draft}{\PassOptionsToClass{draft}{jlreq}}
\DeclareOption{final}{\PassOptionsToClass{final}{jlreq}}
\DeclareOption*{}
\ProcessOptions\relax

\PassOptionsToPackage{nomath}{lmodern}
\ifpTeX
  \RequirePackage{plautopatch}
  % The pTeX patch must take precedence over the kernel's endtabular fix.
  \DeclareHookRule{package/arydshln/after}{firstaid}{before}{plautopatch}
  \edef\enlp@kanjiskip{\the\kanjiskip}
  \edef\enlp@xkanjiskip{\the\xkanjiskip}
\fi
\let\enlp@tabular\tabular
\let\enlp@endtabular\endtabular
\NewCommandCopy\enlp@kernel@fnmark\@makefnmark
\LoadClass[article,paper=a4paper,twoside,fontsize=12pt,baselineskip=19pt,
  open_bracket_pos=zenkakunibu_nibu]{jlreq}

% Retain normal table row spacing and the kernel interfaces patched by array
% and arydshln in existing theses.
\let\tabular\enlp@tabular
\let\endtabular\enlp@endtabular
\ifpTeX
  \renewcommand{\rmdefault}{cmr}
  \renewcommand{\sfdefault}{cmss}
  \renewcommand{\ttdefault}{cmtt}
\fi

% Use the previous Japanese font metrics and spacing within the jlreq class.
% A different fullwidth advance would reflow both body text and tables.
\ifLuaTeX
  \DeclareFontShape{JY3}{mc}{m}{n}{<->s*[0.962216]\ltj@stdmcfont:-kern;jfm=ujis}{}
  \DeclareFontShape{JY3}{gt}{m}{n}{<->s*[0.962216]\ltj@stdgtfont:-kern;jfm=ujis}{}
  % jlreq has already selected its 12 pt Japanese font during class loading.
  \expandafter\let\csname JY3/mc/m/n/12\endcsname\relax
  \ltjenableadjust[lineend=false,priority=false]
  \renewcommand{\jlreqkanjiskip}{0pt plus .4pt minus .5pt}
  \renewcommand{\jlreqxkanjiskip}{2.40554pt plus 1pt minus 1pt}
\else
  \ifstrictuplatex
    \DeclareFontShape{JY2}{mc}{m}{n}{<->s*[1.039] upjisr-h}{}
    \DeclareFontShape{JY2}{gt}{m}{n}{<->s*[1.039] upjisg-h}{}
  \else
    \DeclareFontShape{JY1}{mc}{m}{n}{<->s*[1.039] jis}{}
    \DeclareFontShape{JY1}{gt}{m}{n}{<->s*[1.039] jisg}{}
  \fi
  \renewcommand{\jlreqkanjiskip}{\enlp@kanjiskip}
  \renewcommand{\jlreqxkanjiskip}{\enlp@xkanjiskip}
\fi
\normalfont

\RequirePackage{enlp-logo}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{tikz}
\RequirePackage{bxpapersize}
\ifpTeX
  \PassOptionsToPackage{dvipdfmx}{hyperref}
\fi
\RequirePackage[setpagesize=false,bookmarksnumbered,colorlinks,
  linkcolor=black,citecolor=black,urlcolor=black]{hyperref}
\ifpTeX
  \RequirePackage{pxjahyper}
\fi

% Thesis layout shared by the BibTeX and biblatex bibliography lists.
\let\enlp@bibliographytitle\refname
\newlength{\bibleftmargin}
\newlength{\bibitemindent}
% Keep the bibliography indentation based on the previous 10 pt font.
\setlength{\bibleftmargin}{19.24432pt}
\setlength{\bibitemindent}{-4.81108pt}
\newcommand*{\enlp@bibliographyheading}[1]{%
  \csection*{#1}%
  \addcontentsline{toc}{section}{#1}}
\newcommand*{\enlp@bibliographylist}[1]{%
  \settowidth{\labelwidth}{#1}%
  \setlength{\leftmargin}{\bibleftmargin}%
  \setlength{\itemindent}{\bibitemindent}}
\newcommand*{\enlp@bibliographyparagraphs}{%
  \sloppy\clubpenalty4000\widowpenalty4000\relax}

\enlp@loadbibliography
\if@ldebug
  \ifLuaTeX
    \RequirePackage{lua-visual-debug}
  \fi
\fi

%% ===============================================
%% Size and layout settings
%% ===============================================
% Display skips are part of the thesis typography at each text size.
\newcommand*{\enlp@displayskips}[3]{%
  \setlength{\abovedisplayskip}{#1}%
  \setlength{\belowdisplayskip}{#1}%
  \setlength{\abovedisplayshortskip}{#2}%
  \setlength{\belowdisplayshortskip}{#3}}
\renewcommand{\normalsize}{%
  \@setfontsize\normalsize{12pt}{19pt}%
  \enlp@displayskips{11pt plus 3pt minus 6pt}{0pt plus 3pt}{6.5pt plus 3.5pt minus 3pt}%
  \let\@listi\@listI}
\renewcommand{\small}{%
  \@setfontsize\small\@xipt{17pt}%
  \enlp@displayskips{9pt plus 3pt minus 4pt}{0pt plus 2pt}{5pt plus 2pt minus 2pt}%
  \def\@listi{\enlp@compactlist{5pt plus 2pt minus 2pt}}}
\renewcommand{\footnotesize}{%
  \@setfontsize\footnotesize{10pt}{15pt}%
  \enlp@displayskips{6pt plus 2pt minus 2pt}{0pt plus 1pt}{3pt plus 1pt minus 1pt}%
  \def\@listi{\enlp@compactlist{3pt plus 2pt minus 2pt}}}
\newcommand*{\enlp@compactlist}[1]{%
  \@listI
  \setlength{\topsep}{#1}%
  \setlength{\parsep}{2pt plus 1pt minus 1pt}%
  \setlength{\itemsep}{\parsep}}

\normalsize
\settowidth{\Cwd}{　}
\settoheight{\Cht}{　}
\settodepth{\Cdp}{　}
\setlength{\Chs}{\Cwd}
\setlength{\Cvs}{\baselineskip}
\renewcommand{\jlreqparindent}{\Cwd}

\renewcommand{\tiny}{\@setfontsize\tiny\@vipt{7}} % 6pt / 7pt
\renewcommand{\scriptsize}{\@setfontsize\scriptsize\@viiipt{10}} % 8pt / 10pt
\renewcommand{\large}{\@setfontsize\large\@xivpt{25}} % 14pt / 25pt
\renewcommand{\Large}{\@setfontsize\Large\@xviipt{30}} % 17pt / 30pt
\renewcommand{\LARGE}{\@setfontsize\LARGE\@xxpt{35}} % 20pt / 35pt
\renewcommand{\huge}{\@setfontsize\huge\@xxvpt{40}} % 25pt / 40pt
\renewcommand{\Huge}{\@setfontsize\Huge{30}{45}} % 30pt / 45pt

% jlreq rounds line_length to whole Japanese characters. Use the original
% 460 pt measure, centered on the paper, for existing figures and paragraphs.
\setlength\textwidth{460pt}
\setlength\oddsidemargin{\dimexpr(\paperwidth-\textwidth)/2-1in\relax}
\@settopoint\oddsidemargin
\setlength\evensidemargin{\oddsidemargin}
\setlength\headheight{12pt}
\setlength\headsep{25pt}
\setlength\topmargin{\dimexpr25mm-1in\relax}
\@settopoint\topmargin
\setlength\topskip{\Cht}
\setlength\textheight{\dimexpr32\Cvs+\topskip\relax}
\@settopoint\textheight
\setlength\footskip{48pt}
\setlength\maxdepth{4pt}
\setlength\marginparwidth{0pt}
\setlength\marginparsep{0pt}
\setlength\marginparpush{0pt}

% Set the footnote gap and float spacing from the body grid.
\setlength{\footnotesep}{7pt}
\newdimen\enlp@insertgap
\setlength{\enlp@insertgap}{\dimexpr\Cvs-\Cht+\footnotesep\relax}
\setlength{\skip\footins}{\enlp@insertgap plus \Cvs}
\setlength{\floatsep}{17pt}
\setlength{\textfloatsep}{2\enlp@insertgap plus \enlp@insertgap minus \enlp@insertgap}
\setlength{\intextsep}{\textfloatsep}
\setlength{\@fptop}{0pt}
\setlength{\@fpsep}{\floatsep}
\setlength{\@fpbot}{0pt plus 1fil}
\setcounter{totalnumber}{5}
\setcounter{topnumber}{4}
\setcounter{bottomnumber}{4}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.5}
\renewcommand{\topfraction}{0.9}
\renewcommand{\bottomfraction}{0.9}

\setlength{\parindent}{\Cwd}
\setlength{\parskip}{0pt plus 1pt}
\setlength{\columnsep}{20pt}
\setlength{\columnseprule}{0pt}
\setlength{\lineskip}{1pt}
\setlength{\normallineskip}{\lineskip}
\linespread{1}
\@lowpenalty=51
\@medpenalty=151
\@highpenalty=301

\NewPageStyle{mainpage}{nombre_position=bottom-center,nombre_font=\mdseries}

%% ===============================================
%% Metadata definitions (Standard commands + Custom)
%% ===============================================
% Thesis metadata and front matter order.
\ExplSyntaxOn
\bool_new:N \g__enlp_title_done_bool
\bool_new:N \g__enlp_abstract_done_bool
\tl_new:N \g__enlp_thesis_tl
\tl_new:N \g__enlp_teacher_tl
\tl_new:N \g__enlp_institute_tl

\msg_new:nnn { enlp } { missing-metadata } { No~#1~given. }
\msg_new:nnnn { enlp } { front-matter-order }
  { #1~must~be~used~after~#2. }
  { Use~\token_to_str:N \maketitle,~the~abstract~environment,~
    and~\token_to_str:N \tableofcontents~in~that~order. }

\tl_gset:Nn \g__enlp_thesis_tl
  { \msg_warning:nne { enlp } { missing-metadata } { \token_to_str:N \thesis } }
\tl_gset:Nn \g__enlp_teacher_tl
  { \msg_warning:nne { enlp } { missing-metadata } { \token_to_str:N \teacher } }
\tl_gset:Nn \g__enlp_institute_tl
  { \msg_warning:nne { enlp } { missing-metadata } { \token_to_str:N \institute } }

\NewDocumentCommand \thesis { m } { \tl_gset:Nn \g__enlp_thesis_tl {#1} }
\NewDocumentCommand \teacher { m } { \tl_gset:Nn \g__enlp_teacher_tl {#1} }
\NewDocumentCommand \institute { m } { \tl_gset:Nn \g__enlp_institute_tl {#1} }

\cs_new:Npn \enlp@thesis { \tl_use:N \g__enlp_thesis_tl }
\cs_new:Npn \enlp@teacher { \tl_use:N \g__enlp_teacher_tl }
\cs_new:Npn \enlp@institute { \tl_use:N \g__enlp_institute_tl }

\RenewDocumentCommand \maketitle { }
  {
    \bool_if:NF \g__enlp_title_done_bool
      {
        \enlp@maketitlepage
        \bool_gset_true:N \g__enlp_title_done_bool
      }
  }

\cs_new_protected:Npn \enlp@checktitle
  {
    \bool_if:NF \g__enlp_title_done_bool
      {
        \msg_error:nnee { enlp } { front-matter-order }
          { The~abstract~environment } { \token_to_str:N \maketitle }
      }
  }

\cs_new_protected:Npn \enlp@checkabstract
  {
    \bool_if:NF \g__enlp_abstract_done_bool
      {
        \msg_error:nnee { enlp } { front-matter-order }
          { \token_to_str:N \tableofcontents } { the~abstract~environment }
      }
  }

\cs_new_protected:Npn \enlp@finishabstract
  { \bool_gset_true:N \g__enlp_abstract_done_bool }
\cs_new:Npn \enlp@coverfnnumber
  { \prg_replicate:nn { \int_min:nn { \value{footnote} } {4} } {*} }
\ExplSyntaxOff

\newcommand{\enlp@footnotebody}[2]{%
  \setlength{\leftskip}{\glueexpr\leftskip+14pt\relax}%
  \setlength{\parindent}{\Cwd}%
  \noindent\makebox[0pt][r]{#1\nobreakspace}#2}

\newcommand*{\enlp@maketitlepage}{%
  \clearpage
  \begingroup
    \let\thefootnote\enlp@coverfnnumber
    \renewcommand\@makefntext[1]{%
      \enlp@footnotebody{\textsuperscript{\normalfont\@thefnmark}}{##1}}%
    \thispagestyle{empty}%
    \global\@topnum=0\relax
    \@thanks
    \enlp@covercontent
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\@thanks\@empty
  \global\let\thanks\relax
}

\newcommand*{\enlp@covercontent}{%
  \setlength{\leftskip}{25pt}%
  \setlength{\rightskip}{\leftskip}%
  \setlength{\parindent}{0pt}%
  \vspace{8pt}%
  \begin{center}
    \let\footnote\thanks
    \vspace*{40pt}
    
    {\fontsize{20pt}{25pt}\selectfont \enlp@thesis \par}

    \vspace{30pt}
    
    \parbox{\textwidth}{%
      \centering
      \vspace{15pt}
      {\bfseries\fontsize{25pt}{35pt}\selectfont {\bfseries \@title} \par}
    }
    
    \vspace{70pt}
    
    \parbox{\textwidth}{%
      \centering
      \fontsize{16pt}{24pt}\selectfont
      \enlp@institute \par
      \vspace{10pt}
      \@author \par
    }
    
    \vspace{70pt}
    
    \parbox{\textwidth}{%
      \centering
      \fontsize{16pt}{24pt}\selectfont
      指導教員 \par
      \vspace{5pt}
      \begin{tabular}[t]{c}%
        \enlp@teacher
      \end{tabular}%
    }
    
    \vspace{40pt}
    
    {\fontsize{16pt}{24pt}\selectfont
     \@date 
      \begin{tikzpicture}[remember picture, overlay]
          \node[anchor=south west, xshift=1cm, yshift=1.25cm] at (current page.south west) {\elogo[scale=1]};
      \end{tikzpicture}%
    \par}
  \end{center}
  \clearpage
}

\renewcommand{\thefootnote}{\arabic{footnote}}
\renewcommand{\@makefnmark}{%
  \kern0pt\raisebox{0.3ex}{\enlp@kernel@fnmark}%
}

%% ===============================================
%% Table of Contents and Sections
%% ===============================================
\providecommand{\phantomsection}{}
\renewcommand{\tableofcontents}{%
  \enlp@checkabstract
  \phantomsection
  \csection*{\contentsname}%
  \@mkboth{\contentsname}{\contentsname}%
  \@starttoc{toc}%
}

\renewenvironment{abstract}{%
  \enlp@checktitle
  \csection*{\absttitle}%
  \begin{center}%
    \begin{minipage}{0.9\textwidth}%
      \setlength{\parindent}{1\zw}% 
}{%
    \end{minipage}%
  \end{center}%
  \setcounter{page}{1}%
  \enlp@finishabstract
}

\setcounter{secnumdepth}{3}
\renewcommand*{\@seccntformat}[1]{\csname the#1\endcsname\quad}

% Chapters start a fresh page. A separate renderer keeps the centered
% front-matter headings on the same typographic grid.
\newcommand*{\enlp@chapterlabel}{第 \thesection\hspace{1pt} 章 \hspace{7pt}}
\newcommand*{\enlp@chaptertoclabel}{第\thesection 章}
\newcommand*{\enlp@sectionlabel}{\enlp@chapterlabel}
\newcommand*{\enlp@sectiontoclabel}{\enlp@chaptertoclabel}
\newcommand*{\enlp@startheading}{%
  \par\addvspace{1.3\Cvs}%
  \@afterindenttrue
  \clearpage
  \global\@topnum=0\relax}
\newcommand*{\enlp@headingfont}{\fontsize{18pt}{22pt}\selectfont\bfseries}
\newcommand*{\enlp@printheading}[4]{%
  \begingroup
    \setlength{\parindent}{0pt}%
    #1%
    \interlinepenalty=10000
    \reset@font
    \IfBlankF{#2}{{\enlp@headingfont#2}\space}%
    \enlp@headingfont#3\par
  \endgroup
  \vskip#4\relax
  \nobreak\vskip0.7\Cvs\@afterheading}
\newcommand*{\enlp@numberedheading}[5]{%
  \ifnum\value{secnumdepth}>0
    \refstepcounter{section}%
    \addcontentsline{toc}{section}{\protect\numberline{#3}#4}%
    \enlp@printheading{#1}{#2}{#5}{14pt}%
  \else
    \addcontentsline{toc}{section}{#4}%
    \enlp@printheading{#1}{}{#5}{14pt}%
  \fi}
\RenewDocumentCommand\section{s o m}{%
  \enlp@startheading
  \IfBooleanTF{#1}
    {\phantomsection\enlp@printheading{\raggedright}{}{#3}{0pt}}%
    {\IfNoValueTF{#2}
      {\enlp@numberedheading{\raggedright}{\enlp@sectionlabel}{\enlp@sectiontoclabel}{#3}{#3}}%
      {\enlp@numberedheading{\raggedright}{\enlp@sectionlabel}{\enlp@sectiontoclabel}{#2}{#3}}}}
\NewDocumentCommand\csection{s o m}{%
  \enlp@startheading
  \IfBooleanTF{#1}
    {\phantomsection\enlp@printheading{\centering}{}{#3}{14pt}}%
    {\IfNoValueTF{#2}
      {\enlp@numberedheading{\centering}{\enlp@chapterlabel}{\enlp@chaptertoclabel}{#3}{#3}}%
      {\enlp@numberedheading{\centering}{\enlp@chapterlabel}{\enlp@chaptertoclabel}{#2}{#3}}}}
\renewcommand{\subsection}{%
  \@startsection{subsection}{2}{\z@}%
    {.9\Cvs \@plus.4\Cvs \@minus.2\Cvs}%
    {.1\Cvs \@minus0.1\Cvs}%
    {\reset@font\Large\bfseries}%
}
\renewcommand{\subsubsection}{%
  \@startsection{subsubsection}{3}{\z@}%
    {.9\Cvs \@plus.4\Cvs \@minus.2\Cvs}%
    {.1\Cvs \@minus0.1\Cvs}%
    {\reset@font\large\bfseries}%
}
\renewcommand{\paragraph}{%
  \@startsection{paragraph}{4}{\z@}%
    {\z@}{-10pt}{\reset@font\normalsize\bfseries}%
}
\renewcommand{\subparagraph}{%
  \@startsection{subparagraph}{5}{\z@}%
    {\z@}{-10pt}{\reset@font\normalsize\bfseries}%
}

\renewcommand{\appendix}{%
  \par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \renewcommand{\thesection}{\Alph{section}}%
  \renewcommand{\theHsection}{Appendix.\thesection}%
  \renewcommand*{\enlp@sectionlabel}{\thesection\hspace{1\zw}}%
  \renewcommand*{\enlp@sectiontoclabel}{\thesection}}

%% ===============================================
%% List and Figure/Table settings
%% ===============================================
\setlength{\emergencystretch}{3\zw}
\ExplSyntaxOn
\clist_map_inline:nn { i, ii, iii, iv, v, vi }
  { \setlength{\use:c {leftmargin#1}}{3\Cwd} }
\clist_map_inline:nn { i, ii, iii, iv }
  { \cs_set:cpn {labelenum#1} {(\use:c {theenum#1})} }
\ExplSyntaxOff
\jlreqsetup{
  itemization_beforeafter_space=0pt,
  itemization_itemsep=0pt,
  itemization_labelsep=\Cwd,
  itemization_label_length=2\Cwd,
}
\@beginparpenalty=-\@lowpenalty
\@endparpenalty=-\@lowpenalty
\@itempenalty=-\@lowpenalty
\renewcommand{\labelitemi}{\textbullet}
\renewcommand{\labelitemii}{\normalfont\bfseries\textendash}
\renewcommand{\labelitemiii}{\textasteriskcentered}
\renewcommand{\labelitemiv}{\textperiodcentered}

% Keep the label styling when the manuscript supplies its own caption package.
\renewcommand{\fnum@figure}{\textbf{\figurename~\thefigure}}
\renewcommand{\fnum@table}{\textbf{\tablename~\thetable}}
\renewcommand{\fps@figure}{tbp}
\renewcommand{\fps@table}{tbp}
\jlreqsetup{
  caption_font=\small,
  caption_label_font=\bfseries,
  caption_after_label_space=\Cwd,
  caption_align={center,*left},
}
\setlength{\abovecaptionskip}{8pt}
\setlength{\belowcaptionskip}{0pt}
\g@addto@macro\@floatboxreset{\small}
\setlength{\arraycolsep}{0.5\Cwd}
\setlength{\tabcolsep}{\arraycolsep}
\setlength{\fboxsep}{\arraycolsep}
\setlength{\arrayrulewidth}{0.25pt}
\setlength{\fboxrule}{\arrayrulewidth}
\setlength{\doublerulesep}{2pt}
\setlength{\tabbingsep}{\Cwd}
\setlength{\skip\@mpfootins}{\skip\footins}

%% ===============================================
%% Table of Contents format
%% ===============================================
\setcounter{tocdepth}{3}
\renewcommand{\@pnumwidth}{2\Cwd}
\renewcommand{\@tocrmarg}{3\Cwd}
\renewcommand{\@dotsep}{4.5}
\newcommand*{\enlp@tocpagefont}{\normalfont\normalcolor}
\newcommand*{\enlp@tocrow}[4]{%
  \begingroup
    \setlength{\@lnumwidth}{#2}%
    \setlength{\leftskip}{\dimexpr#1+#2\relax}%
    \setlength{\rightskip}{\@tocrmarg}%
    \setlength{\parfillskip}{-\rightskip}%
    \interlinepenalty=10000
    \noindent\hspace*{-#2}#3\nobreak
    \leaders\hbox{$\m@th\mkern\@dotsep mu.\mkern\@dotsep mu$}\hfill\nobreak
    \makebox[\@pnumwidth][r]{\enlp@tocpagefont#4}\par
  \endgroup}
\newcommand*{\enlp@tocline}[5]{%
  \ifnum#1>\value{tocdepth}\else
    \vskip 0pt plus .2pt
    \enlp@tocrow{#2}{#3}{#4}{#5}%
  \fi}
\renewcommand*{\l@section}[2]{%
  \ifnum\value{tocdepth}>0
    \addpenalty{\@secpenalty}%
    \addvspace{0.5\Cvs}%
    \begingroup
      \bfseries
      \let\enlp@tocpagefont\relax
      \let\@tocrmarg\@pnumwidth
      \enlp@tocrow{0pt}{5.5\Cwd}{#1\hspace{1\zw}}{#2}%
    \endgroup
  \fi}
\renewcommand*{\l@subsection}{\enlp@tocline{2}{\Cwd}{2\Cwd}}
\renewcommand*{\l@subsubsection}{\enlp@tocline{3}{3\Cwd}{3\Cwd}}
\renewcommand*{\l@paragraph}{\enlp@tocline{4}{6\Cwd}{4\Cwd}}
\renewcommand*{\l@subparagraph}{\enlp@tocline{5}{6\Cwd}{4\Cwd}}
\renewcommand*{\l@figure}{\enlp@tocline{1}{1.5em}{2.3em}}
\let\l@table\l@figure

%% ===============================================
%% Other environments (Acknowledgments, Publications, etc.)
%% ===============================================
\renewcommand{\footnoterule}{%
  \vbox to 0pt{\vss\hrule width .4\columnwidth height .4pt\kern 2.6pt}}
\renewcommand\@makefntext[1]{%
  \samepage
  \enlp@footnotebody{\@makefnmark}{#1}}

\newenvironment{acknowledgment}{%
  \clearpage
  \csection*{\acknowledgtitle}%
  \addcontentsline{toc}{section}{\acknowledgtitle}%
}{}

\newenvironment{publication}{%
  \clearpage
  {\csection*{\publicationtitle} \vskip 0.5\baselineskip}%
  \addcontentsline{toc}{section}{\publicationtitle}
}{}

%% ===============================================
%% Japanese name definitions
%% ===============================================
\newcommand{\absttitle}{概要}
\newcommand{\acknowledgtitle}{謝辞}
\newcommand{\publicationtitle}{対外発表・論文・受賞等}

\clubpenalty0
\widowpenalty0

\linespread{1.2}
\pagestyle{mainpage}
\pagenumbering{arabic}
\raggedbottom
\onecolumn

\endinput
