# Chapter 8 — Solutions

## 1. Functor

```haskell
instance Functor MyMaybe where
  fmap _ MyNothing  = MyNothing
  fmap f (MyJust x) = MyJust (f x)
```

`fmap` maps the function inside `MyJust` and leaves `MyNothing` untouched.

## 2. Applicative

```haskell
instance Applicative MyMaybe where
  pure = MyJust
  MyNothing <*> _ = MyNothing
  MyJust f  <*> mx = fmap f mx
```

`pure` wraps a value. `<*>` applies a wrapped function; if either side is `MyNothing`, the result is `MyNothing`.

## 3. Monad

```haskell
instance Monad MyMaybe where
  MyNothing >>= _ = MyNothing
  MyJust x  >>= f = f x
```

`>>=` short-circuits on `MyNothing` and applies `f` on `MyJust`.

## 4. List monad

```haskell
pairs :: [(Int, Int)]
pairs = [1,2] >>= \x -> [3,4] >>= \y -> pure (x, y)
```

`pure (x, y)` for lists is `[(x, y)]`. The nested binds produce every combination.

## 5. Desugar `do`

```haskell
addMaybe :: Maybe Int -> Maybe Int -> Maybe Int
addMaybe mx my = mx >>= \x -> my >>= \y -> pure (x + y)
```

The `do` block is sugar for this chain. If either `mx` or `my` is `Nothing`, the chain short-circuits.
