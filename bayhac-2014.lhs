%% -*- latex -*-

%% %let atwork = True

% Presentation
\documentclass{beamer}

%% % Printed, 2-up
%% \documentclass[serif,handout]{beamer}
%% \usepackage{pgfpages}
%% \pgfpagesuselayout{2 on 1}[border shrink=1mm]

%% % Printed, 4-up
%% \documentclass[serif,handout,landscape]{beamer}
%% \usepackage{pgfpages}
%% \pgfpagesuselayout{4 on 1}[border shrink=1mm]

\usefonttheme{serif}

\usepackage{beamerthemesplit}

%% % http://www.latex-community.org/forum/viewtopic.php?f=44&t=16603
%% \makeatletter
%% \def\verbatim{\small\@verbatim \frenchspacing\@vobeyspaces \@xverbatim}
%% \makeatother

\usepackage{graphicx}
\usepackage{color}
\DeclareGraphicsExtensions{.pdf,.png,.jpg}

\usepackage{wasysym}

\useinnertheme[shadow]{rounded}
% \useoutertheme{default}
\useoutertheme{shadow}
\useoutertheme{infolines}
% Suppress navigation arrows
\setbeamertemplate{navigation symbols}{}

\input{macros}

%include polycode.fmt
%include forall.fmt
%include greek.fmt
%include mine.fmt

\title{Denotational design}
\subtitle{From programs to meanings}
\author{\href{http://conal.net}{Conal Elliott}}
\institute{\href{http://tabula.com/}{Tabula}}
% Abbreviate date/venue to fit in infolines space
%% \date{\href{http://www.meetup.com/haskellhackersathackerdojo/events/132372202/}{October 24, 2013}}
%% \date{October, 2013}
\date{May, 2014}

\setlength{\itemsep}{2ex}
\setlength{\parskip}{1ex}

\setlength{\blanklineskip}{1.5ex}

\nc\pitem{\pause \item}

%%%%

% \setbeameroption{show notes} % un-comment to see the notes

\begin{document}

\frame{\titlepage}

%% \title{Denotational design}
%% \subtitle{From programs to meanings}

\framet{Abstraction}{
\vspace{0.6in}
\begin{center}
\begin{minipage}[t]{0.7\textwidth}
\begin{center}
{ \it
The purpose of abstraction is not to be vague,\\
but to create a new semantic level\\
in which one can be absolutely precise.
}
\end{center}
\vspace{3ex}
\begin{flushright}
- Edsger Dijkstra
\end{flushright}
\end{minipage}
\end{center}
}

\framet{Library design}{ \parskip 3ex

Goal: precise, elegant, reusable abstractions.

\pause
Where have such things been developed?
\pause
\emph{Math --- abstract algebra.}

\pause
\emph{Homomorphisms} for non-leaky abstractions.

\vspace{3ex}
\pause

In Haskell,
\pause
\begin{itemize}
  \item Standard type classes
  \item Laws
  \item Semantic type class morphisms (TCMs)
\end{itemize}

}

\end{document}
