## Talk: *Denotational Design: from programs to meanings*

Given at [BayHac 2014](http://www.haskell.org/haskellwiki/BayHac2014).

[Slides PDF](http://conal.net/talks/bayhac-2014.pdf).

### Abstract

In this talk, I'll share a methodology that I have applied many times over the last 20+ years when designing high-level libraries for functional programming.
Functional libraries are usually organized around small collections of domain-specific data types together with operations for forming and combining values of those types.
When done well, the result has the elegance and precision of algebra on numbers while capturing much larger and more interesting ideas.

A library has two aspects with which all programmers are familiar: the programming interface (API) and its implementation.
We want the implementation to be efficient and *correct*, since it's (usually) not enough to select arbitrary code for the implementation.
To get clear about what constitutes correctness, and avoid fooling ourselves with vague, hand-waving statements, we'll want a precise specification, independent of any implementation.
Fortunately, there is an elegant means of specification available to functional programmers: give a (preferably simple) mathematical *meaning* (model) for the types provided by a library, and then define each operation as if it worked on meanings rather than on representations.
This practice, which goes by the fancy name of "denotational semantics" (invented to explain programming languages rigorously), is very like functional programming itself, and so can be easily assimilated by functional programmers.

Rather than using semantics to *explain* an existing library (or language), we can instead use it to *design* one.
It is often much easier and more enlightening to define a denotation than an implementation, because it does not have any constraints or distractions of efficiency, or even of executability.
As an example, this style gave rise to [Functional Reactive Programming (FRP)](http://stackoverflow.com/questions/5875929/specification-for-a-functional-reactive-programming-language/5878525#5878525), where the semantic model of "behaviors" (dynamic values) is simply functions of infinite, continuous time.
Similarly, the [Pan system](http://conal.net/Pan) applies this same idea to space instead of time, defining the semantics of an "image" to be a function over infinite, continuous 2D space.
Such meanings effectively and precisely capture the essence of a library's intent without the distraction of operational details.
By doing so, these meanings offer library users a simpler but precise understanding of a library, while giving library developers an unambiguous definition of exactly *what* specification they must implement, while leaving a great deal of room for creativity about *how*.
I call this methodology "Denotational Design", because it is design focused on meaning (denotation).

The talk and workshop will present the principles and practice of Denotational Design through examples.
I will use Haskell, where purity and type classes are especially useful to guide the process.
Once understood, the techniques are transferable to other functional languages as well.
If you'd like a sneak peak, see the paper [*Denotational design with type class morphisms*](http://conal.net/papers/type-class-morphisms/) and some [related blog articles](http://conal.net/blog/tag/type-class-morphism).

### Why continuous time matters

Some follow-up remarks, based on questions & discussion during and after the talk:

*   Continuous time matters for exactly the same reason that laziness (non-strictness) matters, namely modularity.
    (See [*Why Functional Programming Matters*](http://www.cse.chalmers.se/~rjmh/Papers/whyfp.html).)
    Modularity comes from providing information while making as few restrictive assumptions as possible about how that information can be used.
    Laziness lets us build infinite data structures, thus not assuming what finite subset any particular usage will access.
    By also not assuming the *frequency* of sampling (even that it's constant), continuous time and space place even fewer restrictions about what finite subset of information will be accessed and is thus even more modular.
*   Continuous time allows integration and differentiation to be expressed directly and meaningfully.
    In discrete-time systems, one instead has to clutter programs by including numeric approximation algorithms for integration and differentiation, usually via very badly behaved algorithm such as Euler integration and naïve finite differencing.
    For instance, in games, it's typical to have a character move based on user-chosen direction, plus forces like gravity & drag.
    In comparison with a direct continuous specification via integration, the result is inaccurate, and the program fails to say what it means (and instead says one way to approximate it).
    Switching to a better algorithm would mean further complicating an application with operational distractions.
    In contrast, even in [TBAG](http://conal.net/tbag/) (an early '90s predecessor to the FRP systems ActiveVRML and Fran), thanks to continuous time we were able to express examples in a very natural way as systems of ODEs (expressed via mutually recursive integrals) and then solve them automatically, using a fourth-order Runge-Kutta with adaptive step size determination.
*   Multiple discrete input sources typically enter the system at different rates.
    Combining them in discrete-time systems thus leads to awkward issues of alignment.
    With continuous behaviors/signals, there are no rates to be out of sync.
    In other words, the alignment is done automatically (to infinite resolution) as soon as the discrete streams enter the system.
    Afterward, combining them is effortless and easily given a precise description.
*   With continuous time, implementations can intelligently adapt sampling rates for accuracy and efficiency.
    For instance, slowly-changing signals can be sampled (discretized for output) less frequently than rapidly-changing signals.
    In contrast, discrete-time systems prematurely (and often arbitrarily) commit to sampling rates before knowing and usually a single sampling rate.
    Uniform rates waste computation for some signals while under-sampling others.
