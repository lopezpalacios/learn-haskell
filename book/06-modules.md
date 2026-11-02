# Chapter 6 — Modules

## Learning objectives

By the end of this chapter you will be able to:

- Define a module and control what it exports.
- Import functions from the standard library.
- Use qualified imports to avoid name clashes.
- Use `Data.List`, `Data.Char`, and `Data.Map`.
- Build a small word-frequency program.

## Key terms

**Module**, **export list**, **import**, **qualified import**, **standard library**, **map** (the data structure).

## 6.1 Defining a module

A module groups related definitions and controls what other modules can see.

```haskell
module Geometry
  ( area
  , perimeter
  ) where

area :: Double -> Double
area r = pi * r ^ 2

perimeter :: Double -> Double
perimeter r = 2 * pi * r
```

The export list after the module name is optional. If you omit it, everything is exported. Exporting only the public API is better practice: it lets you change the internals without breaking users.

## 6.2 Importing

```haskell
import Data.List (sort, nub)
import Data.Char (toUpper)
```

An import can bring in specific names, or everything:

```haskell
import Data.List
```

A **qualified** import requires the module name as a prefix:

```haskell
import qualified Data.Map as Map
```

```haskell
ghci> Map.fromList [(1, "one"), (2, "two")]
fromList [(1,"one"),(2,"two")]
```

Qualified imports are useful when two modules export the same name.

## 6.3 Data.List

`Data.List` contains most list operations.

| Function | What it does |
|---|---|
| `sort` | Sorts a list. |
| `nub` | Removes duplicates. |
| `group` | Groups adjacent equal elements. |
| `sortBy` | Sorts with a custom comparison. |
| `partition` | Splits a list by a predicate. |
| `intersperse` | Puts a separator between elements. |

```haskell
ghci> import Data.List
ghci> sort [3,1,4,1,5,9,2,6]
[1,1,2,3,4,5,6,9]
ghci> nub [1,2,1,3,2,4]
[1,2,3,4]
ghci> group (sort "mississippi")
["iiii","m","pp","ssss"]
```

`group` only groups **adjacent** equal elements, so sort first if you want all equal elements together.

## 6.4 Data.Char

`Data.Char` contains character predicates and conversions.

| Function | What it does |
|---|---|
| `toUpper`, `toLower` | Change case. |
| `isDigit`, `isAlpha`, `isSpace` | Test a character. |
| `ord` | Character to code point. |
| `chr` | Code point to character. |
| `digitToInt` | Digit character to `Int`. |

```haskell
ghci> import Data.Char
ghci> toUpper 'a'
'A'
ghci> isDigit '7'
True
ghci> digitToInt '7'
7
```

## 6.5 Data.Map

`Data.Map` is a balanced tree of key-value pairs. It is useful when you need fast lookup by key.

```haskell
import qualified Data.Map as Map

phoneBook :: Map.Map String String
phoneBook = Map.fromList
  [ ("Alice", "555-0101")
  , ("Bob",   "555-0102")
  ]
```

```haskell
ghci> Map.lookup "Alice" phoneBook
Just "555-0101"
ghci> Map.lookup "Eve" phoneBook
Nothing
ghci> Map.insert "Eve" "555-0103" phoneBook
fromList [("Alice","555-0101"),("Bob","555-0102"),("Eve","555-0103")]
```

`Map.lookup` returns a `Maybe`, because the key may not exist.

## Worked example: word frequency

```haskell
import Data.List (nub)
import Data.Char (toLower, isAlpha)

wordFrequency :: String -> [(String, Int)]
wordFrequency text =
  [ (word, length (filter (== word) allWords))
  | word <- nub allWords
  , all isAlpha word
  ]
  where
    allWords = words (map toLower text)
```

This version is intentionally simple but inefficient: it scans the list once per distinct word. A better version uses `Data.Map`:

```haskell
import qualified Data.Map as Map
import Data.Char (toLower, isAlpha)

wordFrequency :: String -> Map.Map String Int
wordFrequency text =
  Map.fromListWith (+)
    [ (word, 1)
    | word <- words (map toLower text)
    , all isAlpha word
    ]
```

`fromListWith (+)` combines duplicate keys by adding their counts.

## Exercises

1. **Unique.** Define `unique :: Ord a => [a] -> [a]` using `nub`. `unique [1,2,1,3,2,4]` should be `[1,2,3,4]`.

2. **Descending sort.** Define `sortDesc :: Ord a => [a] -> [a]`. `sortDesc [3,1,4,1,5]` should be `[5,4,3,1,1]`.

3. **Character counts.** Define `countChars :: String -> [(Char, Int)]` using `sort` and `group`. `countChars "mississippi"` should contain `('i', 4)`, `('s', 4)`, `('p', 2)`, and `('m', 1)`.

4. **Digit sum.** Define `digitSum :: String -> Int` using `Data.Char.isDigit` and `digitToInt`. `digitSum "a1b2c3"` should be `6`.

5. **Phone book.** Define `phoneBook :: [(String, String)] -> Map.Map String String` using `Map.fromList`. `Map.lookup "Alice" (phoneBook [("Alice","555-0101")])` should be `Just "555-0101"`.

## Chapter summary

- A module groups definitions and controls its exports.
- Imports can be selective, unqualified, or qualified.
- `Data.List` provides `sort`, `nub`, `group`, `partition`, and more.
- `Data.Char` provides character predicates and conversions.
- `Data.Map` provides efficient key-value lookup.
- `Map.lookup` returns a `Maybe`; `fromListWith` combines duplicate keys.
