# Chapter 5 — Higher-Order Functions

## Learning objectives

By the end of this chapter you will be able to:

- Treat functions as values and pass them to other functions.
- Use currying and partial application to build specialized functions.
- Use `map`, `filter`, `foldl`, and `foldr`.
- Compose functions with `.` and apply them with `$`.
- Recognize when a fold is clearer than explicit recursion.

## Key terms

**Higher-order function**, **currying**, **partial application**, **fold**, **accumulator**, **composition**, **point-free style**.

## 5.1 Functions as values

In Haskell, functions are values. You can name them, return them, and pass them as arguments.

```haskell
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)
```

```haskell
ghci> applyTwice (+3) 10
16
ghci> applyTwice (++ " HAHA") "HEY"
"HEY HAHA HAHA"
```

`applyTwice` takes a function and a value. The function is not special syntax; it is an ordinary argument.

## 5.2 Currying and partial application

A function of two arguments is a function of one argument that returns a function.

```haskell
add :: Num a => a -> a -> a
add x y = x + y
```

```haskell
ghci> add 3 4
7
ghci> let addThree = add 3
ghci> addThree 4
7
```

Partial application lets you build specialized functions from general ones. This is one of the main reasons Haskell code is compact.

## 5.3 Map

`map` applies a function to every element of a list.

```haskell
map :: (a -> b) -> [a] -> [b]
map _ []     = []
map f (x:xs) = f x : map f xs
```

```haskell
ghci> map (*2) [1,2,3,4]
[2,4,6,8]
ghci> map (replicate 2) ['a','b']
["aa","bb"]
```

## 5.4 Filter

`filter` keeps the elements that satisfy a predicate.

```haskell
filter :: (a -> Bool) -> [a] -> [a]
filter _ []     = []
filter p (x:xs)
  | p x       = x : filter p xs
  | otherwise = filter p xs
```

```haskell
ghci> filter even [1..10]
[2,4,6,8,10]
ghci> filter (> 5) [1..10]
[6,7,8,9,10]
```

## 5.5 Folds

A fold combines a list into a single value.

`foldr` processes the list from the right:

```haskell
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _ z []     = z
foldr f z (x:xs) = f x (foldr f z xs)
```

```haskell
ghci> foldr (+) 0 [1,2,3,4]
10
ghci> foldr (:) [] [1,2,3]
[1,2,3]
```

`foldl` processes the list from the left:

```haskell
foldl :: (b -> a -> b) -> b -> [a] -> b
foldl _ z []     = z
foldl f z (x:xs) = foldl f (f z x) xs
```

```haskell
ghci> foldl (+) 0 [1,2,3,4]
10
```

For large lists, use `foldl'` from `Data.List`. It forces the accumulator at each step and avoids building a chain of thunks.

## 5.6 Composition and application

Function composition combines two functions:

```haskell
(.) :: (b -> c) -> (a -> b) -> a -> c
(f . g) x = f (g x)
```

```haskell
ghci> map (negate . abs) [5, -3, -6]
[-5,-3,-6]
```

`$` applies a function to an argument. It is useful for avoiding parentheses:

```haskell
($) :: (a -> b) -> a -> b
f $ x = f x
```

```haskell
ghci> sum (map (*2) [1..10])
110
ghci> sum $ map (*2) [1..10]
110
```

## Worked example: sum of the squares of the odd numbers

```haskell
sumSquaresOfOdds :: [Int] -> Int
sumSquaresOfOdds xs =
  sum (map (^2) (filter odd xs))
```

```haskell
ghci> sumSquaresOfOdds [1..10]
165
```

The same function with composition:

```haskell
sumSquaresOfOdds' :: [Int] -> Int
sumSquaresOfOdds' = sum . map (^2) . filter odd
```

This is **point-free style**: the argument is implicit. Use it when it makes the data flow clearer, not as a contest.

## Exercises

1. **Double all.** Define `doubleAll :: [Int] -> [Int]` using `map`. `doubleAll [1,2,3]` should be `[2,4,6]`.

2. **Keep the even numbers.** Define `keepEven :: [Int] -> [Int]` using `filter`. `keepEven [1..10]` should be `[2,4,6,8,10]`.

3. **Sum with a fold.** Define `sumList :: [Int] -> Int` using `foldr`. `sumList [1,2,3,4]` should be `10`.

4. **Compose three functions.** Define `compose3 :: (c -> d) -> (b -> c) -> (a -> b) -> a -> d` using `.`. `compose3 (+1) (*2) negate 3` should be `-5`.

5. **Apply twice.** Define `applyTwice :: (a -> a) -> a -> a`. `applyTwice (+3) 10` should be `16`.

## Chapter summary

- Functions are values and can be passed as arguments.
- Currying turns multi-argument functions into chains of one-argument functions.
- `map` transforms every element; `filter` keeps elements that satisfy a predicate.
- `foldr` and `foldl` combine a list into one value.
- `.` composes functions; `$` applies them without parentheses.
- Point-free style is useful when it clarifies the data flow.
