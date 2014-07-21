To do :

*   Perhaps start out with *benefits*, and use them to motivate principles:
    *   Correctness---defined and satisfied.
        *   Most programs are "not even wrong", since they lack a clear notion of *correct*.
        *   If the implementation *is* the specification, then every implementation is correct.
    *   Familiar interfaces/abstractions supported by the larger ecosystem.
        In Haskell, standard type classes (`Monoid`, `Functor`, `Foldable`, `Traversable`, `Applicative`, `Monad`, `Category`, etc).
    *   Satisfy the laws required by those classes.
*   Draw out discussion of continuous vs discrete space for images.
    *   Also ask "Why infinite?"
    *   Show the big picture: bitmap in and bitmap out.
*   Shift to a standard vocabulary:
    *   Classes: `Monoid`, `Functor`, `Applicative`, `Monad`, `Comonad`.
    *   Why standardize the vocabulary?
        *   User knowledge
        *   Ecosystem support (multiplicative)
        *   Laws as sanity check
        *   Tao check
        *   What comes next
    *   Re-examine the specifications (TCMs)
*   Highlight TCM property
*   Reconsider the talk structure:
    Is it really an informal argument followed by more rigorous ones?
    Maybe instead, it's the *algebraic* aspect that emerges.

Done:

*   Informal example: image synthesis/manipulation
