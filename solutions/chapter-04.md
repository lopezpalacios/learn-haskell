# Chapter 4 — Solutions

## 1. Factorial

```haskell
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)
```

The base case is `0`; the recursive case moves toward it.

## 2. Sum

```haskell
sumList :: [Integer] -> Integer
sumList []     = 0
sumList (x:xs) = x + sumList xs
```

The two list shapes are `[]` and `x : xs`.

## 3. Power

```haskell
power :: Integer -> Integer -> Integer
power _ 0 = 1
power x n = x * power x (n - 1)
```

The base case is exponent `0`. For `n > 0`, multiply once and recurse with `n - 1`.

## 4. Replicate

```haskell
replicate' :: Int -> a -> [a]
replicate' n x
  | n <= 0    = []
  | otherwise = x : replicate' (n - 1) x
```

The guard handles zero and negative counts.

## 5. Quicksort

```haskell
quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
  quicksort [y | y <- xs, y <= x]
  ++ [x]
  ++ quicksort [y | y <- xs, y > x]
```

The first element is the pivot. The two comprehensions partition the rest.
