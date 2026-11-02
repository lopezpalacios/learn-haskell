module Chapter08 where

data MyMaybe a = MyNothing | MyJust a
  deriving (Show, Eq)

-- Exercise 1: Functor.
instance Functor MyMaybe where
  fmap = undefined

-- Exercise 2: Applicative.
instance Applicative MyMaybe where
  pure = undefined
  (<*>) = undefined

-- Exercise 3: Monad.
instance Monad MyMaybe where
  (>>=) = undefined

-- Exercise 4: all pairs with the list monad.
pairs :: [(Int, Int)]
pairs = undefined

-- Exercise 5: rewrite addMaybe with (>>=) instead of do.
addMaybe :: Maybe Int -> Maybe Int -> Maybe Int
addMaybe mx my = do
  x <- mx
  y <- my
  pure (x + y)
