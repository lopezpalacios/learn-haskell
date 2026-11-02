# Chapter 8 — Functors, Applicatives, and Monads

## Learning objectives

By the end of this chapter you will be able to:

- Explain what a `Functor` is and use `fmap` / `<$>`.
- Explain what an `Applicative` is and use `pure` and `<*>`.
- Explain what a `Monad` is and use `>>=` and `do`.
- Write instances for a small custom type.
- Recognize the same structure in `Maybe`, lists, and `IO`.

## Key terms

**Functor**, **`fmap`**, **Applicative**, **`pure`**, **`<*>`**, **Monad**, **`>>=`**, **`do` notation**, **context**.

## 8.1 The problem

Some values come with a context:

- `Maybe a` — a value that may be missing.
- `[a]` — zero or more values.
- `IO a` — a value produced by an effect.

We want to apply ordinary functions inside these contexts without unwrapping them manually. Type classes give us a uniform interface.

## 8.2 Functor

A `Functor` is something that can be mapped over.

```haskell
class Functor f where
  fmap :: (a -> b) -> f a -> f b
```

`f` is a type constructor, not a concrete type. `Maybe` is a `Functor`; `Maybe Int` is a concrete type.

```haskell
instance Functor Maybe where
  fmap _ Nothing  = Nothing
  fmap f (Just x) = Just (f x)
```

```haskell
ghci> fmap (+1) (Just 3)
Just 4
ghci> fmap (+1) Nothing
Nothing
ghci> fmap (*2) [1,2,3]
[2,4,6]
```

`<$>` is infix `fmap`:

```haskell
ghci> (+1) <$> Just 3
Just 4
```

## 8.3 Applicative

An `Applicative` is a `Functor` that can apply a wrapped function to a wrapped value.

```haskell
class Functor f => Applicative f where
  pure  :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b
```

```haskell
instance Applicative Maybe where
  pure = Just
  Nothing <*> _ = Nothing
  Just f  <*> mx = fmap f mx
```

```haskell
ghci> Just (+1) <*> Just 3
Just 4
ghci> Just (+) <*> Just 3 <*> Just 4
Just 7
ghci> Just (+1) <*> Nothing
Nothing
```

`pure` puts a plain value into the context. `<*>` applies a function that is itself in the context.

This is useful for validation: if any part is `Nothing`, the whole result is `Nothing`.

```haskell
data Person = Person String Int deriving (Show)

mkPerson :: String -> Int -> Maybe Person
mkPerson name age
  | null name = Nothing
  | age < 0   = Nothing
  | otherwise = Just (Person name age)
```

## 8.4 Monad

A `Monad` is an `Applicative` that can sequence computations that depend on previous results.

```haskell
class Applicative m => Monad m where
  (>>=) :: m a -> (a -> m b) -> m b
```

```haskell
instance Monad Maybe where
  Nothing >>= _ = Nothing
  Just x  >>= f = f x
```

```haskell
ghci> Just 3 >>= \x -> Just (x + 1)
Just 4
ghci> Nothing >>= \x -> Just (x + 1)
Nothing
```

`>>=` is “bind.” It takes a contextful value and a function that returns a contextful value, and chains them.

`do` notation is sugar for `>>=`:

```haskell
addMaybe :: Maybe Int -> Maybe Int -> Maybe Int
addMaybe mx my = do
  x <- mx
  y <- my
  pure (x + y)
```

```haskell
ghci> addMaybe (Just 3) (Just 4)
Just 7
ghci> addMaybe (Just 3) Nothing
Nothing
```

The `do` block reads like imperative code, but it is ordinary function composition. If any step is `Nothing`, the rest is skipped.

## 8.5 The list monad

Lists are also monads. `>>=` means “for each element, produce a list, and concatenate the results.”

```haskell
ghci> [1,2] >>= \x -> [3,4] >>= \y -> pure (x, y)
[(1,3),(1,4),(2,3),(2,4)]
```

This is the same result as the list comprehension:

```haskell
ghci> [(x, y) | x <- [1,2], y <- [3,4]]
[(1,3),(1,4),(2,3),(2,4)]
```

The list monad models nondeterminism: every branch is explored.

## 8.6 IO

`IO` is a monad too. It sequences actions that interact with the world.

```haskell
main :: IO ()
main = do
  putStrLn "What is your name?"
  name <- getLine
  putStrLn ("Hello, " ++ name)
```

`putStrLn` produces an `IO ()`; `getLine` produces an `IO String`. The `<-` in a `do` block unwraps the `IO` value and binds it to a name. `main` is the entry point.

`IO` does not make functions impure. A function that returns `IO a` is a pure function that describes an effect. The runtime performs the effect when the program runs.

## Worked example: safe arithmetic with `Maybe`

```haskell
safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv x y = Just (x `div` y)

safeAverage :: Int -> Int -> Int -> Maybe Int
safeAverage x y n = do
  total <- Just (x + y)
  result <- safeDiv total n
  pure result
```

```haskell
ghci> safeAverage 10 20 2
Just 15
ghci> safeAverage 10 20 0
Nothing
```

The `do` block sequences the two steps. If `safeDiv` returns `Nothing`, the whole computation returns `Nothing`.

## Exercises

For exercises 1–3, define your own type so you can write the instances:

```haskell
data MyMaybe a = MyNothing | MyJust a
  deriving (Show, Eq)
```

1. **Functor.** Write `instance Functor MyMaybe` with `fmap`. `fmap (+1) (MyJust 3)` should be `MyJust 4`; `fmap (+1) MyNothing` should be `MyNothing`.

2. **Applicative.** Write `instance Applicative MyMaybe` with `pure` and `<*>`. `MyJust (+1) <*> MyJust 3` should be `MyJust 4`.

3. **Monad.** Write `instance Monad MyMaybe` with `>>=`. `MyJust 3 >>= \x -> MyJust (x + 1)` should be `MyJust 4`.

4. **List monad.** Use `>>=` to generate all pairs `(x, y)` with `x` from `[1,2]` and `y` from `[3,4]`. The result should be `[(1,3),(1,4),(2,3),(2,4)]`.

5. **Desugar `do`.** Rewrite this function using `>>=` instead of `do`:
   ```haskell
   addMaybe :: Maybe Int -> Maybe Int -> Maybe Int
   addMaybe mx my = do
     x <- mx
     y <- my
     pure (x + y)
   ```

## Chapter summary

- A `Functor` maps a function inside a context with `fmap` or `<$>`.
- An `Applicative` applies a wrapped function to a wrapped value with `<*>`; `pure` lifts a plain value.
- A `Monad` sequences contextful computations with `>>=`; `do` is sugar for `>>=`.
- `Maybe`, lists, and `IO` are all monads, but they model different contexts.
- A function returning `IO a` is pure; the runtime performs the effect.
