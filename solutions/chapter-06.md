# Chapter 6 — Solutions

## 1. Unique

```haskell
unique :: Ord a => [a] -> [a]
unique = nub
```

`nub` removes duplicates but keeps the first occurrence. It only needs `Eq`, but the exercise signature uses `Ord`, which is stronger and fine.

## 2. Descending sort

```haskell
sortDesc :: Ord a => [a] -> [a]
sortDesc = reverse . sort
```

Alternatively, `sortBy (flip compare)` avoids the extra pass.

## 3. Character counts

```haskell
countChars :: String -> [(Char, Int)]
countChars = map (\g -> (head g, length g)) . group . sort
```

`sort` puts equal characters together; `group` creates the runs; the lambda turns each run into a pair.

## 4. Digit sum

```haskell
digitSum :: String -> Int
digitSum = sum . map digitToInt . filter isDigit
```

`filter isDigit` keeps only digit characters; `digitToInt` converts each one; `sum` adds them.

## 5. Phone book

```haskell
phoneBook :: [(String, String)] -> Map.Map String String
phoneBook = Map.fromList
```

`Map.fromList` builds a map from a list of key-value pairs. If a key repeats, the last value wins.
