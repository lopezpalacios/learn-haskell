# Chapter 5 — Solutions

## 1. Double all

```haskell
doubleAll :: [Int] -> [Int]
doubleAll = map (*2)
```

`map (*2)` is a partially applied function: it is waiting for the list.

## 2. Keep the even numbers

```haskell
keepEven :: [Int] -> [Int]
keepEven = filter even
```

`even` is the predicate; `filter` keeps the elements for which it returns `True`.

## 3. Sum with a fold

```haskell
sumList :: [Int] -> Int
sumList = foldr (+) 0
```

`foldr` replaces `:` with `+` and `[]` with `0`.

## 4. Compose three functions

```haskell
compose3 :: (c -> d) -> (b -> c) -> (a -> b) -> a -> d
compose3 f g h = f . g . h
```

`f . g . h` means `\x -> f (g (h x))`. For the example: `negate 3 = -3`, `(*2) (-3) = -6`, `(+1) (-6) = -5`.

## 5. Apply twice

```haskell
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)
```

The function is applied to its own result.
