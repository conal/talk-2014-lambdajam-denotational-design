# Notes on a Denotational Design talk

 <!-- References -->

[*Another lovely example of type class morphisms*]: http://conal.net/blog/posts/another-lovely-example-of-type-class-morphisms/ "blog post"

[*Composing memo tries*]: http://conal.net/blog/posts/composing-memo-tries/ "blog post"

[*Denotational design with type class morphisms*]: http://conal.net/papers/type-class-morphisms/ "Paper"

[*Reimagining matrices*]: http://conal.net/blog/posts/reimagining-matrices "blog post"

[*Can Programming Be Liberated from the von Neumann Style? A Functional Style and Its Algebra of Programs*]: http://www.thocp.net/biographies/papers/backus_turingaward_lecture.pdf "John Backus's 1977 Turing Award lecture"

[*The Next 700 Programming Languages*]: http://www.cs.cmu.edu/~crary/819-f09/Landin66.pdf "Paper by Peter Landin (1966)"

## Miscellaneous thoughts

Some thoughts on my denotational design talk from last week:

Most programming puts how before the what.
For me, the essence of functional programming is as a clear and precise illuminating language with which explore the what.
Insert Dykstra quote about computer science and telescopes.
However, even functional programming can be used in a way that focuses on how and neglects what.
How can we be more clear about what?
I don't think the answer is to be found in software engineering, which places software as a primary artifact.
To me, software has always been a means to an end, not an end unto itself.
So what is the end of that interest me?
It is ideas.
These ideas, of course, could be about machines programs and execution and so on, but those areas are not my particular kink.
No offense to anyone who is into machines for their own sake.
Engineering is a fine discipline.

What makes programs so interesting?
They are just utterances, aren't they?
Why do we feel compelled to put so much of our time and thought into this particular form utterance?
What makes it different from others?
What are some defining characteristics of programming as a means of expression?
One characteristic is that these utterances are executable.
But what really makes them executable?
What distinguishes them from other forms?
I want to suggest that unambiguity is one important characteristic.
Now, if unambiguity is so important, we would probably like to experience that value elsewhere.
What about the goals that we are trying to accomplish by our programs?
What about the ends to which our program are the means?
I have the impression that too many or perhaps most programmers, programming is about making machines do things.
I wonder, however, what makes a person to want to control machines, or to control anyone/anything, for that matter.

"If a man points at the moon, an idiot will look at the finger." (Sufi wisdom.)
I want to suggest that as programmers, we have become beguiled, in the sense of the quote above.
Computers were designed by mathematicians to solve mathematical problems.
Over time, the programmers have become the programmees.
("We shape our tools and afterwards our tools shape us." - Marshall McLuhan)
For the most part, we have become so enchanted by our tools that we have mostly abandoned the original enterprise.

If I have a clear understanding of a problem I want to solve, or a domain of thought I want to explore, then I can try to use the machine as a telescope or microscope through which to examine my questions of interest.

Talk about popularity and dilution.
How can I broach this subject in a way that is clear and preferably not too offensive for people to listen to?

## Talk notes

### Math vs programming

How do math and programming compare?
Some thoughts:

*   Math is precise & rigorous, while programming is informal & heuristic.
*   Math is abstract/theoretical, while programming is concrete/applied.
*   Math is about being, while programming is about doing.

Can we bring the strengths of math into programming?
You might think that functional programming does just that.
I want to suggest that FP *can* combine these strengths, but it usually doesn't, even for Haskell.
Furthermore, I'll say that functional programming---including Haskell---has largely lost its unique essential strength on the road to popularity, particularly with what's commonly (and misleadingly) called "monadic IO".

----

The idea of "denotational design" is to use *meanings* (denotations) to as a rigorous and practical basis for designing and developing programs.

What do I mean by "meanings"?
Simply, mathematical values, which needn't be the sort of values we manipulate in programs.

In DD, we distinguish between program types and mathematical types, *and* we make a precise connection between the two.
The connection plays the following crucial roles:

*   It guides the design of an API.
*   It precisely specifies what it means for an implementation to be *correct*, without unduly constraining implementation freedom.
*   It provides a discipline for constructing correct implementations.
*   It guarantees that all class laws hold.

A host language and library provides a basic set of types *and* their denotations.
For instance, in Haskell, we have the type `Integer`, which denotes integers plus bottom.
We also have the type `a -> b`, which denotes a particular class of functions from $A$ to $B$, where `a` and `b` denote $A$ and $B$ respectively.
Not just any functions, but the *continuous* ones, where "continuous" refers to information-monotonicity and limits.

Importantly, not all types in Haskell have denotations.
For this reason, there is a "denotative" subset and a non-denotative subset.
The rigor & elegance follows from the denotative subset and does not apply to the rest of the language.
A prime non-denotative example is what's called "`IO`".
That type is "magical", which I define as having an implementation but no denotation.
(There is a popular but false myth that `IO` is simply the `State` monad specialized to pass the "world" as state. Even if we knew of a correct denotation, it would almost certainly be too complicated for practical use.)

One of the earliest software designs to which I applied DD is what came to be called "functional reactive programming" or "FRP".
Sadly, in popular usage, "FRP" has come to refer to something very different from its original definition, losing its essential characteristics and with it its precision and deep elegance.
I'll talk about what I originally meant and still mean, as contrasted with popular notions.

The DD approach to software design always begins with the same question:

 > What are the things represented by our programs?

Most of the insight and essence comes from hanging out with this question.
Candidate answers will be mathematical "models", i.e., values of a precisely defined mathematical type.
Candidates must satisfy the following properties:

*   Precise --- mathematical rather than hand-waving, to steer clear of deception
*   Adequate --- expressive enough for our programming purposes

Among the precise and adequate candidates, we want to optimize for the following properties:

*   Simple --- for practical reasoning and accurate intuition
*   Compelling --- ...

## Quotes

"The purpose of abstraction is not to be vague, but to create a new semantic level in which one can be absolutely precise." - Edsger Dijkstra

## Talk design thoughts

*   Start with at least one simple example to ground the upcoming abstract explanation.

### Examples

*   FRP: dynamic values / variation over time
*   Image manipulation: variation over space
*   Efficient finite maps (from DD/TCM paper)
*   [Memo tries][*Composing memo tries*]
*   [Matrices][*Reimagining matrices*]
*   [Fold fusion][*Another lovely example of type class morphisms*]

From [*Can Programming Be Liberated from the von Neumann Style? A Functional Style and Its Algebra of Programs*]:
 <blockquote>

Conventional programming languages are growing ever more enormous, but not stronger. Inherent defects at the most basic level cause them to be both fat and weak: their primitive word-at-a-time style of programming inherited from their common ancestor---the von Neumann computer, their close coupling of semantics to state transitions, their division of programming into a world of expressions and a world of statements, their inability to effectively use powerful combining forms for building new programs from existing ones, and their lack of useful mathematical properties for reasoning about programs.

 </blockquote>

From [*The Next 700 Programming Languages*]:
 <blockquote>

The commonplace expressions of arithmetic and algebra have a certain simplicity that most communications to computers lack. In particular, (a) each expression has a nesting subexpression structure, (b) each subexpression denotes something (usually a number, truth value or numerical function), (c) the thing an expression denotes, i.e., its "value", depends only on the values of its sub-expressions, not on other properties of them.

It is these properties, and crucially (c), that explains why such expressions are easier to construct and understand. Thus it is (c) that lies behind the evolutionary trend towards "bigger righthand sides" in place of strings of small, explicitly sequenced assignments and jumps. When faced with a new notation that borrows the functional appearance of everyday algebra, it is (c) that gives us a test for whether the notation is genuinely functional or merely masquerading.

 </blockquote>

----

# Some thoughts on updating my BayHac 2014 talk for LambdaJam 2014.

Postpone naming "homomorphism".
Instead, say that I want a *leak-free abstraction*.
Maybe postpone mentioning abstract algebra.

For semantic models, maybe talk about a "reference implementation", noting that it doesn't have to be executable.

Set up specification as equations, and *solve for* an implementation.
Given the API and semantic model, what degrees of freedom are there?

*   Representation
*   Semantic function

Examples:

*   Images
*   FRP
*   Linear maps
*   Automatic differentiation (?)

> mu :: (a -> b) -> (a ~> b)
> mu f = (f, der f)

> mu id = id
> mu (g . f) = mu g . mu f

> (g, der g) . (f, der f) = (g . f, der (g . f))

> der (g . f) == (der g . f) * der f

Maybe talk about exact information for modularity.
Approximations do not compose nicely, because they throw away information prematurely.
The only safe time to discard information is when composition is complete, and we know exactly what finite subset of the larger information we will be extracting.
Examples:

*   finite lists, trees, etc, hence non-strict ("lazy") languages;
*   discrete time & space;
*   finite precision values (24-bit RGB, floating point numbers)

[John Backus on denotation for design]:

From section 9 of John Backus's 1977 Turing Award lecture [*Can Programming Be Liberated from the von Neumann Style? A Functional Style and Its Algebra of Programs*](http://www.thocp.net/biographies/papers/backus_turingaward_lecture.pdf):

 <blockquote>

Denotational semantics and its foundations provide an extremely helpful mathematical understanding of the domain and function spaces implicit in programs. When applied to an applicative language (...), its foundations provide powerful tools for describing the language and for proving properties of programs. When applied to a von Neumann language, on the other hand, it provides a precise semantic description and is helpful in identifying trouble spots in the language. But the complexity of the language is mirrored in the complexity of the description, which is a bewildering collection of productions, domains, functions, and equations that is only slightly more helpful in proving facts about programs than the reference manual of the language, since it is less ambiguous.

...

Thus denotational and axiomatic semantics are descriptive formalisms whose foundations embody elegant and powerful concepts; but using them to describe a von Neumann language can not produce an elegant and powerful language any more than the use of elegant and modern machines to build an Edsel can produce an elegant and modern car.

 </blockquote>

Maybe use right after the slide on "denotative programming", with Landin's quote.

Modular reasoning!
Simple *denotation*.
Multiplicative power without multiplicative complexity.
Dijkstra's "The Humble Programmer".

Give an example of DD before defining it or mentioning "denotation" or "homomorphism".

Use images or behavior.
Probably images first and then frp.

Goal: manipulate and synthesize imagery.

*   Choose what operations to support.
*   Implement them correctly and efficiently.
*   Explain to users.

Question:
How can we construct a correct implementation?

More fundamental question:
How can we *know* whether an implementation is correct?

*   Tests:
    *   Can't show correctness
    *   Where do we get the tests?
*   Specification:
    *   Define correctness precisely and without biasing implementation.
    *   Could be a simple reference implementation.
    *   Better: a crisp and compelling *definition* of the domain.
        *   Needn't be executable.
        *   Must be precise.
        *   Simplicity for correct & practical reasoning and insight.

Specification.
Basic questions:

*   What is an image?
*   What operations to support?

The specification is a model.
We're talking about images, not technology.
Notice temptation to shift to technology.

Brainstorm.
Criteria:

*   Precise (ferret out bogus assumptions)
*   Adequate
*   Simple (relies on precise)
*   Compositional

Why is "efficiency" missing from this list?
Because it's not a property of specifications.

Implementation.
Once we release assumptions/habits like finiteness and discreteness, is what remains even relevant to programming?
What do we try to implement?

*   An approximation with well-defined distance.
*   Finite information subset.

Thought question:
If we start and end with finite & discrete, why go infinite and continuous in the middle?

How to decide on vocabulary?
Some possibilities:

*   What we want
*   What we think others want
*   What the model suggests
*   Powerful, well-supported abstractions
