# Chapter 3 — Solutions

## 1. Day name

```haskell
dayName :: Int -> String
dayName 1 = "Monday"
dayName 2 = "Tuesday"
dayName 3 = "Wednesday"
dayName 4 = "Thursday"
dayName 5 = "Friday"
dayName 6 = "Saturday"
dayName 7 = "Sunday"
dayName _ = "invalid"
```

The wildcard catches every number outside `1..7`.

## 2. Grade

```haskell
grade :: Int -> String
grade score
  | score >= 90 = "A"
  | score >= 80 = "B"
  | score >= 70 = "C"
  | score >= 60 = "D"
  | otherwise   = "F"
```

The guards are checked from top to bottom, so `95` matches the first one and never reaches the others.

## 3. Triangle area

```haskell
triangleArea :: Double -> Double -> Double -> Double
triangleArea a b c =
  sqrt (s * (s - a) * (s - b) * (s - c))
  where
    s = (a + b + c) / 2
```

`where` keeps the semiperimeter out of the main expression.

## 4. Cylinder volume

```haskell
cylinderVolume :: Double -> Double -> Double
cylinderVolume r h =
  let base = pi * r ^ 2
  in  base * h
```

`let ... in ...` is an expression. `base` is visible only inside the `in` part.

## 5. Describe a pair

```haskell
describePair :: (Int, Int) -> String
describePair p = case p of
  (0, 0) -> "origin"
  (_, 0) -> "x-axis"
  (0, _) -> "y-axis"
  _      -> "elsewhere"
```

The order matters: `(0,0)` must come before the axis cases, or it would match `(_,0)` first.
