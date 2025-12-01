%%
%% This is file `enlp.cls',
%% Academic thesis class for Ehime University NLP Lab
%%
%% Author: Eito Yoneyama
%% Created: 2025/11/20
%% Updated: 2025/12/01

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{enlp}[2025/12/01 v0.1.4 Academic thesis class for Ehime Univ. NLP Lab (based on JNLP style)]

%% ===============================================
%% Engine detection and font settings
%% ===============================================
\RequirePackage{ifptex}
\RequirePackage{ifluatex}

\def\clsname{ENLP}

\ifpTeX
  \def\zw{zw}
  \def\zh{zh}
  \RequirePackage{plautopatch}
\else\ifLuaTeX
  \RequirePackage{luatexja}
\else
  \ClassError{\clsname}{This class supports only upLaTeX, pLaTeX, or LuaLaTeX}{Use upLaTeX, pLaTeX, or LuaLaTeX to compile this document.}
\fi\fi

%% ===============================================
%% Required packages
%% ===============================================
\RequirePackage{enlplogo}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{tikz}
\RequirePackage{enlpbbl}

%% ===============================================
%% Option settings
%% ===============================================
\newif\if@enablejfam\@enablejfamtrue
\newif\if@ldebug\@ldebugfalse

% Paper size settings
\setlength\paperheight{297mm}
\setlength\paperwidth{210mm}

% Debug option
\DeclareOption{ldebug}{\@ldebugtrue}

\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{disablejfam}{\@enablejfamfalse}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption*{}

\ExecuteOptions{final}
\ProcessOptions\relax

\RequirePackage{bxpapersize}

% Load lua-visual-debug if ldebug is enabled AND using LuaTeX
\if@ldebug
  \ifluatex
    \RequirePackage{lua-visual-debug}
  \fi
\fi

%% ===============================================
%% Font definitions (JIS/UPJIS compatible)
%% ===============================================
\ifLuaTeX
\else
  \ifstrictplatex
    \DeclareFontShape{JY1}{mc}{m}{n}{<->s*[1.039] jis}{}
    \DeclareFontShape{JY1}{mc}{m}{it}{<->s*[1.039] jis}{}
    \DeclareFontShape{JY1}{mc}{m}{sc}{<->s*[1.039] jis}{}
    \DeclareFontShape{JY1}{gt}{m}{n}{<->s*[1.039] jisg}{}
    \DeclareFontShape{JY1}{gt}{m}{it}{<->s*[1.039] jisg}{}
    \DeclareFontShape{JY1}{gt}{m}{sc}{<->s*[1.039] jisg}{}
    \DeclareFontShape{JT1}{mc}{m}{n}{<->s*[1.039] jis-v}{}
    \DeclareFontShape{JT1}{mc}{m}{it}{<->s*[1.039] jis-v}{}
    \DeclareFontShape{JT1}{mc}{m}{sc}{<->s*[1.039] jis-v}{}
    \DeclareFontShape{JT1}{gt}{m}{n}{<->s*[1.039] jisg-v}{}
    \DeclareFontShape{JT1}{gt}{m}{it}{<->s*[1.039] jisg-v}{}
    \DeclareFontShape{JT1}{gt}{m}{sc}{<->s*[1.039] jisg-v}{}
  \else
    \ifstrictuplatex
      \DeclareFontShape{JY2}{mc}{m}{n}{<->s*[1.039] upjisr-h}{}
      \DeclareFontShape{JY2}{mc}{m}{it}{<->s*[1.039] upjisr-h}{}
      \DeclareFontShape{JY2}{mc}{m}{sc}{<->s*[1.039] upjisr-h}{}
      \DeclareFontShape{JY2}{gt}{m}{n}{<->s*[1.039] upjisg-h}{}
      \DeclareFontShape{JY2}{gt}{m}{it}{<->s*[1.039] upjisg-h}{}
      \DeclareFontShape{JY2}{gt}{m}{sc}{<->s*[1.039] upjisg-h}{}
      \DeclareFontShape{JT2}{mc}{m}{n}{<->s*[1.039] upjisr-v}{}
      \DeclareFontShape{JT2}{mc}{m}{it}{<->s*[1.039] upjisr-v}{}
      \DeclareFontShape{JT2}{mc}{m}{sc}{<->s*[1.039] upjisr-v}{}
      \DeclareFontShape{JT2}{gt}{m}{n}{<->s*[1.039] upjisg-v}{}
      \DeclareFontShape{JT2}{gt}{m}{it}{<->s*[1.039] upjisg-v}{}
      \DeclareFontShape{JT2}{gt}{m}{sc}{<->s*[1.039] upjisg-v}{}
    \fi
  \fi
\fi

%% ===============================================
%% Size and layout settings
%% ===============================================
\renewcommand{\normalsize}{%
  \@setfontsize\normalsize\@xiipt{22}% 12pt / 22pt
  \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI
}
\normalsize

\ifLuaTeX
  \setbox0\hbox{　}
\else
  \ifstrictplatex
    \setbox0\hbox{\char\euc"A1A1}
  \else
    \ifstrictuplatex
      \setbox0\hbox{　}
    \fi
  \fi
\fi
\setlength\Cht{\ht0}
\setlength\Cdp{\dp0}
\setlength\Cwd{\wd0}
\setlength\Cvs{\baselineskip}
\setlength\Chs{\wd0}

\newcommand{\small}{%
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

\newcommand{\footnotesize}{%
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

\newcommand{\tiny}{\@setfontsize\tiny\@vipt{7}} % 6pt / 7pt
\newcommand{\scriptsize}{\@setfontsize\scriptsize\@viiipt{10}} % 8pt / 10pt
\newcommand{\large}{\@setfontsize\large\@xivpt{25}} % 14pt / 25pt
\newcommand{\Large}{\@setfontsize\Large\@xviipt{30}} % 17pt / 30pt
\newcommand{\LARGE}{\@setfontsize\LARGE\@xxpt{35}} % 20pt / 35pt
\newcommand{\huge}{\@setfontsize\huge\@xxvpt{40}} % 25pt / 40pt
\newcommand{\Huge}{\@setfontsize\Huge{30}{45}} % 30pt / 45pt

% (A4 / 12pt)
\setlength\headheight{12\p@}
\setlength\headsep{25\p@}
\setlength\topskip{1\Cht}
\setlength\footskip{30\p@}

\setlength\textheight{29\Cvs}\addtolength\textheight{\topskip}
\@settopoint\textheight
\setlength\textwidth{460pt}
\@settopoint\textwidth

\setlength\topmargin{25mm}
\addtolength\topmargin{-1in}
\@settopoint\topmargin
\setlength\marginparsep{\z@}
\setlength\marginparpush{\z@}
\setlength\marginparwidth{\z@}
\@settopoint\marginparwidth
\setlength\@tempdima{\paperwidth}\addtolength\@tempdima{-\textwidth}
\setlength\oddsidemargin{.5\@tempdima}\addtolength\oddsidemargin{-1in}
\evensidemargin\oddsidemargin
\@settopoint\oddsidemargin
\@settopoint\evensidemargin

\setlength\footnotesep{7\p@}
\setlength\@tempdima{1\Cvs}\addtolength\@tempdima{-1\Cht}\addtolength\@tempdima{7\p@}
\setlength{\skip\footins}{\@tempdima \@plus 1\Cvs \@minus \z@}
\setlength\floatsep    {17\p@}
\setlength\textfloatsep{2\@tempdima \@plus \@tempdima \@minus \@tempdima}
\setlength\intextsep   {2\@tempdima \@plus \@tempdima \@minus \@tempdima}
\setlength\dblfloatsep {17\p@}
\setlength\dbltextfloatsep{\@tempdima \@plus \@tempdima \@minus \@tempdima}
\setlength\@fptop{0\p@}
\setlength\@fpsep{17\p@}
\setlength\@fpbot{0\p@ \@plus 1fil}
\setlength\@dblfptop{0\p@}
\setlength\@dblfpsep{17\p@}
\setlength\@dblfpbot{0\p@ \@plus 1fil}

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
\setcounter{dbltopnumber}{4}
\renewcommand{\topfraction}{.9}
\renewcommand{\bottomfraction}{.9}
\renewcommand{\textfraction}{.1}
\renewcommand{\floatpagefraction}{.5}
\renewcommand{\dbltopfraction}{.9}
\renewcommand{\dblfloatpagefraction}{.5}

%% ===============================================
%% Headers and Footers
%% ===============================================
\def\ps@plain{%
  \let\@mkboth\@gobbletwo
  \let\@oddhead\@empty
  \def\@oddfoot{\reset@font\hfil\thepage\hfil}%
  \let\@evenhead\@empty
  \let\@evenfoot\@oddfoot
}
\def\ps@myheadings{%
  \let\@oddfoot\@empty\let\@evenfoot\@empty
  \def\@evenhead{\thepage\hfil\leftmark}%
  \def\@oddhead{{\rightmark}\hfil\thepage}%
  \let\@mkboth\@gobbletwo
  \let\sectionmark\@gobble
  \let\subsectionmark\@gobble
}

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

% Additional metadata
\def\thesis#1{\gdef\@thesis{#1}}        % Example: Graduation Thesis, Master's Thesis
\def\teacher#1{\gdef\@teacher{#1}}      % Supervisor
\def\institute#1{\gdef\@institute{#1}}  % Affiliation (Faculty/Department, etc.)

% Warnings for undefined variables
\def\@thesis{\GenericWarning{}{\clsname\space Warning: No \noexpand\thesis given}}
\def\@teacher{\GenericWarning{}{\clsname\space Warning: No \noexpand\teacher given}}
\def\@institute{\GenericWarning{}{\clsname\space Warning: No \noexpand\institute given}}

%% ===============================================
%% Title page creation
%% ===============================================
\newlength{\@FMwidth}\setlength{\@FMwidth}{14pt}

\newcommand{\maketitle}{%
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
  \global\@enlp@titleproducedtrue
  \global\let\maketitle\relax
  \global\let\thesis\relax
  \global\let\teacher\relax
  \global\let\institute\relax
  \global\let\@thanks\@empty
  \global\let\p@thanks\@empty
  \global\let\@thesis\@empty
  \global\let\@teacher\@empty
  \global\let\@institute\@empty
}

%% ===============================================
%% Order enforcement flags
%% ===============================================
\newif\if@enlp@titleproduced \@enlp@titleproducedfalse
\newif\if@enlp@abstractdone  \@enlp@abstractdonefalse

%% ===============================================
%% Title page creation
%% ===============================================
\def\@maketitle{%
  \clearpage
  \parindent\z@
  \vskip 8pt
  \setlength{\leftskip}{25pt}\setlength{\rightskip}{25pt}
  \begin{center}
    \let\footnote\thanks
    \vspace*{40pt}
    
    {\fontsize{20pt}{25pt}\selectfont \@thesis \par}

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
      \@institute \par
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
        \@teacher
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

\renewcommand{\@makefnmark}{%
  \kern0pt\raisebox{0.3ex}{\@textsuperscript{\normalfont\@thefnmark}}%
}

%% ===============================================
%% Table of Contents and Sections
%% ===============================================
\providecommand{\phantomsection}{}
\newcommand{\tableofcontents}{%
  \if@enlp@abstractdone
  \else
    \ClassError{\clsname}{%
      \string\tableofcontents\space must be used after abstract environment%
    }{%
      The structure must be: \string\maketitle -> abstract -> \string\tableofcontents.%
    }%
  \fi
  \phantomsection
  \csection*{\contentsname}%
  \@mkboth{\contentsname}{\contentsname}%
  \@starttoc{toc}%
}

\newenvironment{abstract}{%
  \if@enlp@titleproduced
  \else
    \ClassError{\clsname}{%
      abstract environment must be used after \string\maketitle%
    }{%
      The structure must be: \string\maketitle -> abstract -> \string\tableofcontents.%
    }%
  \fi
  \phantomsection
  \csection*{\absttitle}%
  \begin{center}%
    \begin{minipage}{0.9\textwidth}%
}{%
    \end{minipage}%
  \end{center}%
  \setcounter{page}{1}%
  \global\@enlp@abstractdonetrue
}

\setcounter{secnumdepth}{3}
\newcounter{section}
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]
\renewcommand{\thesection}{\@arabic\c@section}
\renewcommand{\thesubsection}{\thesection.\@arabic\c@subsection}
\renewcommand{\thesubsubsection}{\thesubsection.\@arabic\c@subsubsection}
\renewcommand{\theparagraph}{\thesubsubsection.\@arabic\c@paragraph}
\renewcommand{\thesubparagraph}{\theparagraph.\@arabic\c@subparagraph}

\newcommand{\section}{%
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
\newcommand{\subsection}{%
  \@startsection{subsection}{2}{\z@}%
    {.9\Cvs \@plus.4\Cvs \@minus.2\Cvs}%
    {.1\Cvs \@minus0.1\Cvs}%
    {\reset@font\Large\bfseries}%
}
\newcommand{\subsubsection}{%
  \@startsection{subsubsection}{3}{\z@}%
    {.9\Cvs \@plus.4\Cvs \@minus.2\Cvs}%
    {.1\Cvs \@minus0.1\Cvs}%
    {\reset@font\large\bfseries}%
}
\newcommand{\paragraph}{%
  \@startsection{paragraph}{4}{\z@}%
    {\z@}{-10pt}{\reset@font\normalsize\bfseries}%
}
\newcommand{\subparagraph}{%
  \@startsection{subparagraph}{5}{\z@}%
    {\z@}{-10pt}{\reset@font\normalsize\bfseries}%
}

\newcommand{\appendix}{%
  \par
  \csection*{付録}
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \renewcommand{\thesection}{\@Alph\c@section}%
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
\renewcommand{\theenumi}{\@arabic\c@enumi}
\renewcommand{\theenumii}{\@alph\c@enumii}
\renewcommand{\theenumiii}{\@roman\c@enumiii}
\renewcommand{\theenumiv}{\@Alph\c@enumiv}
\newcommand{\labelenumi}{(\theenumi)}
\newcommand{\labelenumii}{(\theenumii)}
\newcommand{\labelenumiii}{(\theenumiii)}
\newcommand{\labelenumiv}{(\theenumiv)}
\renewcommand{\p@enumii}{\theenumi}
\renewcommand{\p@enumiii}{\theenumi(\theenumii)}
\renewcommand{\p@enumiv}{\p@enumiii\theenumiii}

\renewenvironment{enumerate}{%
  \ifnum \@enumdepth >\thr@@
    \@toodeep
  \else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
    \list{\csname label\@enumctr\endcsname}{%
    \iftdir
      \ifnum \@listdepth=\@ne 
        \topsep\z@
      \else
        \topsep\z@
      \fi
      \parskip\z@ \itemsep\z@ \parsep\z@
      \labelwidth1\Cwd \labelsep.3\Cwd
      \ifnum \@enumdepth=\@ne \leftmargin1\Cwd\relax
      \else\leftmargin\leftskip\fi
        \advance\leftmargin 1\Cwd
      \fi
      \usecounter{\@enumctr}%
      \def\makelabel##1{\hss\llap{##1}}}%
    \fi
}{\endlist}

\newcommand{\labelitemi}{\textbullet}
\newcommand{\labelitemii}{\normalfont\bfseries\textendash}
\newcommand{\labelitemiii}{\textasteriskcentered}
\newcommand{\labelitemiv}{\textperiodcentered}

\renewenvironment{itemize}{%
  \ifnum \@itemdepth >\thr@@
    \@toodeep
  \else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list{\csname \@itemitem\endcsname}{%
      \iftdir
        \ifnum \@listdepth=\@ne
          \topsep\z@
        \else
          \topsep\z@
        \fi
        \parskip\z@ \itemsep\z@ \parsep\z@
        \labelwidth1\Cwd \labelsep.3\Cwd
        \ifnum \@itemdepth =\@ne
          \leftmargin1\Cwd\relax
        \else
          \leftmargin\leftskip
        \fi
        \advance\leftmargin 1\Cwd
      \fi
      \def\makelabel##1{\hss\llap{##1}}}%
  \fi
}{\endlist}

\newenvironment{description}{%
  \list{}{\labelwidth\z@ \itemindent-\leftmargin
  \iftdir
    \leftmargin\leftskip \advance\leftmargin3\Cwd
    \rightmargin\rightskip
    \labelsep=1\Cwd \itemsep\z@
    \listparindent\z@ \topskip\z@ \parskip\z@ \partopsep\z@
  \fi
  \let\makelabel\descriptionlabel}%
}{\endlist}
\newcommand{\descriptionlabel}[1]{\hspace\labelsep\normalfont\bfseries #1}

% Figure and Table environments
\newcounter{figure}
\renewcommand{\thefigure}{\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\textbf{\figurename~\thefigure}}
\newenvironment{figure}{\@float{figure}}{\end@float}
\newenvironment{figure*}{\@dblfloat{figure}}{\end@dblfloat}
\newcounter{table}
\renewcommand{\thetable}{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\textbf{\tablename~\thetable}}
\newenvironment{table}{\@float{table}}{\end@float}
\newenvironment{table*}{\@dblfloat{table}}{\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
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

\renewcommand{\theequation}{\@arabic\c@equation}

%% ===============================================
%% Math font settings
%% ===============================================
\if@enablejfam
  \ifLuaTeX
  \else
    \ifstrictplatex
      \DeclareSymbolFont{mincho}{JY1}{mc}{m}{n}
      \DeclareSymbolFontAlphabet{\mathmc}{mincho}
      \SetSymbolFont{mincho}{bold}{JY1}{gt}{m}{n}
      \DeclareMathAlphabet{\mathgt}{JY1}{gt}{m}{n}
      \jfam\symmincho
    \else
      \ifstrictuplatex
        \DeclareSymbolFont{mincho}{JY2}{mc}{m}{n}
        \DeclareSymbolFontAlphabet{\mathmc}{mincho}
        \SetSymbolFont{mincho}{bold}{JY2}{gt}{m}{n}
        \DeclareMathAlphabet{\mathgt}{JY2}{gt}{m}{n}
        \jfam\symmincho
      \fi
    \fi
  \fi
\fi
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
\newcommand{\@pnumwidth}{2\Cwd}
\newcommand{\@tocrmarg}{3\Cwd}
\newcommand{\@dotsep}{4.5}
\newdimen\toclineskip
\setlength\toclineskip{\z@}
\newdimen\@lnumwidth
\def\numberline#1{\hbox to\@lnumwidth{#1\hfil}}
\newlength{\tocsectionsep}
\setlength{\tocsectionsep}{0.5\baselineskip}
\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth
  \else
    \vskip\toclineskip \@plus.2\p@
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
\newcommand*{\l@section}[2]{%
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
\newcommand*{\l@subsection}{\@dottedtocline{2}{1\Cwd}{2\Cwd}}
\newcommand*{\l@subsubsection}{\@dottedtocline{3}{3\Cwd}{3\Cwd}}
\newcommand*{\l@paragraph}{\@dottedtocline{4}{6\Cwd}{4\Cwd}}
\newcommand*{\l@subparagraph}{\@dottedtocline{5}{6\Cwd}{4\Cwd}}
\newcommand{\listoffigures}{\section*{\listfigurename}\@starttoc{lof}}
\newcommand*{\l@figure}{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand{\listoftables}{\section*{\listtablename}\@starttoc{lot}}
\let\l@table\l@figure

%% ===============================================
%% Other environments (Acknowledgments, Publications, etc.)
%% ===============================================
\renewcommand{\footnoterule}{\kern-3\p@\hrule width .4\columnwidth\kern 2.6\p@}
\newcommand\@makefntext[1]{%
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
\newcommand{\contentsname}{目次}
\newcommand{\listfigurename}{図目次}
\newcommand{\listtablename}{表目次}
\newcommand{\refname}{参考文献}
\newcommand{\figurename}{図}
\newcommand{\tablename}{表}
\newcommand{\acknowledgtitle}{謝辞}
\newcommand{\publicationtitle}{対外発表・論文・受賞等}

\clubpenalty0
\widowpenalty0

\linespread{1.2}
\pagestyle{mainpage}
\pagenumbering{arabic}
\raggedbottom
\onecolumn
\@twosidetrue
\@mparswitchtrue
\endinput