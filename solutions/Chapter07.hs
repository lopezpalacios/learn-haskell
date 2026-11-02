module Chapter07 where

data Shape = Circle Double | Rectangle Double Double
  deriving (Show, Eq)

area :: Shape -> Double
area (Circle r)      = pi * r ^ 2
area (Rectangle w h) = w * h

data Person = Person
  { name :: String
  , age  :: Int
  } deriving (Show, Eq)

showPerson :: Person -> String
showPerson p = name p ++ " (" ++ show (age p) ++ ")"

data Tree a = Leaf | Node (Tree a) a (Tree a)
  deriving (Show, Eq)

treeSum :: Tree Int -> Int
treeSum Leaf         = 0
treeSum (Node l x r) = treeSum l + x + treeSum r

safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv x y = Just (x `div` y)

class Describable a where
  describe :: a -> String

instance Describable Shape where
  describe (Circle r)      = "circle with radius " ++ show r
  describe (Rectangle w h) = "rectangle " ++ show w ++ " by " ++ show h

instance Describable Person where
  describe p = name p ++ " is " ++ show (age p) ++ " years old"
