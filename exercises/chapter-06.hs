module Chapter06 where

import Data.List (nub, sort, group)
import Data.Char (isDigit, digitToInt)
import qualified Data.Map as Map

-- Exercise 1: unique with nub.
unique :: Ord a => [a] -> [a]
unique = undefined

-- Exercise 2: descending sort.
sortDesc :: Ord a => [a] -> [a]
sortDesc = undefined

-- Exercise 3: character counts with sort and group.
countChars :: String -> [(Char, Int)]
countChars = undefined

-- Exercise 4: sum of the digits in a string.
digitSum :: String -> Int
digitSum = undefined

-- Exercise 5: build a Map from a list of pairs.
phoneBook :: [(String, String)] -> Map.Map String String
phoneBook = undefined
