# Chapter 3 — Syntax in Functions

## Learning objectives

By the end of this chapter you will be able to:

- Define functions by pattern matching on their arguments.
- Use guards to express conditional branches.
- Share local definitions with `where`.
- Use `let ... in ...` inside an expression.
- Use `case` to scrutinize a value.
- Use wildcards and as-patterns to keep code readable.

## Key terms

**Pattern**, **pattern matching**, **guard**, **where clause**, **let expression**, **case expression**, **wildcard**, **as-pattern**.

## 3.1 Pattern matching

A pattern describes the shape of a value. When a function argument matches the pattern, the names in the pattern are bound to the corresponding parts.

```haskell
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)
```

The first equation matches only `0`. The second matches any other `n`. Patterns are tried from top to bottom.

Patterns work on tuples and lists too:

```haskell
first :: (a, b) -> a
first (x, _) = x
```

```haskell
describe :: [a] -> String
describe []    = "empty"
describe [_]   = "one element"
describe _     = "many elements"
```

`[]` matches the empty list. `[_]` matches a list with exactly one element; the `_` is a wildcard for the element. `_` alone matches anything.

## 3.2 Guards

Guards are boolean expressions attached to equations. They are useful when the decision depends on a condition rather than the shape of the value.

```haskell
bmiTell :: Double -> String
bmiTell bmi
  | bmi <= 18.5 = "underweight"
  | bmi <= 25.0 = "normal"
  | bmi <= 30.0 = "overweight"
  | otherwise   = "obese"
```

Guards are tried from top to bottom. `otherwise` is simply `True`, so it acts as the fallback.

## 3.3 Where

`where` introduces local names that are visible to all guards of the equation.

```haskell
bmiTell :: Double -> Double -> String
bmiTell weight height
  | bmi <= 18.5 = "underweight"
  | bmi <= 25.0 = "normal"
  | bmi <= 30.0 = "overweight"
  | otherwise   = "obese"
  where bmi = weight / height ^ 2
```

The `where` clause is not an expression; it is a local declaration attached to the function equation.

## 3.4 Let

`let ... in ...` is an expression. It introduces local bindings and then evaluates a body.

```haskell
cylinder :: Double -> Double -> Double
cylinder r h =
  let sideArea = 2 * pi * r * h
      topArea  = pi * r ^ 2
  in  sideArea + 2 * topArea
```

The names `sideArea` and `topArea` are visible only inside the `in` expression.

## 3.5 Case

A `case` expression scrutinizes a value and chooses a branch by pattern.

```haskell
describeList :: [a] -> String
describeList xs = case xs of
  []  -> "empty"
  [_] -> "one element"
  _   -> "many elements"
```

`case` is an expression, so it produces a value. All branches must produce the same type.

## 3.6 Wildcards and as-patterns

A wildcard `_` matches anything and binds nothing:

```haskell
second :: (a, b) -> b
second (_, y) = y
```

An as-pattern binds a name to the whole value while also destructuring it:

```haskell
firstAndLast :: [a] -> (a, a)
firstAndLast xs@(x:_) = (x, last xs)
firstAndLast []       = error "empty list"
```

`xs@(x:_)` means: bind the whole list to `xs`, and also bind its head to `x`.

## Worked example: classify a triangle

```haskell
classifyTriangle :: Int -> Int -> Int -> String
classifyTriangle a b c
  | a + b <= c || a + c <= b || b + c <= a = "not a triangle"
  | a == b && b == c                       = "equilateral"
  | a == b || b == c || a == c             = "isosceles"
  | otherwise                              = "scalene"
```

The first guard rejects impossible side lengths. The remaining guards classify the triangle. Using `Int` avoids the floating-point equality problem; with `Double` you would need a tolerance.

## Exercises

1. **Day name.** Define `dayName :: Int -> String` using pattern matching. `1` is `"Monday"`, …, `7` is `"Sunday"`, and any other number is `"invalid"`.

2. **Grade.** Define `grade :: Int -> String` using guards. `90` or more is `"A"`, `80` or more is `"B"`, `70` or more is `"C"`, `60` or more is `"D"`, and anything else is `"F"`.

3. **Triangle area.** Define `triangleArea :: Double -> Double -> Double -> Double` using Heron's formula and a `where` clause. For sides `a`, `b`, `c`, let `s = (a + b + c) / 2`; the area is `sqrt (s * (s - a) * (s - b) * (s - c))`.

4. **Cylinder volume.** Define `cylinderVolume :: Double -> Double -> Double` using `let`. The volume is `pi * r^2 * h`.

5. **Describe a pair.** Define `describePair :: (Int, Int) -> String` using `case`. `(0, 0)` is `"origin"`, `(x, 0)` is `"x-axis"`, `(0, y)` is `"y-axis"`, and anything else is `"elsewhere"`.

## Chapter summary

- Patterns match the shape of a value and bind its parts.
- Equations are tried from top to bottom.
- Guards express conditional branches with boolean expressions.
- `where` attaches local declarations to an equation.
- `let ... in ...` is an expression with local bindings.
- `case` chooses a branch by pattern and produces a value.
- Wildcards ignore parts; as-patterns keep the whole value.
