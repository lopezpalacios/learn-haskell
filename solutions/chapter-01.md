# Chapter 1 — Solutions

## 1. Triple

```haskell
triple :: Num a => a -> a
triple x = x * 3
```

`x + x + x` is equally correct. `x * 3` says the intent more directly.

## 2. Absolute value

```haskell
absolute :: Int -> Int
absolute x = if x < 0 then -x else x
```

The `else` is mandatory because `if` is an expression.

## 3. Average of a pair

```haskell
averagePair :: (Double, Double) -> Double
averagePair (x, y) = (x + y) / 2
```

The pattern `(x, y)` destructures the pair. The result is a `Double` because `/` is fractional division.

## 4. Squares of the odd numbers

```haskell
oddSquares :: [Int] -> [Int]
oddSquares xs = [x * x | x <- xs, odd x]
```

The generator takes each element; `odd x` filters; `x * x` is the output.

## 5. Swap pairs

```haskell
swapPairs :: [(a, b)] -> [(b, a)]
swapPairs xs = [(y, x) | (x, y) <- xs]
```

The generator destructures each pair; the output constructs the reversed pair.
