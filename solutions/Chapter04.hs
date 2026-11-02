module Chapter04 where

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)

sumList :: [Integer] -> Integer
sumList []     = 0
sumList (x:xs) = x + sumList xs

power :: Integer -> Integer -> Integer
power _ 0 = 1
power x n = x * power x (n - 1)

replicate' :: Int -> a -> [a]
replicate' n x
  | n <= 0    = []
  | otherwise = x : replicate' (n - 1) x

quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
  quicksort [y | y <- xs, y <= x]
  ++ [x]
  ++ quicksort [y | y <- xs, y > x]
