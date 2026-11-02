module Chapter08 where

data MyMaybe a = MyNothing | MyJust a
  deriving (Show, Eq)

instance Functor MyMaybe where
  fmap _ MyNothing  = MyNothing
  fmap f (MyJust x) = MyJust (f x)

instance Applicative MyMaybe where
  pure = MyJust
  MyNothing <*> _ = MyNothing
  MyJust f  <*> mx = fmap f mx

instance Monad MyMaybe where
  MyNothing >>= _ = MyNothing
  MyJust x  >>= f = f x

pairs :: [(Int, Int)]
pairs = [1,2] >>= \x -> [3,4] >>= \y -> pure (x, y)

addMaybe :: Maybe Int -> Maybe Int -> Maybe Int
addMaybe mx my = mx >>= \x -> my >>= \y -> pure (x + y)
