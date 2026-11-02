# Chapter 4 — Recursion

## Learning objectives

By the end of this chapter you will be able to:

- Identify the base case and the recursive case of a recursive function.
- Write recursive functions over lists.
- Use helper functions and accumulators to improve performance.
- Implement `maximum`, `replicate`, `take`, `reverse`, `zip`, and quicksort recursively.

## Key terms

**Base case**, **recursive case**, **accumulator**, **termination**, **structural recursion**.

## 4.1 The shape of recursion

A recursive function calls itself. Every recursive definition needs two parts:

1. A **base case** that stops the recursion.
2. A **recursive case** that moves toward the base case.

```haskell
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)
```

`factorial 0` is the base case. For any other `n`, the function multiplies `n` by `factorial (n - 1)`, which is closer to `0`.

If the recursive case does not move toward the base case, the function never terminates.

## 4.2 Recursion on lists

A list is either empty (`[]`) or a head followed by a tail (`x : xs`). That shape gives a natural recursion:

```haskell
sumList :: [Integer] -> Integer
sumList []     = 0
sumList (x:xs) = x + sumList xs
```

```haskell
ghci> sumList [1,2,3,4]
10
```

The same pattern works for many list functions.

```haskell
maximum' :: Ord a => [a] -> a
maximum' []     = error "maximum of an empty list"
maximum' [x]    = x
maximum' (x:xs) = max x (maximum' xs)
```

```haskell
replicate' :: Int -> a -> [a]
replicate' n x
  | n <= 0    = []
  | otherwise = x : replicate' (n - 1) x
```

```haskell
take' :: Int -> [a] -> [a]
take' n _      | n <= 0 = []
take' _ []              = []
take' n (x:xs)          = x : take' (n - 1) xs
```

```haskell
reverse' :: [a] -> [a]
reverse' []     = []
reverse' (x:xs) = reverse' xs ++ [x]
```

`reverse'` is correct but slow: `++` walks the left list at every step, so the total cost is quadratic. An accumulator version is linear:

```haskell
reverse'' :: [a] -> [a]
reverse'' xs = go xs []
  where
    go []     acc = acc
    go (y:ys) acc = go ys (y:acc)
```

The accumulator stores the reversed prefix, so no `++` is needed.

## 4.3 Zip and quicksort

```haskell
zip' :: [a] -> [b] -> [(a, b)]
zip' []     _      = []
zip' _      []     = []
zip' (x:xs) (y:ys) = (x, y) : zip' xs ys
```

Quicksort is a compact example of recursive decomposition:

```haskell
quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
  quicksort [y | y <- xs, y <= x]
  ++ [x]
  ++ quicksort [y | y <- xs, y > x]
```

Choose the first element as the pivot. Partition the rest into smaller-or-equal and larger. Sort each part recursively, then concatenate.

## Worked example: tracing `sumList`

```haskell
sumList [1,2,3]
= 1 + sumList [2,3]
= 1 + (2 + sumList [3])
= 1 + (2 + (3 + sumList []))
= 1 + (2 + (3 + 0))
= 6
```

Each step removes one element. The base case stops when the list is empty.

## Exercises

1. **Factorial.** Define `factorial :: Integer -> Integer`. `factorial 5` should be `120`.

2. **Sum.** Define `sumList :: [Integer] -> Integer` without using the built-in `sum`. `sumList [1,2,3,4]` should be `10`.

3. **Power.** Define `power :: Integer -> Integer -> Integer` so that `power x n` is `x` raised to `n`. Assume `n >= 0`. `power 2 10` should be `1024`.

4. **Replicate.** Define `replicate' :: Int -> a -> [a]` without using the built-in `replicate`. `replicate' 3 'x'` should be `"xxx"`.

5. **Quicksort.** Define `quicksort :: Ord a => [a] -> [a]`. `quicksort [3,1,4,1,5,9,2,6]` should be `[1,1,2,3,4,5,6,9]`.

## Chapter summary

- Every recursive function needs a base case and a recursive case.
- Lists have two shapes: `[]` and `x : xs`.
- Structural recursion follows the shape of the data.
- Accumulators can turn quadratic functions into linear ones.
- Quicksort is a recursive partition-and-conquer algorithm.
