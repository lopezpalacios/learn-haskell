# Glossary

**Applicative.** A type class for computations that can be applied inside a context. `pure` wraps a value; `<*>` applies a wrapped function to a wrapped argument.

**Argument.** A value passed to a function.

**Currying.** Representing a function of several arguments as a chain of one-argument functions. `a -> b -> c` means `a -> (b -> c)`.

**Expression.** Code that produces a value. `2 + 2`, `"hello"`, and `\x -> x` are expressions.

**Functor.** A type class for things that can be mapped over. `fmap` applies a function inside the context without changing the context.

**Function.** A mapping from an input to an output. In Haskell, functions are values.

**GHCi.** The interactive REPL that comes with GHC.

**Instance.** A declaration that a type implements a type class.

**List.** A homogeneous sequence of values. `[1,2,3]` is a list of numbers.

**Monad.** A type class for computations that can be sequenced. `>>=` chains a computation with a function that returns another computation.

**Pattern matching.** Destructuring a value by its shape, for example `(x, y)` for a pair or `Just x` for a `Maybe`.

**Polymorphism.** Writing code that works for more than one type. Parametric polymorphism uses type variables; ad-hoc polymorphism uses type classes.

**Pure function.** A function whose output depends only on its input and which has no side effects.

**Recursion.** A function that calls itself. Every recursive definition needs a base case and a recursive case.

**Tuple.** A fixed-size group of values, possibly of different types. `(1, "one")` is a pair.

**Type.** A classification of values. `Int`, `Bool`, `String`, and `Maybe Int` are types.

**Type class.** A set of operations that several types can implement. `Eq`, `Ord`, `Num`, and `Show` are type classes.

**Type signature.** A declaration of a value's type, written with `::`.

**Type variable.** A placeholder for a type, usually written in lowercase: `a`, `b`, `x`.

**Value.** A piece of data. `4`, `True`, and `"hello"` are values.
