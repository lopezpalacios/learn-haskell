module Chapter03 where

dayName :: Int -> String
dayName 1 = "Monday"
dayName 2 = "Tuesday"
dayName 3 = "Wednesday"
dayName 4 = "Thursday"
dayName 5 = "Friday"
dayName 6 = "Saturday"
dayName 7 = "Sunday"
dayName _ = "invalid"

grade :: Int -> String
grade score
  | score >= 90 = "A"
  | score >= 80 = "B"
  | score >= 70 = "C"
  | score >= 60 = "D"
  | otherwise   = "F"

triangleArea :: Double -> Double -> Double -> Double
triangleArea a b c =
  sqrt (s * (s - a) * (s - b) * (s - c))
  where
    s = (a + b + c) / 2

cylinderVolume :: Double -> Double -> Double
cylinderVolume r h =
  let base = pi * r ^ 2
  in  base * h

describePair :: (Int, Int) -> String
describePair p = case p of
  (0, 0) -> "origin"
  (_, 0) -> "x-axis"
  (0, _) -> "y-axis"
  _      -> "elsewhere"
