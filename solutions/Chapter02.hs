module Chapter02 where

same :: Eq a => a -> a -> Bool
same x y = x == y

maxOfThree :: Ord a => a -> a -> a -> a
maxOfThree x y z = max x (max y z)
