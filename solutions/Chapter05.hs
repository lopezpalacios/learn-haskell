module Chapter05 where

doubleAll :: [Int] -> [Int]
doubleAll = map (*2)

keepEven :: [Int] -> [Int]
keepEven = filter even

sumList :: [Int] -> Int
sumList = foldr (+) 0

compose3 :: (c -> d) -> (b -> c) -> (a -> b) -> a -> d
compose3 f g h = f . g . h

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)
