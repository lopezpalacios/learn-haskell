# Learn Haskell

**A type-first Haskell textbook with theory, worked examples, and five exercises per chapter.**

This is a working book for developers who want to learn Haskell properly: not a list of syntax tricks, but a sequence of ideas that build on each other. Every chapter explains the concept, shows it in code, and gives you five exercises. Solutions are included, but they are in a separate folder for a reason — try the exercise first.

## Who this is for

- Developers who already know another language and want a structured path into Haskell.
- Students who want a readable supplement to a course.
- Anyone who prefers small, complete chapters over a 1,000-page reference.

No prior Haskell is assumed. Prior programming experience is.

## What makes this book different

- **Type-first.** Types are introduced as specifications, not decoration. The type tells you what a function can do before you read its body.
- **Five exercises per chapter.** Enough to practice, few enough to finish.
- **Worked examples.** Every concept is shown on a small, complete example.
- **No magic.** GHCi, type signatures, pattern matching, recursion, higher-order functions, modules, custom types, functors, applicatives, and monads are built in order.
- **Solutions, not answer keys.** The solutions explain the shape of the answer, not just the code.

## Table of contents

1. [Starting Out](book/01-starting-out.md) — GHCi, expressions, functions, lists, ranges, comprehensions, tuples.
2. [Types and Typeclasses](book/02-types-and-typeclasses.md) — type signatures, type variables, currying, `Num`, `Eq`, `Ord`, `Show`.
3. [Syntax in Functions](book/03-syntax-in-functions.md) — pattern matching, guards, `where`, `let`, `case`.
4. [Recursion](book/04-recursion.md) — base cases, recursive cases, quicksort.
5. [Higher-Order Functions](book/05-higher-order-functions.md) — `map`, `filter`, folds, composition, `$`.
6. [Modules](book/06-modules.md) — exports, imports, `Data.List`, `Data.Char`, `Data.Map`.
7. [Custom Types and Typeclasses](book/07-custom-types-and-typeclasses.md) — `data`, `newtype`, `deriving`, `Maybe`, `Either`, your own classes.
8. [Functors, Applicatives, and Monads](book/08-functors-applicatives-monads.md) — `fmap`, `<*>`, `>>=`, `do`, and why they matter.

Appendices:

- [Setup](appendix/setup.md) — GHCup, Cabal, GHCi, Docker.
- [Glossary](appendix/glossary.md) — the terms used throughout the book.

## How to use this book

1. **Read the chapter once without a compiler.** Follow the argument.
2. **Read it again with GHCi open.** Type every example. Predict the result before you press Enter.
3. **Do the five exercises before looking at the solutions.** Write them in `exercises/chapter-XX.hs` or in GHCi.
4. **Check the solution, then rewrite yours from memory.** The second rewrite is where the learning happens.
5. **Keep a type-error journal.** For every error, write the error, the plain-English meaning, the fix, and the lesson.

## Running the code

The quickest path is GHCi:

```bash
ghci
```

Then:

```haskell
:l exercises/chapter-01.hs
:r
```

If you do not have GHC installed, see [Setup](appendix/setup.md). A Docker fallback is included.

## Verification

Every solution module typechecks under GHC 9.2.4, and the 40 checks in `tests/Verify.hs` pass.

```bash
runghc -isolutions tests/Verify.hs
```

With Docker:

```bash
docker run --rm -v "$PWD":/work -w /work haskell:9.2.4-slim \
  runghc -isolutions tests/Verify.hs
```

## Status

This is a working draft. Chapters 1–8 are complete; more advanced topics (monad transformers, GADTs, type-level programming, testing, performance) are planned.

## License

MIT. See [LICENSE](LICENSE).
