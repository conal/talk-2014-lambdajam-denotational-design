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

\usepackage{hyperref}
\usepackage{color}

\definecolor{linkColor}{rgb}{0.62,0,0}

\hypersetup{colorlinks=true,urlcolor=linkColor}

%% \usepackage{beamerthemesplit}

%% % http://www.latex-community.org/forum/viewtopic.php?f=44&t=16603
%% \makeatletter
%% \def\verbatim{\small\@verbatim \frenchspacing\@vobeyspaces \@xverbatim}
%% \makeatother

\usepackage{graphicx}
\usepackage{color}
\DeclareGraphicsExtensions{.pdf,.png,.jpg}


%% \usepackage{wasysym}
\usepackage{mathabx}
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

\title{Denotational Design}
\subtitle{from meanings to programs}
\author{\href{http://conal.net}{Conal Elliott}}
\institute{\href{http://tabula.com/}{Tabula}}
% Abbreviate date/venue to fit in infolines space
%% \date{\href{http://www.meetup.com/haskellhackersathackerdojo/events/132372202/}{October 24, 2013}}
%% \date{October, 2013}
\date{May, 2014}

\setlength{\itemsep}{2ex}
\setlength{\parskip}{1ex}

% \setlength{\blanklineskip}{1.5ex}

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

\framet{Abstraction}{
\large \setstretch{1.5}
\quote{The purpose of abstraction is not to be vague,\\
but to create a new semantic level\\
in which one can be absolutely precise.}{Edsger Dijkstra}
}

\framet{Not even wrong}{\parskip 2ex

Conventional programming is precise only about how, not what.

\pquote{It is not only not right, it is not even wrong.}{Wolfgang Pauli}

\pquote{Everything is vague to a degree you do not realize till you have tried to make it precise.}{Bertrand Russell}

\pquote{What we wish, that we readily believe.}{Demosthenes}

}

\framet{Library design}{ \parskip 3ex

Goal: precise, elegant, reusable abstractions.

\pause
Where have such things been developed?
\pause
\emph{Math --- abstract algebra.}

\pause
Non-leaky abstraction |==| \emph{homomorphism}.

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

\framet{Denotative programming}{\parskip 4ex
Peter Landin recommended ``denotative'' to replace ill-defined ``functional'' and ``declarative''.

Properties:\vspace{-4ex}
\begin{itemize}
  \item Nested expression structure.
  \item Each expression \emph{denotes} something,
  \item depending only on denotations of subexpressions.
\end{itemize}

``\ldots gives us a test for whether the notation is genuinely functional or merely masquerading.''
(\href{http://www.scribd.com/doc/12878059/The-Next-700-Programming-Languages}{\emph{The
Next 700 Programming Languages}})

}

\framet{Denotational design}{ % \parskip 2ex
Design methodology for ``genuinely functional'' programming:
\begin{itemize}\itemsep 1.5ex
  \item Precise, simple, and compelling specification.
  \item Informs \emph{use} and \emph{implementation} without entangling them.
  \item Standard algebraic abstractions.
  \item Free of abstraction leaks.
  \item Laws for free.
  \item Principled construction of correct implementation.
\end{itemize}
}

\framet{Example -- linear transformations}{
\emph{Assignment:}
\begin{itemize}
\item Represent linear transformations
\item Implement identity and composition
\end{itemize}

\pause
\vspace{3ex}

\emph{Plan:}
\begin{itemize}
  \item Interface
  \item Denotation
  \item Representation
  \item Calculation (implementation)
\end{itemize}

}

\setlength{\fboxsep}{-1.7ex}

\framet{Interface and denotation}{

\begin{minipage}[c]{0.2\textwidth}Interface:\end{minipage}
\fbox{\begin{minipage}[c]{0.7\textwidth}

> type Lin :: * -> * -> *
>
> scale  :: Num s => (s :-* s)
> idL    :: a :-* a
> (@.)   :: (b :-* c) -> (a :-* b) -> (a :-* c)
> ...

\end{minipage}}

\pause
\begin{minipage}[c]{0.2\textwidth}Model:\end{minipage}
\fbox{\begin{minipage}[c]{0.7\textwidth}

> type a -* b  -- Linear subset of |a -> b|
>
> meaning :: (a :-* b) -> (a -* b)

\end{minipage}}

\pause
\begin{minipage}[c]{0.2\textwidth}Specification:\end{minipage}
\fbox{\begin{minipage}[c]{0.7\textwidth}

> meaning (scale s)  == \ x -> s @* x
> meaning idL        == id
> meaning (g @. f)   == meaning g . meaning f
> ...

\end{minipage}}

}

\framet{Representation} {

Start with 1D.
Recall partial specification:

> meaning (scale s) == \ x -> s @* x

Try a direct data type representation:

> data Lin :: * -> * -> * SPACE where
>   Scale :: Num s => s -> (s :-* s)   -- ...
>
> meaning :: (a :-* b) -> (a -* b)
> meaning (Scale s) = \ x -> s @* x

Spec trivially satisfied by |scale = Scale|.

Others are more interesting.

}

%% TODO: signatures for idL and (@.), using bboxed

\nc\bboxed[1]{\boxed{\rule[-0.9ex]{0pt}{2.8ex}#1}}

\framet{Calculate an implementation}{

\vspace{-1ex}
Specification:\vspace{-1ex}
\begin{center}
\fbox{\begin{minipage}[c]{0.40\textwidth}

> meaning idL == id

\end{minipage}}
\fbox{\begin{minipage}[c]{0.55\textwidth}

> meaning (g @. f) == meaning g . meaning f

\end{minipage}}
\end{center}

%% The game: calculate implementation from specification.
Calculation:\vspace{-1ex}
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

Sufficient definitions:\vspace{-1ex}
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

In general,

\begin{itemize}
  \item Replace ad hoc vocabulary with a standard abstraction.
  \item Recast semantics as homomorphism.
  \item Note that laws hold.
\end{itemize}

~

What standard abstraction to use for |Lin|?
}

\framet{Category}{

Interface:

> class Category k where
>   id   :: k a a
>   (.)  :: k b c -> k a b -> k a c

Laws:

> id . f       == f
> g . id       == g
> (h . g) . f  == h . (g . f)

}

\framet{Linear transformation category}{

Linear map semantics:

> meaning :: (a :-* b) -> (a -* b)
> meaning (Scale s) = \ x -> s @* x

Specification as homomorphism (no abstraction leak):

> meaning id       == id
> meaning (g . f)  == meaning g . meaning f

Correct-by-construction implementation:

> instance Category Lin where
>   id = Scale 1
>   Scale s . Scale s' = Scale (s @* s')

}

\framet{Laws for free}{

%% Semantic homomorphisms guarantee class laws. For `Category`,

\begin{center}
\fbox{\begin{minipage}[c]{0.4\textwidth}

> meaning id       == id
> meaning (g . f)  == meaning g . meaning f

\end{minipage}}
\begin{minipage}[c]{0.07\textwidth}\begin{center}$\Rightarrow$\end{center}\end{minipage}
\fbox{\begin{minipage}[c]{0.45\textwidth}

> id . f       == f
> g . id       == g
> (h . g) . f  == h . (g . f)

\end{minipage}}
\end{center}
\vspace{-1ex}
where equality is \emph{semantic}.
\pause
Proofs:
\begin{center}
\fbox{\begin{minipage}[c]{0.3\textwidth}

>     meaning (id . f)
> ==  meaning id . meaning f
> ==  id . meaning f
> ==  meaning f

\end{minipage}}
\fbox{\begin{minipage}[c]{0.3\textwidth}

>     meaning (g . id)
> ==  meaning g . meaning id
> ==  meaning g . id
> ==  meaning g

\end{minipage}}
\fbox{\begin{minipage}[c]{0.39\textwidth}

>     meaning ((h . g) . f)
> ==  (meaning h . meaning g) . meaning f
> ==  meaning h . (meaning g . meaning f)
> ==  meaning (h . (g . f))

\end{minipage}}
\end{center}

Works for other classes as well.
}

\framet{Higher dimensions}{

Interface:

> (&&&)  :: (a :-* c)  -> (a :-* d)  -> (a :-* c :* d)
> (|||)  :: (a :-* c)  -> (b :-* c)  -> (a :* b :-* c)

~

Semantics:

> meaning (f &&& g)  == \ a -> (f a, g a)
> meaning (f ||| g)  == \ (a,b) -> f a + g b

}

\framet{Products and coproducts}{

> class Category k => ProductCat k where
>   type Prod k a b
>   exl    :: k (Prod k a b) a
>   exr    :: k (Prod k a b) b
>   (&&&)  :: k a c  -> k a d  -> k a (Prod k c d)
> SPACE
> class Category k => CoproductCat k where
>   type Coprod k a b
>   inl    :: k a (Coprod k a b)
>   inr    :: k b (Coprod k a b)
>   (|||)  :: k a c  -> k b c  -> k (Coprod k a b) c

Similar to |Arrow| and |ArrowChoice| classes.

}

\framet{Semantic morphisms}{

\begin{center}
\fbox{\begin{minipage}[c]{0.48\textwidth}

> meaning exl        == exl
> meaning exr        == exr
> meaning (f &&& g)  == meaning f &&& meaning g

\end{minipage}}
\hspace{0.02\textwidth}
\fbox{\begin{minipage}[c]{0.48\textwidth}

> meaning inl        == inl
> meaning inr        == inr
> meaning (f ||| g)  == meaning f ||| meaning g

\end{minipage}}
\end{center}

For |a -* b|,

\begin{center}
\fbox{\begin{minipage}[c]{0.48\textwidth}

> type Prod (-*) a b = a :* b
> exl  (a,b) = a
> exr  (a,b) = b
> f &&& g = \ a -> (f a, g a)

\end{minipage}}
\hspace{0.02\textwidth}
\fbox{\begin{minipage}[c]{0.48\textwidth}

> type Coprod (-*) a b = a :* b
> inl  a = (a,0)
> inr  b = (0,b)
> f ||| g = \ (a,b) -> f a + g b

\end{minipage}}
\end{center}

For calculation, see blog post \href{http://conal.net/blog/posts/reimagining-matrices}{\emph{Reimagining
matrices}}.

}

\framet{Full representation and denotation}{

> data Lin :: * -> * -> * SPACE where
>   Scale :: Num s => s -> (s :-* s)
>   (:&&) :: (a :-* c)  -> (a :-* d)  -> (a :-* c :* d)
>   (:||) :: (a :-* c)  -> (b :-* c)  -> (a :* b :-* c)

> meaning :: (a :-* b) -> (a -* b)
> meaning (Scale s)   = \ x -> s @* x
> meaning (f :&&  g)  = \ a -> (f a, g a)
> meaning (f :||  g)  = \ (a,b) -> f a + g b

}

\framet{Functional reactive programming}{

\pause

Two essential properties:
\begin{itemize}
  \item \emph{Continuous} time!
  (Natural \& composable.)
\item Denotational design.
  (Elegant \& rigorous.)
\end{itemize}
{\parskip 3ex

\pause

Deterministic, continuous ``concurrency''.

More aptly, \emph{``Denotative continuous-time programming''} (DCTP).

Warning: many modern ``FRP'' systems have neither property.
}
}

\framet{Denotational design}{

Central type:

> type Behavior a

Model:

> meaning :: Behavior a -> (T -> a)

\pause

Suggests API and semantics (via morphisms).

What standard algebraic abstractions does the model inhabit?

\pause
|Monoid|, |Functor|, |Applicative|, |Monad|, |Comonad|.

}

\framet{Functor}{

> instance Functor ((->) t) where
>   fmap f h = f . h

Morphism:

>     meaning (fmap f b)
> ==  fmap f (meaning b)
> SPACE
> ==  f . meaning b

}

\framet{Applicative}{

> instance Applicative ((->) t) where
>   pure a   = \ t -> a
>   g <*> h  = \ t -> (g t) (h t)

Morphisms:

\begin{center}
\fbox{\begin{minipage}[c]{0.48\textwidth}

>     meaning (pure a)
> ==  pure a
> SPACE
> ==  \ t -> a

\end{minipage}}
\hspace{0.02\textwidth}
\fbox{\begin{minipage}[c]{0.48\textwidth}

>     meaning (fs <*> xs)
> ==  meaning fs <*> meaning xs
> SPACE
> ==  \ t -> (meaning' fs t) (meaning' xs t)

\end{minipage}}
\end{center}

Corresponds exactly to the original FRP denotation.

}

\framet{Monad}{

> instance Monad ((->) t) where
>   join ff = \ t -> ff t t

Morphism:
\begin{center}
\fbox{\begin{minipage}[c]{0.48\textwidth}

>     meaning (join bb)
> ==  join (fmap meaning (meaning bb))
> SPACE
> ==  join (meaning . meaning bb)
> ==  \ t -> (meaning . meaning bb) t t
> ==  \ t -> meaning (meaning bb t) t

\end{minipage}}
\end{center}

}

\framet{Comonad}{

> class Comonad w where
>   coreturn :: w a -> a
>   cojoin   :: w a -> w (w a)

Functions:

> instance Monoid t => Comonad ((->) t) where
>   coreturn :: (t -> a) -> a
>   coreturn f = f mempty
>   cojoin f = \ t t' -> f (t <> t')

Suggest a relative time model.

}

\framet{Image manipulation}{

\pause
Central type:

> type Image a

\pause
Model:

> meaning :: Image a -> (R2 -> a)

\pause
As with behaviors,
\begin{itemize}
  \item Suggests API and semantics (via morphisms).
  \item Classes: |Monoid|, |Functor|, |Applicative|, |Monad|, |Comonad|.
\end{itemize}

See \href{http://conal.net/Pan}{Pan page} for pictures \& papers.

}

\framet{Memo tries}{

> type a :->: b
>
> meaning :: (a :->: b) -> (a -> b)

This time, |meaning| has an inverse.

~

Exploit inverses to calculate instances.
Example:

\begin{center}
\fbox{\begin{minipage}[c]{0.4\textwidth}

>      meaning id == id
> <==  id == meaningInv id

\end{minipage}}
\hspace{0.02\textwidth}
\fbox{\begin{minipage}[c]{0.5\textwidth}

>      meaning (g . f) == meaning g . meaning f
> <==  g . f == meaningInv (meaning g . meaning f)

\end{minipage}}
\end{center}
}

\framet{Denotational design}{ % \parskip 2ex
\pause
Design methodology for typed, purely functional programming:
\begin{itemize}\itemsep 1.5ex
  \item Precise, simple, and compelling specification.
  \item Informs \emph{use} and \emph{implementation} without entangling.
  \item Standard algebraic abstractions.
  \item Free of abstraction leaks.
  \item Laws for free.
  \item Principled construction of correct implementation.
\end{itemize}
}

\framet{References}{
\begin{itemize} \itemsep 1.5ex
\item
  \href{http://conal.net/papers/type-class-morphisms/}{\emph{Denotational design with type class morphisms}}
\item
  \href{http://conal.net/papers/push-pull-frp/}{\emph{Push-pull functional reactive programming}}
\item
  \href{http://conal.net/papers/functional-images/}{\emph{Functional Images}}
\item
  \href{http://conal.net/blog/tag/http://conal.net/blog/tag/type-class-morphism/}{Posts on type class morphisms}
\item
  \href{https://github.com/conal/talk-2014-bayhac-denotational-design}{This talk}
%% \item \href{http://conal.net/blog/posts/early-inspirations-and-new-directions-in-functional-reactive-programming/}{\emph{Early inspirations and new directions in functional reactive programming}}

\end{itemize}
}

\end{document}

\pause
\textbf{Key ideas:}
\begin{itemize}
  \item \emph{Interpret} data type as math type with the required operations.
  \item \emph{Calculate} a correct implementation.
\end{itemize}
