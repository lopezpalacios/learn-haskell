# Chapter 2 — Types and Typeclasses

## Learning objectives

By the end of this chapter you will be able to:

- Ask GHCi for the type of an expression with `:t`.
- Write type signatures for your own functions.
- Read and use type variables.
- Explain currying and partial application.
- Use the type classes `Num`, `Eq`, `Ord`, `Show`, and `Read`.
- Read a type error and say what it means in plain English.

## Key terms

**Type**, **type signature**, **type variable**, **polymorphism**, **currying**, **partial application**, **type class**, **instance**, **constraint**.

## 2.1 What a type is

A type is a claim about a value: what kind of thing it is and which operations make sense on it.

```haskell
ghci> :t 4
4 :: Num a => a
ghci> :t "hello"
"hello" :: [Char]
ghci> :t True
True :: Bool
```

`::` is read “has type.” `4` has a numeric type; `"hello"` is a list of characters; `True` is a boolean.

## 2.2 Asking GHCi

`:t` shows the type of an expression. `:info` shows the definition of a name and its instances.

```haskell
ghci> :t (+)
(+) :: Num a => a -> a -> a
ghci> :t (==)
(==) :: Eq a => a -> a -> Bool
ghci> :t compare
compare :: Ord a => a -> a -> Ordering
```

The part before `=>` is a **constraint**. `Num a =>` means “for any type `a` that is an instance of `Num`.”

## 2.3 Type signatures

A type signature documents a function’s contract:

```haskell
double :: Num a => a -> a
double x = x + x
```

Read it as: “for any numeric type `a`, `double` takes an `a` and returns an `a`.”

A signature is not required, but it is good practice. It catches mistakes early and makes the code easier to read.

```haskell
add :: Num a => a -> a -> a
add x y = x + y
```

## 2.4 Type variables and polymorphism

A lowercase name in a type is a **type variable**. It stands for any type that satisfies the constraints.

```haskell
id :: a -> a
id x = x
```

`a` is not a value; it is a type. The signature says: “for any type `a`, give me an `a` and I will return an `a`.”

```haskell
fst :: (a, b) -> a
fst (x, _) = x
```

`fst` works for any pair, regardless of the types of its components. That is **parametric polymorphism**.

## 2.5 Currying

Every function in Haskell takes one argument. A function that looks like it takes two is a function that returns a function.

```haskell
add :: Num a => a -> a -> a
```

is parsed as:

```haskell
add :: Num a => a -> (a -> a)
```

The arrow groups to the right. Application groups to the left:

```haskell
add 3 4 = (add 3) 4
```

`add 3` is a function waiting for the second argument. `add 3 4` is the result. This is **currying**, and it enables **partial application**:

```haskell
addThree = add 3
addThree 4 -- 7
```

## 2.6 Type classes

A type class is a set of operations that several types can implement.

| Class | Operations | Examples |
|---|---|---|
| `Num` | `+`, `-`, `*`, literals | `Int`, `Integer`, `Double` |
| `Eq` | `==`, `/=` | most types |
| `Ord` | `<`, `>`, `compare` | types with an ordering |
| `Show` | `show` | types that can be printed |
| `Read` | `read` | types that can be parsed from text |

```haskell
ghci> show 42
"42"
ghci> read "42" :: Int
42
ghci> 3 < 5
True
```

A constraint can combine several classes:

```haskell
both :: (Eq a, Show a) => a -> a -> String
both x y = if x == y then show x else "different"
```

## 2.7 Reading type errors

Type errors are the compiler telling you that your claim and your code disagree.

```haskell
ghci> 5 + "hello"
```

```
No instance for (Num String) arising from a use of ‘+’
```

Plain English: `+` needs a number, and `String` is not a number.

```haskell
ghci> True == 5
```

```
No instance for (Num Bool) arising from the literal ‘5’
```

Plain English: `==` requires both sides to have the same type. `True` is a `Bool`, so `5` would have to be a `Bool`, and booleans are not numbers.

```haskell
ghci> if 1 then 2 else 3
```

```
No instance for (Num Bool) arising from the literal ‘1’
```

Plain English: the condition of `if` must be a `Bool`. `1` is a number.

## Worked example: signatures for a small module

```haskell
double :: Num a => a -> a
double x = x + x

averagePair :: (Double, Double) -> Double
averagePair (x, y) = (x + y) / 2

swapPairs :: [(a, b)] -> [(b, a)]
swapPairs xs = [(y, x) | (x, y) <- xs]
```

Each signature says what the function promises. `double` works for any numeric type. `averagePair` is specifically about `Double`. `swapPairs` works for any pair types.

## Exercises

1. **Write signatures.** Add type signatures to `triple`, `absolute`, `averagePair`, and `swapPairs` from Chapter 1.

2. **Predict the types.** Before running `:t`, write down the type of each expression:
   ```haskell
   5
   "hello"
   (1, 'a')
   [1,2,3]
   ```

3. **Fix the errors.** For each expression, explain the error and give a corrected version:
   ```haskell
   5 + "hello"
   True == 5
   if 1 then 2 else 3
   ```

4. **Same.** Define `same :: Eq a => a -> a -> Bool` that returns `True` when both arguments are equal.

5. **Maximum of three.** Define `maxOfThree :: Ord a => a -> a -> a -> a` that returns the largest of three values.

## Chapter summary

- A type is a claim about values; a type signature is a claim about a function.
- `:t` shows types; `:info` shows definitions and instances.
- Type variables make functions polymorphic.
- `a -> b -> c` means `a -> (b -> c)`; application groups to the left.
- Currying enables partial application.
- Type classes constrain type variables: `Num`, `Eq`, `Ord`, `Show`, `Read`.
- Type errors are disagreements between a signature and an expression.
