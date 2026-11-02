module Chapter06 where

import Data.List (nub, sort, group)
import Data.Char (isDigit, digitToInt)
import qualified Data.Map as Map

unique :: Ord a => [a] -> [a]
unique = nub

sortDesc :: Ord a => [a] -> [a]
sortDesc = reverse . sort

countChars :: String -> [(Char, Int)]
countChars = map (\g -> (head g, length g)) . group . sort

digitSum :: String -> Int
digitSum = sum . map digitToInt . filter isDigit

phoneBook :: [(String, String)] -> Map.Map String String
phoneBook = Map.fromList
