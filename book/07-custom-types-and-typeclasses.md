# Chapter 7 — Custom Types and Typeclasses

## Learning objectives

By the end of this chapter you will be able to:

- Define your own data types with `data`.
- Use constructors, records, and `deriving`.
- Write functions by pattern matching on your types.
- Use `Maybe` and `Either` to model failure.
- Define your own type class and write instances.
- Understand the difference between `data` and `newtype`.

## Key terms

**Data type**, **constructor**, **field**, **record**, **deriving**, **type parameter**, **`Maybe`**, **`Either`**, **type class**, **instance**.

## 7.1 Defining a data type

A data type defines a set of values. Each value is built with one of the type's constructors.

```haskell
data Shape
  = Circle Double
  | Rectangle Double Double
  deriving (Show, Eq)
```

`Shape` has two constructors:

- `Circle` carries one `Double` (the radius).
- `Rectangle` carries two `Double`s (width and height).

The `|` is “or.” A `Shape` is either a `Circle` or a `Rectangle`.

```haskell
ghci> Circle 2.0
Circle 2.0
ghci> Rectangle 3.0 4.0
Rectangle 3.0 4.0
```

## 7.2 Functions on data types

Pattern matching gives you access to the constructor's fields:

```haskell
area :: Shape -> Double
area (Circle r)      = pi * r ^ 2
area (Rectangle w h) = w * h
```

```haskell
ghci> area (Circle 2.0)
12.566370614359172
ghci> area (Rectangle 3.0 4.0)
12.0
```

The compiler checks that you handle every constructor. If you forget `Rectangle`, it warns or rejects the function.

## 7.3 Records

A record gives names to the fields:

```haskell
data Person = Person
  { name :: String
  , age  :: Int
  } deriving (Show, Eq)
```

```haskell
ghci> let alice = Person "Alice" 30
ghci> name alice
"Alice"
ghci> age alice
30
```

Records are ordinary data types with named accessors. They are useful when a constructor has many fields and positional patterns become unreadable.

## 7.4 Deriving

`deriving` asks GHC to generate common instances:

```haskell
data Color = Red | Green | Blue
  deriving (Show, Eq, Ord, Enum)
```

- `Show` lets you print the value.
- `Eq` lets you compare with `==`.
- `Ord` gives a total ordering based on constructor order.
- `Enum` lets you use ranges and `succ`/`pred`.

## 7.5 Type parameters

A type can be parameterized by another type:

```haskell
data Box a = Box a
```

```haskell
ghci> Box 3
Box 3
ghci> Box "hello"
Box "hello"
```

`Box` is a type constructor; `Box Int` and `Box String` are concrete types.

## 7.6 Maybe and Either

`Maybe` models a value that may be missing:

```haskell
data Maybe a = Nothing | Just a
```

```haskell
safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv x y = Just (x `div` y)
```

```haskell
ghci> safeDiv 10 2
Just 5
ghci> safeDiv 10 0
Nothing
```

`Either` models a value that is either an error or a success:

```haskell
data Either e a = Left e | Right a
```

```haskell
parsePositive :: Int -> Either String Int
parsePositive n
  | n > 0     = Right n
  | otherwise = Left "not positive"
```

Use `Maybe` when there is only one kind of failure. Use `Either` when the failure carries information.

## 7.7 Defining a type class

A type class is a set of operations that several types can implement.

```haskell
class Describable a where
  describe :: a -> String
```

```haskell
instance Describable Shape where
  describe (Circle r)      = "circle with radius " ++ show r
  describe (Rectangle w h) = "rectangle " ++ show w ++ " by " ++ show h

instance Describable Person where
  describe p = name p ++ " is " ++ show (age p) ++ " years old"
```

```haskell
ghci> describe (Circle 2.0)
"circle with radius 2.0"
ghci> describe (Person "Alice" 30)
"Alice is 30 years old"
```

A class declaration is a contract. An instance is a promise that a type satisfies the contract.

## 7.8 Data vs newtype

`newtype` defines a type with exactly one constructor and exactly one field. It has no runtime overhead:

```haskell
newtype UserId = UserId Int
```

Use `newtype` when you want a distinct type for safety, not a new data structure. `UserId` is not interchangeable with `Int`, even though it wraps one.

## Worked example: a binary tree

```haskell
data Tree a
  = Leaf
  | Node (Tree a) a (Tree a)
  deriving (Show, Eq)

treeSum :: Tree Int -> Int
treeSum Leaf         = 0
treeSum (Node l x r) = treeSum l + x + treeSum r
```

```haskell
ghci> treeSum (Node (Node Leaf 1 Leaf) 2 (Node Leaf 3 Leaf))
6
```

## Exercises

1. **Shape area.** Define `Shape` with `Circle` and `Rectangle`, derive `Show` and `Eq`, and write `area :: Shape -> Double`.

2. **Person record.** Define `Person` with `name` and `age`, derive `Show`, and write `showPerson :: Person -> String` that returns `"Alice (30)"`.

3. **Tree sum.** Define `Tree a` with `Leaf` and `Node`, and write `treeSum :: Tree Int -> Int`.

4. **Safe division.** Define `safeDiv :: Int -> Int -> Maybe Int`. `safeDiv 10 2` should be `Just 5`; `safeDiv 10 0` should be `Nothing`.

5. **Describable.** Define a `Describable` type class with `describe :: a -> String`, and write instances for `Shape` and `Person`.

## Chapter summary

- `data` defines a type with one or more constructors.
- Pattern matching gives access to constructor fields.
- Records name the fields; `deriving` generates common instances.
- Type parameters make a type generic.
- `Maybe` models optional values; `Either` models errors with information.
- A type class is a contract; an instance is an implementation.
- `newtype` creates a distinct type with no runtime overhead.
