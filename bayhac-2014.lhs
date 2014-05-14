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

\framet{Example -- 1D linear functions}{

\vspace{2ex}

\emph{Assignment:}
\begin{itemize}
\item Represent 1D linear functions
\item Implement identity and composition
\end{itemize}

\pause

\textbf{Goals:}
\begin{itemize}
  \item Precise, simple, and compelling specification
  \item Based on familiar algebraic abstraction (with laws)
  \item Principled construction of correct implementation
\end{itemize}

\pause

\textbf{Plan:}
\begin{itemize}
  \item Represent
  \item Interpret
  \item Specify
  \item Calculate
\end{itemize}

}

\framet{1D linear function}{

Represent:

> newtype Scale s = Scale s

\pause

Interpret:

> meaning :: Num s => Scale s -> (s -> s)
> meaning (Scale s) = (s @* NO)

\pause

Specify:

> meaning idL       == id
> meaning (g @. f)  == meaning g . meaning f

}

\nc\bboxed[1]{\boxed{\rule[-0.9ex]{0pt}{2.8ex}#1}}

\framet{Calculate an implementation}{

\hidden{
Define

> id    :: Scale s
> (@.)  :: Scale s -> Scale s -> Scale s

such that
}

Specification:

> meaning idL       == id
> meaning (g @. f)  == meaning g . meaning f

The game: calculate implementation from specification.

\setlength{\fboxsep}{-1ex}

\begin{center}
\fbox{\begin{minipage}[c]{0.40\textwidth}

>          id
> BACK ==  \ x -> x
> BACK ==  \ x -> 1 @* x
> BACK ==  meaning (Scale 1)

\end{minipage}}
\fbox{\begin{minipage}[c]{0.55\textwidth}

>          meaning (Scale s)  .  meaning (Scale s')
> BACK ==  (s @* NO) . (s' @* NO)
> BACK ==  ((s @* s') @* NO)
> BACK ==  meaning (Scale (s @* s'))

\end{minipage}}
\end{center}

Sufficient:

\begin{center}
\fbox{\begin{minipage}[c]{0.40\textwidth}

> BACK idL = Scale 1

\end{minipage}}
\fbox{\begin{minipage}[c]{0.55\textwidth}

> BACK Scale s @. Scale s' = Scale (s @* s')

\end{minipage}}
\end{center}

}

\end{document}

Supporting abstraction for identity & composition?

\pause

> data Lin :: * -> * -> * SPACE where
>   Scale :: Num s => s -> Lin s s

\pause
\textbf{Key ideas:}
\begin{itemize}
  \item \emph{Interpret} data type as math type with the required operations.
  \item \emph{Calculate} a correct implementation.
\end{itemize}
