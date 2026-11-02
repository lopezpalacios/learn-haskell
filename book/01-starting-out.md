# Chapter 1 — Starting Out

## Learning objectives

By the end of this chapter you will be able to:

- Evaluate expressions in GHCi and explain the difference between an expression and a value.
- Define and apply functions with one or more parameters.
- Use `if` as an expression, including the mandatory `else`.
- Build and inspect lists with literals, `head`, `tail`, `length`, `:` and `++`.
- Generate lists with ranges and list comprehensions.
- Group values with tuples and convert between lists of pairs and pairs of lists.

## Key terms

**Expression**, **value**, **function**, **parameter**, **argument**, **list**, **range**, **comprehension**, **tuple**.

## 1.1 Expressions and values

GHCi is the interactive REPL that ships with GHC. You type an expression, GHCi evaluates it, and it prints the resulting value.

```haskell
ghci> 2 + 2
4
ghci> "hello"
"hello"
ghci> True
True
```

An **expression** is a piece of code that produces a value. `2 + 2`, `"hello"`, and `True` are expressions. `4`, `"hello"`, and `True` are values.

This distinction matters for the rest of the book. A type is a claim about values; an expression is the code that produces one. When you write a program, you are assembling expressions that produce the values you want.

## 1.2 Functions

A function is a mapping from an input to an output. In Haskell, you define one with a name, a parameter, an equals sign, and a body:

```haskell
double x = x + x
```

Read it as: “`double` of `x` is `x + x`.”

Apply the function by writing its name, a space, and the argument:

```haskell
ghci> double 5
10
ghci> double 5.5
11.0
```

Function application has the highest precedence. `double 5 + 1` means `(double 5) + 1`, not `double (5 + 1)`.

```haskell
ghci> double 5 + 1
11
ghci> double (5 + 1)
12
```

Functions can take more than one argument:

```haskell
add x y = x + y
```

```haskell
ghci> add 3 4
7
```

You will learn later why the type of `add` has two arrows. For now, read it as a function of two arguments.

## 1.3 If expressions

`if` is an expression, not a statement. It produces a value:

```haskell
absolute x = if x < 0 then -x else x
```

```haskell
ghci> absolute (-5)
5
ghci> absolute 5
5
```

The `else` branch is mandatory. Every expression must produce a value, so there is no “do nothing” branch. If you omit `else`, the program does not parse.

## 1.4 Lists

A list is a homogeneous sequence: every element has the same type.

```haskell
numbers = [4, 8, 15, 16, 23, 42]
```

```haskell
ghci> head numbers
4
ghci> tail numbers
[8,15,16,23,42]
ghci> length numbers
6
```

`head` returns the first element. `tail` returns everything except the first. `length` returns the number of elements.

You can add an element to the front with `:`:

```haskell
ghci> 1 : numbers
[1,4,8,15,16,23,42]
```

And you can join two lists with `++`:

```haskell
ghci> numbers ++ [7]
[4,8,15,16,23,42,7]
```

`:` is cheap: it creates one new cell at the front. `++` walks the entire left list, so it is more expensive for long lists.

`[1,2,3]` is syntactic sugar for `1 : 2 : 3 : []`.

## 1.5 Ranges

A range builds an arithmetic sequence:

```haskell
ghci> [1..10]
[1,2,3,4,5,6,7,8,9,10]
ghci> [2,4..10]
[2,4,6,8,10]
ghci> [10,9..1]
[10,9,8,7,6,5,4,3,2,1]
```

The first two elements determine the step. `[2,4..10]` has step `2`; `[10,9..1]` has step `-1`.

If you omit the upper bound, the list is infinite:

```haskell
ghci> take 5 [1..]
[1,2,3,4,5]
```

Haskell is lazy, so it does not try to build the whole infinite list. It produces elements only as they are needed.

## 1.6 List comprehensions

A list comprehension builds a list from one or more generators and an output expression:

```haskell
ghci> [x * 2 | x <- [1..5]]
[2,4,6,8,10]
```

Read it as: “the list of `x * 2` for each `x` drawn from `[1..5]`.”

Add a predicate with a comma:

```haskell
ghci> [x * 2 | x <- [1..10], x * 2 >= 12]
[12,14,16,18,20]
```

Use several generators to produce combinations:

```haskell
ghci> [(x, y) | x <- [1,2], y <- [3,4]]
[(1,3),(1,4),(2,3),(2,4)]
```

A generator can also destructure a pair:

```haskell
ghci> [x + y | (x, y) <- [(1,2),(3,4),(5,6)]]
[3,7,11]
```

## 1.7 Tuples

A tuple groups a fixed number of values. Unlike a list, a tuple can mix types:

```haskell
ghci> (1, "one")
(1,"one")
ghci> fst (1, "one")
1
ghci> snd (1, "one")
"one"
```

`fst` and `snd` work only on pairs.

`zip` combines two lists into a list of pairs:

```haskell
ghci> zip [1,2,3] ["one","two","three"]
[(1,"one"),(2,"two"),(3,"three")]
```

`unzip` is the inverse:

```haskell
ghci> unzip [(1,"one"),(2,"two")]
([1,2],["one","two"])
```

A list of pairs and a pair of lists contain the same information in different shapes.

## Worked example: even squares

```haskell
evenSquares xs = [x * x | x <- xs, even x]
```

```haskell
ghci> evenSquares [1..10]
[4,16,36,64,100]
```

The generator takes each element of `xs`; the predicate keeps the even ones; the output expression squares them.

## Exercises

Write each function, load it in GHCi, and test it with the examples.

1. **Triple.** Define `triple` so that `triple 7` is `21` and `triple 2.5` is `7.5`.

2. **Absolute value.** Define `absolute` using `if`. `absolute (-5)` should be `5`; `absolute 5` should be `5`.

3. **Average of a pair.** Define `averagePair` for a pair of `Double`s. `averagePair (2, 4)` should be `3.0`.

4. **Squares of the odd numbers.** Define `oddSquares` using a list comprehension. `oddSquares [1..6]` should be `[1,9,25]`.

5. **Swap pairs.** Define `swapPairs` so that `swapPairs [(1,"a"),(2,"b")]` is `[("a",1),("b",2)]`.

## Chapter summary

- GHCi evaluates expressions and prints values.
- Functions are defined with a name, parameters, `=`, and a body.
- Function application binds tighter than arithmetic operators.
- `if` is an expression; `else` is mandatory.
- Lists are homogeneous; `:` prepends and `++` concatenates.
- Ranges build arithmetic sequences; an omitted upper bound makes them infinite.
- List comprehensions combine generators, predicates, and an output expression.
- Tuples group fixed-size values and can mix types.
- `zip` and `unzip` convert between lists of pairs and pairs of lists.
