## Talk: *Denotational Design: from programs to meanings*

A workshop held at [LambdaJam](http://lambdajam.com) on July 23, 2014 in Chicago.

[Slides PDF](http://conal.net/talks/lambdajam-2014.pdf).

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
As an example, this style gave rise to [Functional Reactive Programming (FRP)](http://stackoverflow.com/questions/5875929/specification-for-a-functional-reactive-programming-language/5878525#5878525), in which the semantic model of "behaviors" (dynamic values) was simply functions of infinite, continuous time.
Similarly, the [Pan system](http://conal.net/Pan) applies this same idea to space instead of time, defining the semantics of an "image" to be a function over infinite, continuous 2D space.
Such meanings effectively and precisely capture the essence of a library's intent without the distraction of operational details.
By doing so, these meanings offer library users a simpler but precise understanding of a library, while giving library developers an unambiguous definition of exactly *what* specification they must implement, while leaving a great deal of room for creativity about *how*.
I call this methodology "Denotational Design", because it is design focused on meaning (denotation).

The workshop will present the principles and practice of Denotational Design through examples.
I will use Haskell, where purity and type classes are especially useful to guide the process.
Once understood, the techniques are transferable to other functional languages as well.
If you'd like a sneak peak, see the paper [*Denotational design with type class morphisms*](http://conal.net/papers/type-class-morphisms/) and some [related blog articles](http://conal.net/blog/tag/type-class-morphism).
