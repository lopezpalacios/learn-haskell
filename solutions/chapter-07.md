# Chapter 7 — Solutions

## 1. Shape area

```haskell
data Shape = Circle Double | Rectangle Double Double
  deriving (Show, Eq)

area :: Shape -> Double
area (Circle r)      = pi * r ^ 2
area (Rectangle w h) = w * h
```

The pattern matches the constructor and binds its fields.

## 2. Person record

```haskell
data Person = Person
  { name :: String
  , age  :: Int
  } deriving (Show, Eq)

showPerson :: Person -> String
showPerson p = name p ++ " (" ++ show (age p) ++ ")"
```

The record accessors `name` and `age` are ordinary functions.

## 3. Tree sum

```haskell
data Tree a = Leaf | Node (Tree a) a (Tree a)
  deriving (Show, Eq)

treeSum :: Tree Int -> Int
treeSum Leaf         = 0
treeSum (Node l x r) = treeSum l + x + treeSum r
```

The recursion follows the two constructors: `Leaf` is the base case; `Node` combines the left subtree, the value, and the right subtree.

## 4. Safe division

```haskell
safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv x y = Just (x `div` y)
```

The first equation handles division by zero. The second handles every other divisor.

## 5. Describable

```haskell
class Describable a where
  describe :: a -> String

instance Describable Shape where
  describe (Circle r)      = "circle with radius " ++ show r
  describe (Rectangle w h) = "rectangle " ++ show w ++ " by " ++ show h

instance Describable Person where
  describe p = name p ++ " is " ++ show (age p) ++ " years old"
```

Each instance pattern matches on the constructors of its type.
