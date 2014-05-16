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
\usepackage{setspace}
\usepackage{enumerate}

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

\setstretch{1.2}

\begin{document}

\rnc\quote[2]{
\begin{center}\begin{minipage}[t]{0.7\textwidth}\begin{center}
\emph{#1}
\end{center}
\begin{flushright}
\vspace{-1.2ex}
- #2\hspace{2ex}~
\end{flushright}
\end{minipage}\end{center}
}
\nc\pquote{\pause\quote}

\frame{\titlepage}

\framet{Not even wrong}{\parskip 2ex

Conventional programming is precise only about how, not what.

\pquote{It is not only not right, it is not even wrong.}{Wolfgang Pauli}

\pquote{Everything is vague to a degree you do not realize till you have tried to make it precise.}{Bertrand Russell}

\pquote{What we wish, that we readily believe.}{Demosthenes}

}

\framet{Abstraction}{
\large \setstretch{1.5}
\quote{The purpose of abstraction is not to be vague,\\
but to create a new semantic level\\
in which one can be absolutely precise.}{Edsger Dijkstra}
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
\vspace{-2ex}
\begin{itemize}
  \item Standard type classes
  \item Laws
  \item Semantic type class morphisms (TCMs)
\end{itemize}

}

\framet{Denotative programming}{\parskip 2ex

Peter Landin recommended ``denotative'' to replace fuzzy terms ``functional'' and ``declarative''.

Properties:
\begin{itemize}
  \item Nested expression structure.
  \item Each expression \emph{denotes} something,
  \item depending only on subexpression denotations.
\end{itemize}

``\ldots gives us a test for whether the notation is genuinely functional or merely masquerading.''
(\href{http://www.scribd.com/doc/12878059/The-Next-700-Programming-Languages}{\emph{The
Next 700 Programming Languages}})

}

\framet{Denotative design}{\parskip 3ex

Design methodology for typed, purely functional programming.

\begin{itemize}\itemsep 2.5ex
  \item Precise, simple, and compelling specification.
  \item Based on familiar algebraic abstraction (with laws).
  \item Informs \emph{use} and \emph{implementation} without entangling.
  \item Principled construction of correct implementation.
\end{itemize}
}

\framet{Example -- Linear transformations}{

\emph{Assignment:}
\begin{itemize}
\item Represent linear transformations
\item Implement identity and composition
\end{itemize}

\pause
\vspace{3ex}

\emph{Plan:}
\begin{itemize}
  \item Represent
  \item Interpret
  \item Specify
  \item Calculate
\end{itemize}

}

\framet{Warm-up: 1D linear transformations}{

Represent:
\pause

> newtype Lin1 s = Scale s

Interpret:
\pause

> meaning :: Num s => Lin1 s -> (s -> s)
> meaning (Scale s) = \ x -> s @* x

Specify:
\pause

> meaning idL       == id
> meaning (g @. f)  == meaning g . meaning f

}

\nc\bboxed[1]{\boxed{\rule[-0.9ex]{0pt}{2.8ex}#1}}

\framet{Calculate an implementation}{

\hidden{
Define

> id    :: Lin1 s
> (@.)  :: Lin1 s -> Lin1 s -> Lin1 s

such that
}

Specification:

> meaning idL       == id
> meaning (g @. f)  == meaning g . meaning f

%% The game: calculate implementation from specification.
Calculation:

\setlength{\fboxsep}{-1ex}

\begin{center}
\fbox{\begin{minipage}[c]{0.40\textwidth}

>          id
> BACK ==  \ x -> x
> BACK ==  \ x -> 1 @* x
> BACK ==  meaning (Scale 1)
> SPACE

\end{minipage}}
\fbox{\begin{minipage}[c]{0.55\textwidth}

>          meaning (Scale s)  .  meaning (Scale s')
> BACK ==  (\ x -> s @* x) . (\ x' -> s' @* x')
> BACK ==  \ x' -> s @* (s' @* x')
> BACK ==  \ x' -> ((s @* s') @* x')
> BACK ==  meaning (Scale (s @* s'))

\end{minipage}}
\end{center}

Sufficient definitions:

\begin{center}
\fbox{\begin{minipage}[c]{0.40\textwidth}

> BACK idL = Scale 1

\end{minipage}}
\fbox{\begin{minipage}[c]{0.55\textwidth}

> BACK Scale s @. Scale s' = Scale (s @* s')

\end{minipage}}
\end{center}

}

\framet{Algebraic abstraction}{

\begin{itemize}
  \item Replace ad hoc vocabulary with a standard one.
  \item Verify laws
\end{itemize}

}

\end{document}

Supporting abstraction for identity & composition?

\pause

> data Lin1 :: * -> * -> * SPACE where
>   Scale :: Num s => s -> Lin s s

\pause
\textbf{Key ideas:}
\begin{itemize}
  \item \emph{Interpret} data type as math type with the required operations.
  \item \emph{Calculate} a correct implementation.
\end{itemize}
