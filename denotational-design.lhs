%% -*- latex -*-

%% %let atwork = True

% Presentation
% \documentclass{beamer}
\documentclass[handout]{beamer}

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
% \institute{\href{http://tabula.com/}{Tabula}}
% Abbreviate date/venue to fit in infolines space
\date{LambdaJam 2015}
% \date{\emph{Draft of \today}}

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
\pause
\large \setstretch{1.5}
\quote{The purpose of abstraction is not to be vague,\\
but to create a new semantic level\\
in which one can be absolutely precise.}{Edsger Dijkstra}
}


\framet{Goals}{
\begin{itemize}\parskip 4ex
\item \emph{Abstractions}: precise, elegant, reusable.
\item \emph{Implementations}: correct, efficient, maintainable.
\item \emph{Documentation}: clear, simple, accurate.
\end{itemize}
}

\framet{Not even wrong}{\parskip 2ex

Conventional programming is precise only about how, not what.

\pquote{It is not only not right, it is not even wrong.}{Wolfgang Pauli}

\pquote{Everything is vague to a degree you do not realize till you have tried to make it precise.}{Bertrand Russell}

\pquote{What we wish, that we readily believe.}{Demosthenes}

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
Next 700 Programming Languages}}, 1966)

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

\framet{Overview}{
\begin{itemize}\parskip 2ex
\item Broad outline:
  \begin{itemize}\parskip 2ex
  \item Example, informally
  \item \emph{Pretty pictures}
  \item Principles
  \item More examples
  \item Reflection
  \end{itemize}
\pitem Discussion throughout
\pitem Try it on.
\end{itemize}
}

\framet{Example: image synthesis/manipulation}{
\begin{itemize}\parskip4ex
\item How to start?
\item What is success?
\end{itemize}
}

\framet{Functionality}{
\pause
\begin{itemize}\parskip 1.25ex
\item Import \& export
\item Spatial transformation:
  \begin{itemize}\parskip 1.2ex
  \item Affine: translate, scale, rotate
  \item Non-affine: swirls, lenses, inversions, \ldots{}
  \end{itemize}
\item Cropping
\item Monochrome
\item Overlay
\item Blend
\item Blur \& sharpen
\item Geometry, gradients, \ldots.
\end{itemize}
}

\framet{API first pass}{
\pause

> type Image

> over        :: Image -> Image -> Image
> transform   :: Transform -> Image -> Image
> crop        :: Region -> Image -> Image
> monochrome  :: Color -> Image
> -- shapes, gradients, etc.

{}

> fromBitmap  :: Bitmap -> Image
> toBitmap    :: Image -> Bitmap

}

\framet{How to implement?}{
\pause
\begin{center}
\emph{wrong first question}
\end{center}
}

\framet{\emph{What} to implement?}{
\begin{itemize}\parskip4ex
\pitem What do these operations mean?
\pitem More centrally: What do the \emph{types} mean?
\end{itemize}
}

\framet{What is an image?}{\parskip3ex
\pause
Specification goals:
\pause
\begin{itemize}\parskip2ex
\item Adequate
\item Simple
\item Precise
\end{itemize}

\pause
\vspace{4ex}

Why these properties?
}

\framet{What is an image?}{

\pause
My answer:
assignment of colors to 2D locations.

\pause How to make precise?

> type Image

\pause
Model:

> meaning :: Image -> (Loc -> Color)

\pause
What about regions?
\pause

> meaning :: Region -> (Loc -> Bool)

}

\framet{Specifying |Image| operations}{

> meaning (over top bot)     == ...
>
> meaning (crop reg im)      == ...
>
> meaning (monochrome c)     == ...
>
> meaning (transform tr im)  == ...

\vspace{13ex}

}

\framet{Specifying |Image| operations}{

> meaning (over top bot)     == \ p -> overC (meaning top p) (meaning bot p)
>
> meaning (crop reg im)      == \ p -> if meaning reg p then meaning im p else clear
>
> meaning (monochrome c)     == \ p -> c
>
> meaning (transform tr im)  == -- coming up

> overC :: Color -> Color -> Color

\pause

Note compositionality of |meaning|.

}

\framet{Compositional semantics}{

Make more explicit:

> meaning (over top bot)  == overS (meaning top) (meaning bot)
> meaning (crop reg im)   == cropS (meaning reg) (meaning im)

> overS :: (Loc -> Color) -> (Loc -> Color) -> (Loc -> Color)
> overS f g = \ p -> overC (f p) (g p)
> SPACE
> cropS :: (Loc -> Bool) -> (Loc -> Color) -> (Loc -> Color)
> cropS f g = \ p -> if f p then g p else clear

}

\framet{Generalize and simplify}{\parskip3ex
\begin{itemize}\itemsep2ex
\item What about transforming \emph{regions}?
\item Other pointwise combinations (lerp, threshold)?
\end{itemize}

\pause
Generalize:

> type Image a
> type ImageC  = Image Color
> type Region  = Image Bool

Now some operations become more general.

}

\framet{Generalize and simplify}{

> transform  :: Transform -> Image a -> Image a
> cond       :: Image Bool -> Image a -> Image a -> Image a

\pause\vspace{-4ex}

> lift0  ::  a -> Image a
> lift1  ::  (a -> b) -> (Image a -> Image b)
> lift2  ::  (a -> b -> c) -> (Image a -> Image b -> Image c)
> ...

\pause
Specializing,

> monochrome  = lift0
> over        = lift2 overC
> crop r im   = cond r im emptyIm
> cond        = lift3 ifThenElse

}

\framet{Spatial transformation}{

> meaning :: Transform -> ??

> meaning (transform tr im)  == ??

\vspace{28.55ex}

}

\framet{Spatial transformation}{

> meaning :: Transform -> ??

> meaning (transform tr im) == transformS (meaning tr) (meaning im)

where

> transformS :: ?? -> (Loc -> Color) -> (Loc -> Color)

\vspace{17ex}

}

\framet{Spatial transformation}{

> meaning :: Transform -> (Loc -> Loc)

> meaning (transform tr im)  == transformS (meaning tr) (meaning im)

where

> transformS :: (Loc -> Loc) -> (Loc -> Color) -> (Loc -> Color)

\pause\vspace{-8ex}

> transformS h f = \ p -> f (h p)

Subtle implications.

\pause
What is |Loc|?
\pause
My answer: continuous, infinite 2D space.

> type Loc = R2

}

\framet{Why continuous \& infinite (vs discrete/finite) space?}{
\pause
Same benefits as for time (FRP):
%\\ \hspace{6ex} \ldots and for pure, non-strict functional programming.
\pause
\begin{itemize}\itemsep0.3ex
\item Transformation flexibility with simple \& precise semantics.
\item Modularity/reusability/composability:
  \begin{itemize}
  \item Fewer assumptions, more uses (resolution-independence).
  \item More info available for extraction.
  \end{itemize}
\item Integration and differentiation: natural, accurate, efficient.
% \item Simplicity: eliminate non-essential details.
\pause
\item Quality/accuracy.
\item Efficiency (adapative).
\item Reconcile differing input sampling rates.
\end{itemize}
\pause
% \fbox{\emph{Principle:} Approximations/prunings compose badly, so postpone.}
\vspace{1ex}
{\color{blue}
\fbox{\normalcolor\emph{Principle:} Approximations/prunings compose badly, so postpone.}
}

See \href{http://www.cse.chalmers.se/~rjmh/Papers/whyfp.html}{\emph{Why~Functional~Programming~Matters}}.
}

\framet{Examples}{

\begin{center}
\href{http://conal.net/Pan/Gallery/}{Pan gallery}
\end{center}

}

\framet{Using standard vocabulary}{
\pause
\begin{itemize}\parskip1.3ex
\item We've created a domain-specific vocabulary.
\item Can we reuse standard vocabularies instead?
\item Why would we want to?
  \pause
  \begin{itemize}\parskip1.5ex
  \item User knowledge.
  \item Ecosystem support (multiplicative power).
  \item Laws as sanity check.
  \item Tao check.
  \item Specification and laws for free, as we'll see.
  \end{itemize}
\pitem In Haskell, standard type classes.
\end{itemize}
}

\framet{Monoid}{

Interface:

> class Monoid m where
>   mempty  :: m            -- ``mempty''
>   (<>)    :: m -> m -> m  -- ``mappend''

\pause
Laws:

> a <> mempty    == a
> mempty <> b    == b
> a <> (b <> c)  == (a <> b) <> c

\pause Why do laws |matter|?
\pause Compositional (modular) reasoning.

\pause What monoids have we seen today?
}

\framet{Image monoid}{

\pause

> instance Monoid ImageC where
>   mempty  = lift0 clear
>   (<>)    = over

\pause
Is there a more general form on |Image a|?
\pause

> instance Monoid a => Monoid (Image a) where
>   mempty  = lift0 mempty
>   (<>)    = lift2 (<>)

\vspace{-1ex}

\pause
Do these instances satisfy the |Monoid| laws?
}

\framet{|Functor|}{

> class Functor f where
>   fmap :: (a -> b) -> (f a -> f b)

{}

\pause
For images?

\vspace{2ex}

\pause

> instance Functor Image where
>   fmap = lift1

{}

\pause Laws?

}

\framet{|Applicative|}{

> class Functor f => Applicative f where
>   pure   :: a -> f a
>   (<*>)  :: f (a -> b) -> f a -> f b

\pause
For images?
\pause

> instance Applicative Image where
>   pure   = lift0
>   (<*>)  = lift2 ($)

From |Applicative|, where |(<$>) = fmap|:

> liftA2 f p q    = f <$> p <*> q
> liftA3 f p q r  = f <$> p <*> q <*> r
> -- etc

\pause Laws?

}

\framet{Instance semantics}{

\pause
|Monoid|:\vspace{-2ex}

> mu mempty        == \ p -> mempty
> mu (top <> bot)  == \ p -> mu top p <> mu bot p

\pause
|Functor|:\vspace{-2ex}

> mu (fmap f im)  == \ p -> f (mu im p)
>                 == f . mu im

\pause
|Applicative|:\vspace{-2ex}

> mu (pure a)       == \ p -> a
> mu (imf <*> imx)  == \ p -> (mu imf p) (mu imx p)

}

\framet{|Monad| and |Comonad|}{

> class Monad f where
>   return  :: a -> f a
>   join    :: f (f a) -> f a

> class Functor f => Comonad f where
>   coreturn  :: f a -> a
>   cojoin    :: f a -> f (f a)

|Comonad| gives us neighborhood operations.

}

\framet{Monoid specification, revisited}{

Image monoid specification:
\vspace{-1.5ex}

> mu mempty        == \ p -> mempty
> mu (top <> bot)  == \ p -> mu top p <> mu bot p

\pause
Instance for the semantic model:
\vspace{-1.5ex}

> instance Monoid m => Monoid (z -> m) where
>   mempty  = \ z -> mempty
>   f <> g  = \ z -> f z <> g z

\pause
Refactoring,
\vspace{-1.5ex}

> mu mempty        == mempty
> mu (top <> bot)  == mu top <> mu bot

\pause
So |mu| \emph{distributes} over monoid operations\pause, i.e., a monoid homomorphism.

}

\framet{Functor specification, revisited}{

Functor specification:
\vspace{-1.5ex}

> mu (fmap f im) == f . mu im

\pause
Instance for the semantic model:
\vspace{-1.5ex}

> instance Functor ((->) u) where
>  fmap f h = f . h

Refactoring,
\vspace{-1.5ex}

> mu (fmap f im) == fmap f (mu im)

So |mu| is a \emph{functor} homomorphism.
}

\framet{Applicative specification, revisited}{

Applicative specification:
\vspace{-1.5ex}

> mu (pure a)       == \ p -> a
> mu (imf <*> imx)  == \ p -> (mu imf p) (mu imx p)

\pause
Instance for the semantic model:
\vspace{-1.5ex}

> instance Applicative ((->) u) where
>   pure a     = \ u -> a
>   fs <*> xs  = \ u -> (fs u) (xs u)

Refactoring,
\vspace{-1.5ex}

> mu (pure a)       == pure a
> mu (imf <*> imx)  == mu imf <*> mu imx

So |mu| is an \emph{applicative} homomorphism.

}

\framet{Specifications for free}{\parskip3ex

Semantic type class morphism (TCM) principle:
\begin{quotation}
\emph{The instance's meaning follows the meaning's instance.}
\end{quotation}

That is, the type acts like its meaning.

Every TCM failure is an abstraction leak.

Strong design principle.

Class laws necessarily hold, as we'll see.
}

\setlength{\fboxsep}{-1.7ex}

\framet{Laws for free}{

%% Semantic homomorphisms guarantee class laws. For `Monoid`,

\begin{center}
\fbox{\begin{minipage}[c]{0.4\textwidth}

> meaning mempty    == mempty
> meaning (a <> b)  == meaning a <> meaning b

\end{minipage}}
\begin{minipage}[c]{0.07\textwidth}\begin{center}$\Rightarrow$\end{center}\end{minipage}
\fbox{\begin{minipage}[c]{0.45\textwidth}

> a <> mempty    == a
> mempty <> b    == b
> a <> (b <> c)  == (a <> b) <> c

\end{minipage}}
\end{center}
\vspace{-1ex}
where equality is \emph{semantic}.
\pause
Proofs:
\begin{center}
\fbox{\begin{minipage}[c]{0.3\textwidth}

>     meaning (a <> mempty)
> ==  meaning a <> meaning mempty
> ==  meaning a <> mempty
> ==  meaning a

\end{minipage}}
\fbox{\begin{minipage}[c]{0.3\textwidth}

>     meaning (mempty <> b)
> ==  meaning mempty <> meaning b
> ==  mempty <> meaning b
> ==  meaning b

\end{minipage}}
\fbox{\begin{minipage}[c]{0.39\textwidth}

>     meaning (a <> (b <> c))
> ==  meaning a <> (meaning b <> meaning c)
> ==  (meaning a <> meaning b) <> meaning c
> ==  meaning ((a <> b) <> c)

\end{minipage}}
\end{center}

Works for other classes as well.
}


%if True
\framet{Example: functional reactive programming}{

See previous talks:

\begin{itemize}\itemsep2ex
\item \href{https://github.com/conal/talk-2015-essence-and-origins-of-frp/}{\emph{The essence and origins of FRP}}
\item \href{https://github.com/conal/talk-2015-more-elegant-frp}{\emph{A more elegant specification for FRP}}
\end{itemize}
}

%else

\framet{Example: functional reactive programming}{

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

\framet{Why continuous \& infinite (vs discrete/finite) time?}{
\pause
\begin{itemize}\parskip0.3ex
\item Transformation flexibility with simple \& precise semantics
\item Efficiency (adapative)
\item Quality/accuracy
\item Modularity/composability:
  \begin{itemize}
  \item Fewer assumptions, more uses (resolution-independence).
  \item More info available for extraction.
  \item Same benefits as pure, non-strict functional programming.\\
        See \href{http://www.cse.chalmers.se/~rjmh/Papers/whyfp.html}{\emph{Why Functional Programming Matters}}.
  \end{itemize}
\pitem Integration and differentiation: natural, accurate, efficient.
\pitem Reconcile differing input sampling rates.
\end{itemize}

\pause
% Approximations/prunings compose badly, so postpone.
{\color{blue}
\fbox{\normalcolor\emph{Principle:} Approximations/prunings compose badly, so postpone.}
}


%% \item Strengthen induction hypothesis
}
%endif

\framet{Example: uniform pairs}{

Type:

> data Pair a = a :# a

~

API: |Monoid|, |Functor|, |Applicative|, |Monad|, |Foldable|, |Traversable|.

\out{
\begin{itemize}
\item How to implement the methods? \pause (Answer: ``Correctly''.)
\item More fundamentally, what should the methods mean?
\end{itemize}
}

\pause\vspace{6ex}

Specification follows from simple \& precise denotation.

% What is it?
}

\framet{Uniform pairs --- denotation}{

\pause
|Pair| is an \emph{indexable} container.
What's the index type?
\pause

> type P a = Bool -> a

> meaning :: Pair a -> P a

\pause\vspace{-8ex}

> meaning (u :# v) False = u
> meaning (u :# v) True  = v

\out{
Equivalently,

> meaning (u :# v) = \ b -> if b then v else u

}

API specification? \pause Homomorphisms, as usual!
}

\framet{Uniform pairs --- monoid}{

Monoid homomorphism:

> meaning mempty    == mempty
> meaning (u <> v)  == meaning u <> meaning v

\pause
In this case,

> instance Monoid m => Monoid (z -> m) where
>   mempty  = \ z -> mempty
>   f <> g  = \ z -> f z <> g z

\pause
so

> meaning mempty    == \ z -> mempty
> meaning (u <> v)  == \ z -> meaning u z <> meaning v z

Implementation: solve for |mempty| and |(<>)| on the left.
\pause
Hint: find |meaningInv|.

}

\framet{Uniform pairs --- other classes}{
Exercise: apply the same principle for
\begin{itemize}
\item |Functor|
\item |Applicative|
\item |Monad|
\item |Foldable|
\item |Traversable|
\end{itemize}
}

\framet{Example: streams}{

> data Stream a = Cons a (Stream a)

API: same classes as with |Pair|.

Denotation?
\pause
Hint: |Stream| is also an indexable type.

\pause

> data S a = Nat -> a
> 
> data Nat = Zero | Succ Nat

Interpret |Stream| as |S|:

> mu :: Stream a -> S a
> mu (Cons a _ )  Zero      = a
> mu (Cons _ as)  (Succ n)  = mu as n

}


\framet{Memo tries}{

Generalizes |Pair| and |Stream|:

> type a :->: b
>
> meaning :: (a :->: b) -> (a -> b)

API: classes as above, plus |Category|.

% This time, |meaning| has an inverse.

\vspace{2ex}

Exploit inverses to calculate instances, e.g.,

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

Then simplify/optimize.
}

\framet{Example: lists with a bonus}{

> data ListX a b = Done b | Cons a (ListX a b)

Denotation:\pause

> mu :: ListX a b -> ([a],b)
> mu (Done b)      = ([],b)
> mu (Cons a asb)  = (a:as,b) where (as,b) = mu asb

Exercise: instances, including

> instance Monad (ListX a) where ...

\pause
Then generalize from lists to arbitrary monoid.

}

\framet{Example: linear transformations}{
\emph{Assignment:}
\begin{itemize}
\item Represent linear transformations
\item Scalar, non-scalar domain \& range, identity and composition
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
\item \href{http://conal.net/papers/type-class-morphisms/}{\emph{Denotational design with type class morphisms}}
\item \href{http://conal.net/papers/push-pull-frp/}{\emph{Push-pull functional reactive programming}}
\item \href{http://conal.net/Pan}{Functional images (Pan)} page with pictures \& papers.
\item \href{http://conal.net/blog/tag/http://conal.net/blog/tag/type-class-morphism/}{Posts on type class morphisms}
\item \href{http://conal.net/blog/posts/reimagining-matrices}{\emph{Reimagining
matrices}}
\item \href{https://github.com/conal/talk-2014-lambdajam-denotational-design}{This workshop}

%% \item \href{http://conal.net/blog/posts/early-inspirations-and-new-directions-in-functional-reactive-programming/}{\emph{Early inspirations and new directions in functional reactive programming}}

\end{itemize}
}

\end{document}
