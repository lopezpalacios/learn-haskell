module Chapter01 where

triple :: Num a => a -> a
triple x = x * 3

absolute :: Int -> Int
absolute x = if x < 0 then -x else x

averagePair :: (Double, Double) -> Double
averagePair (x, y) = (x + y) / 2

oddSquares :: [Int] -> [Int]
oddSquares xs = [x * x | x <- xs, odd x]

swapPairs :: [(a, b)] -> [(b, a)]
swapPairs xs = [(y, x) | (x, y) <- xs]
