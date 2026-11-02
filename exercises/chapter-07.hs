module Chapter07 where

-- Exercise 1: Shape and area.
data Shape = Circle Double | Rectangle Double Double
  deriving (Show, Eq)

area :: Shape -> Double
area = undefined

-- Exercise 2: Person and showPerson.
data Person = Person
  { name :: String
  , age  :: Int
  } deriving (Show, Eq)

showPerson :: Person -> String
showPerson = undefined

-- Exercise 3: Tree and treeSum.
data Tree a = Leaf | Node (Tree a) a (Tree a)
  deriving (Show, Eq)

treeSum :: Tree Int -> Int
treeSum = undefined

-- Exercise 4: safeDiv.
safeDiv :: Int -> Int -> Maybe Int
safeDiv = undefined

-- Exercise 5: Describable.
class Describable a where
  describe :: a -> String

instance Describable Shape where
  describe = undefined

instance Describable Person where
  describe = undefined
