%%
%% This is file `enlp.cls',
%% Academic thesis class for Ehime University NLP Lab
%%
%% Author: Eito Yoneyama
%% Created: 2025/11/20
%% Updated: 2026/02/24

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{enlp}[2026/02/24 v1.0.7 Academic thesis class for Ehime Univ. NLP Lab (based on jlreq)]

% Keep the thesis layout while inheriting the Japanese typesetting machinery
% and standard LaTeX environments from jlreq.
\RequirePackage{ifptex}
\RequirePackage{iftex}

\newif\if@ldebug
\newcommand*{\enlp@loadbibliography}{\RequirePackage{enlpbbl}}
\DeclareOption{ldebug}{\@ldebugtrue}
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


\enlp@loadbibliography
\if@ldebug
  \ifLuaTeX
    \RequirePackage{lua-visual-debug}
  \fi
\fi

%% ===============================================
%% Size and layout settings
%% ===============================================
\renewcommand{\normalsize}{%
  \@setfontsize\normalsize\@xiipt{19}% 12pt / 19pt
  \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI
}
\normalsize
\setbox\@tempboxa\hbox{　}
\setlength\Cht{\ht\@tempboxa}
\setlength\Cdp{\dp\@tempboxa}
\setlength\Cwd{\wd\@tempboxa}
\setlength\Chs{\Cwd}
\setlength\Cvs{\baselineskip}
\renewcommand{\jlreqparindent}{\Cwd}

\renewcommand{\small}{%
  \@setfontsize\small\@xipt{17}% 11pt / 17pt
  \abovedisplayskip 9\p@ \@plus3\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus2\p@
  \belowdisplayskip \abovedisplayskip
  \belowdisplayshortskip 5\p@ \@plus2\p@ \@minus2\p@
  \def\@listi{\leftmargin\leftmargini
              \topsep 5\p@ \@plus2\p@ \@minus2\p@
              \parsep 2\p@ \@plus\p@ \@minus\p@
              \itemsep \parsep}%
}

\renewcommand{\footnotesize}{%
  \@setfontsize\footnotesize\@xpt{15}% 10pt / 15pt
  \abovedisplayskip 6\p@ \@plus2\p@ \@minus2\p@
  \abovedisplayshortskip \z@ \@plus1\p@
  \belowdisplayskip \abovedisplayskip
  \belowdisplayshortskip 3\p@ \@plus\p@ \@minus\p@
  \def\@listi{\leftmargin\leftmargini
              \topsep 3\p@ \@plus\p@ \@minus\p@
              \parsep 2\p@ \@plus\p@ \@minus\p@
              \itemsep \parsep}%
}

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

\setlength\footnotesep{7\p@}
\setlength\@tempdima{1\Cvs}\addtolength\@tempdima{-1\Cht}\addtolength\@tempdima{7\p@}
\setlength{\skip\footins}{\@tempdima \@plus 1\Cvs \@minus \z@}
\setlength\floatsep{17\p@}
\setlength\textfloatsep{2\@tempdima \@plus \@tempdima \@minus \@tempdima}
\setlength\intextsep{2\@tempdima \@plus \@tempdima \@minus \@tempdima}
\setlength\@fptop{0\p@}
\setlength\@fpsep{17\p@}
\setlength\@fpbot{0\p@ \@plus 1fil}

\setlength\partopsep{\z@}
\def\@listi{
  \leftmargin\leftmargini
  \parsep \z@
  \topsep \z@
  \itemsep \z@
}
\let\@listI\@listi
\@listi
\def\@listii{
  \leftmargin\leftmarginii
  \labelwidth\leftmarginii \advance\labelwidth-\labelsep
  \topsep  \z@
  \parsep  \z@
  \itemsep\parsep
}
\def\@listiii{
  \leftmargin\leftmarginiii
  \labelwidth\leftmarginiii \advance\labelwidth-\labelsep
  \topsep \z@
  \parsep\z@
  \partopsep \z@
  \itemsep\topsep
}
\def\@listiv{
  \leftmargin\leftmarginiv
  \labelwidth\leftmarginiv\advance\labelwidth-\labelsep
}
\def\@listv{
  \leftmargin\leftmarginv
  \labelwidth\leftmarginv\advance\labelwidth-\labelsep
}
\def\@listvi{
  \leftmargin\leftmarginvi
  \labelwidth\leftmarginvi\advance\labelwidth-\labelsep
}

\setlength\columnsep{20\p@}
\setlength\columnseprule{0\p@}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand{\baselinestretch}{}
\setlength\parskip{0\p@ \@plus \p@}
\setlength\parindent{1\Cwd}

\@lowpenalty 51
\@medpenalty 151
\@highpenalty 301
\setcounter{topnumber}{4}
\setcounter{bottomnumber}{4}
\setcounter{totalnumber}{5}
\renewcommand{\topfraction}{.9}
\renewcommand{\bottomfraction}{.9}
\renewcommand{\textfraction}{.1}
\renewcommand{\floatpagefraction}{.5}

%% ===============================================
%% Headers and Footers
%% ===============================================
\def\ps@mainpage{%
  \let\@mkboth\markboth
  \def\@oddhead{}
  \def\@oddfoot{\hfil{\mdseries\thepage}\hfil}
  \def\@evenhead{}
  \def\@evenfoot{\hfil{\mdseries\thepage}\hfil}
}

\def\ps@frontpage{%
  \let\@mkboth\markboth
  \def\@oddhead{}
  \def\@oddfoot{}%
  \def\@evenhead{}
  \def\@evenfoot{}%
}

%% ===============================================
%% Metadata definitions (Standard commands + Custom)
%% ===============================================
\def\p@thanks#1{%
  \footnotemark
  \protected@xdef\@thanks{%
    \@thanks
    \protect{\noindent$\m@th^\thefootnote$~#1\protect\par}
  }%
}

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
\ExplSyntaxOff

\newlength{\@FMwidth}\setlength{\@FMwidth}{14pt}

\def\enlp@maketitlepage{%
  \par
  \begingroup
  \def\thefootnote{\ifcase\c@footnote\or *\or ** \or *** \else **** \fi}
  \def\@makefnmark{\kern0pt\raisebox{0.3ex}{\@textsuperscript{\normalfont \@thefnmark}}}%
    \renewcommand\@makefntext[1]{%
      \advance\leftskip\@FMwidth
      \parindent 1\Cwd\noindent\llap{\@textsuperscript{\normalfont \@thefnmark}~}##1
    }
    \clearpage
    \global\@topnum\z@
    \thispagestyle{frontpage}\@thanks
    \@maketitle
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\@thanks\@empty
  \global\let\p@thanks\@empty
}

\def\@maketitle{%
  \clearpage
  \parindent\z@
  \vskip 8pt
  \setlength{\leftskip}{25pt}\setlength{\rightskip}{25pt}
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
  \kern0pt\raisebox{0.3ex}{\@textsuperscript{\normalfont\@thefnmark}}%
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

\renewcommand{\section}{%
  \par\addvspace{1.3\Cvs}%
  \@afterindenttrue
  \secdef\@section\@ssection
}
\def\@section[#1]#2{%
  \clearpage
  \global\@topnum\z@
  \ifnum \c@secnumdepth >\z@
    \refstepcounter{section}%
    \addcontentsline{toc}{section}{\protect\numberline{第\thesection 章}#1}
  \else
    \addcontentsline{toc}{section}{#1}%
  \fi
  \begingroup
  \parindent\z@\raggedright
  \interlinepenalty\@M\reset@font
  \ifnum \c@secnumdepth >\z@
    {\fontsize{18pt}{22pt}\selectfont \bfseries 第 \thesection\hspace{1pt} 章 \hspace{7pt}\ignorespaces}
  \fi
  \fontsize{18pt}{22pt}\selectfont\bfseries#2\par
  \endgroup
  \vskip 14pt
  \nobreak\vskip0.7\Cvs\@afterheading
}
\def\@ssection[#1]#2{%
  \clearpage
  \phantomsection
  \global\@topnum\z@
  \begingroup
  \parindent\z@\raggedright
  \interlinepenalty\@M\reset@font
  \fontsize{18pt}{22pt}\selectfont\bfseries#1\par
  \endgroup
  \nobreak\vskip0.7\Cvs\@afterheading
}
\newcommand{\csection}{%
  \par\addvspace{1.3\Cvs}%
  \@afterindenttrue
  \secdef\@csection\@scsection
}
\def\@csection[#1]#2{%
  \clearpage
  \global\@topnum\z@
  \ifnum \c@secnumdepth >\z@
    \refstepcounter{section}%
    \addcontentsline{toc}{section}{\protect\numberline{第\thesection 章}#1}%
  \else
    \addcontentsline{toc}{section}{#1}%
  \fi
  \begingroup
    \parindent\z@
    \centering
    \interlinepenalty\@M\reset@font
    \ifnum \c@secnumdepth >\z@
      {\fontsize{18pt}{22pt}\selectfont \bfseries 第 \thesection\hspace{1pt} 章 \hspace{7pt}\ignorespaces}
    \fi
    \fontsize{18pt}{22pt}\selectfont\bfseries#2\par
  \endgroup
  \vskip 14pt
  \nobreak\vskip0.7\Cvs\@afterheading
}
\def\@scsection#1{%
  \clearpage
  \phantomsection
  \global\@topnum\z@
  \begingroup
    \parindent\z@
    \centering
    \interlinepenalty\@M\reset@font
    \fontsize{18pt}{22pt}\selectfont\bfseries#1\par
  \endgroup
  \vskip 14pt
  \nobreak\vskip0.7\Cvs\@afterheading
}
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
  \renewcommand{\thesection}{\@Alph\c@section}%
  \renewcommand{\theHsection}{Appendix.\thesection}%
  \def\@section[##1]##2{%
    \clearpage
    \global\@topnum\z@
    \ifnum \c@secnumdepth >\z@
      \refstepcounter{section}%
      \addcontentsline{toc}{section}{\protect\numberline{\thesection}##1}%
    \else
      \addcontentsline{toc}{section}{##1}%
    \fi
    \begingroup
      \parindent\z@\raggedright
      \interlinepenalty\@M\reset@font
      \ifnum \c@secnumdepth >\z@
        {\fontsize{18pt}{22pt}\selectfont \bfseries \thesection \hspace{1\zw}\ignorespaces}
      \fi
      \fontsize{18pt}{22pt}\selectfont\bfseries##2\par
    \endgroup
    \vskip 14pt
    \nobreak\vskip0.7\Cvs\@afterheading
  }%
}

%% ===============================================
%% List and Figure/Table settings
%% ===============================================
\setlength{\emergencystretch}{3\zw}
\setlength\leftmargini{3\Cwd}
\setlength\leftmarginii{3\Cwd}
\setlength\leftmarginiii{3\Cwd}
\setlength\leftmarginiv{3\Cwd}
\setlength\leftmarginv{3\Cwd}
\setlength\leftmarginvi{3\Cwd}
\setlength\labelsep{1\Cwd}
\setlength\labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty-\@lowpenalty
\@endparpenalty-\@lowpenalty
\@itempenalty-\@lowpenalty
\renewcommand{\labelenumi}{(\theenumi)}
\renewcommand{\labelenumii}{(\theenumii)}
\renewcommand{\labelenumiii}{(\theenumiii)}
\renewcommand{\labelenumiv}{(\theenumiv)}
\renewcommand{\labelitemi}{\textbullet}
\renewcommand{\labelitemii}{\normalfont\bfseries\textendash}
\renewcommand{\labelitemiii}{\textasteriskcentered}
\renewcommand{\labelitemiv}{\textperiodcentered}

% Figure and table captions.
\def\fnum@figure{\textbf{\figurename~\thefigure}}
\def\fnum@table{\textbf{\tablename~\thetable}}
\def\fps@figure{tbp}
\def\fps@table{tbp}
\setlength\abovecaptionskip{8\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \small
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1\hskip1\Cwd#2}%
  \ifdim \wd\@tempboxa >\hsize
    #1\hskip1\Cwd#2\relax\par
  \else
    \global \@minipagefalse
    \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip
}
\def\@floatboxreset{\reset@font\small\@setminipage}

\setlength\arraycolsep{0.5\Cwd}
\setlength\tabcolsep{0.5\Cwd}
\setlength\arrayrulewidth{0.25\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{0.5\Cwd}
\setlength\fboxrule{0.25\p@}

\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*{\cal}{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*{\mit}{\@fontswitch\relax\mathnormal}

%% ===============================================
%% Table of Contents format
%% ===============================================
\setcounter{tocdepth}{3}
\renewcommand{\@pnumwidth}{2\Cwd}
\renewcommand{\@tocrmarg}{3\Cwd}
\renewcommand{\@dotsep}{4.5}
\setlength\toclineskip{0pt plus .2pt}
\newlength{\tocsectionsep}
\setlength{\tocsectionsep}{0.5\baselineskip}
\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth
  \else
    \vskip\toclineskip
    \begingroup
    \leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue
    \interlinepenalty\@M
    \leavevmode
    \@lnumwidth #3\relax
    \advance\leftskip \@lnumwidth \hbox{}\hskip -\leftskip
    {#4}\nobreak
    \leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep mu$}%
    \hfill\nobreak
    \hb@xt@\@pnumwidth{\hss\normalfont \normalcolor #5}%
    \par
    \endgroup
  \fi
}
\renewcommand*{\l@section}[2]{%
  \ifnum \c@tocdepth >\z@
    \addpenalty{\@secpenalty}%
    \addvspace{\tocsectionsep}%
    \setlength\@tempdima{5.5\Cwd}%
    \begingroup
    \parindent\z@ \rightskip\@pnumwidth \parfillskip-\rightskip
    \leavevmode\bfseries
    \setlength\@lnumwidth{\@tempdima}%
    \advance\leftskip\@lnumwidth \hskip-\leftskip
    \textbf{#1}\nobreak
    \hspace{1\zw}%
    \leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep mu$}%
    \hfill
    \nobreak
    \hb@xt@\@pnumwidth{\hss #2}\par
    \endgroup
  \fi
}
\renewcommand*{\l@subsection}{\@dottedtocline{2}{1\Cwd}{2\Cwd}}
\renewcommand*{\l@subsubsection}{\@dottedtocline{3}{3\Cwd}{3\Cwd}}
\renewcommand*{\l@paragraph}{\@dottedtocline{4}{6\Cwd}{4\Cwd}}
\renewcommand*{\l@subparagraph}{\@dottedtocline{5}{6\Cwd}{4\Cwd}}
\renewcommand{\listoffigures}{\section*{\listfigurename}\@starttoc{lof}}
\renewcommand*{\l@figure}{\@dottedtocline{1}{1.5em}{2.3em}}
\renewcommand{\listoftables}{\section*{\listtablename}\@starttoc{lot}}
\let\l@table\l@figure

%% ===============================================
%% Other environments (Acknowledgments, Publications, etc.)
%% ===============================================
\renewcommand{\footnoterule}{\kern-3\p@\hrule width .4\columnwidth\kern 2.6\p@}
\renewcommand\@makefntext[1]{%
  \samepage
  \advance\leftskip 14pt
  \parindent 1\Cwd
  \noindent
  \llap{\@makefnmark~}#1
}

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
