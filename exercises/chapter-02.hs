module Chapter02 where

-- Exercise 1: add the signatures to these four functions.
triple :: Num a => a -> a
triple x = x * 3

absolute :: Int -> Int
absolute x = if x < 0 then -x else x

averagePair :: (Double, Double) -> Double
averagePair (x, y) = (x + y) / 2

swapPairs :: [(a, b)] -> [(b, a)]
swapPairs xs = [(y, x) | (x, y) <- xs]

-- Exercise 2: predict the types before using :t.
-- 5
-- "hello"
-- (1, 'a')
-- [1,2,3]

-- Exercise 3: explain and fix each error.
-- 5 + "hello"
-- True == 5
-- if 1 then 2 else 3

-- Exercise 4: same.
same :: Eq a => a -> a -> Bool
same = undefined

-- Exercise 5: maxOfThree.
maxOfThree :: Ord a => a -> a -> a -> a
maxOfThree = undefined
