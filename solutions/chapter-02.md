# Chapter 2 — Solutions

## 1. Signatures

```haskell
triple :: Num a => a -> a
triple x = x * 3

absolute :: Int -> Int
absolute x = if x < 0 then -x else x

averagePair :: (Double, Double) -> Double
averagePair (x, y) = (x + y) / 2

swapPairs :: [(a, b)] -> [(b, a)]
swapPairs xs = [(y, x) | (x, y) <- xs]
```

`triple` and `absolute` are concrete because the exercises use `Int`. `averagePair` is concrete because it uses `Double`. `swapPairs` is polymorphic in both components.

## 2. Predicted types

```haskell
5          :: Num a => a
"hello"    :: [Char]        -- String
(1, 'a')   :: Num a => (a, Char)
[1,2,3]    :: Num a => [a]
```

The numeric literals are polymorphic until something forces a concrete type. GHCi defaults them when it needs to print a result.

## 3. Errors

```haskell
5 + "hello"
```

`No instance for (Num String)`. `+` needs a numeric type, and `String` is not numeric. If you meant concatenation, use `show 5 ++ "hello"`.

```haskell
True == 5
```

`No instance for (Num Bool)`. `==` requires both sides to have the same type. `True` is a `Bool`, so `5` would have to be a `Bool`, and `Bool` is not numeric.

```haskell
if 1 then 2 else 3
```

`No instance for (Num Bool)`. The condition of `if` must be a `Bool`. Use `if True then 2 else 3` or `if 1 == 1 then 2 else 3`.

## 4. Same

```haskell
same :: Eq a => a -> a -> Bool
same x y = x == y
```

The `Eq a` constraint is what gives you `==`.

## 5. Maximum of three

```haskell
maxOfThree :: Ord a => a -> a -> a -> a
maxOfThree x y z = max x (max y z)
```

`max` needs `Ord`; nesting it handles three arguments.
