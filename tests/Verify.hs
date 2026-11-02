module Main where

import qualified Chapter01 as C1
import qualified Chapter02 as C2
import qualified Chapter03 as C3
import qualified Chapter04 as C4
import qualified Chapter05 as C5
import qualified Chapter06 as C6
import qualified Chapter07 as C7
import qualified Chapter08 as C8
import qualified Data.Map as Map

main :: IO ()
main = do
  check "C1.triple"       (C1.triple 7 == 21)
  check "C1.tripleFloat"  (C1.triple 2.5 == 7.5)
  check "C1.absolute"     (C1.absolute (-5) == 5)
  check "C1.averagePair"  (C1.averagePair (2, 4) == 3.0)
  check "C1.oddSquares"   (C1.oddSquares [1..6] == [1,9,25])
  check "C1.swapPairs"    (C1.swapPairs [(1,"a"),(2,"b")] == [("a",1),("b",2)])

  check "C2.same"         (C2.same 3 3 && not (C2.same 3 4))
  check "C2.maxOfThree"   (C2.maxOfThree 3 9 2 == 9)

  check "C3.dayName"      (C3.dayName 1 == "Monday" && C3.dayName 9 == "invalid")
  check "C3.grade"        (C3.grade 95 == "A" && C3.grade 59 == "F")
  check "C3.triangleArea" (near (C3.triangleArea 3 4 5) 6.0)
  check "C3.cylinder"     (near (C3.cylinderVolume 1 2) (2 * pi))
  check "C3.describePair" (C3.describePair (0,0) == "origin")

  check "C4.factorial"    (C4.factorial 5 == 120)
  check "C4.sumList"      (C4.sumList [1..4] == 10)
  check "C4.power"        (C4.power 2 10 == 1024)
  check "C4.replicate"    (C4.replicate' 3 'x' == "xxx")
  check "C4.quicksort"    (C4.quicksort [3,1,4,1,5,9,2,6] == [1,1,2,3,4,5,6,9])

  check "C5.doubleAll"    (C5.doubleAll [1,2,3] == [2,4,6])
  check "C5.keepEven"     (C5.keepEven [1..10] == [2,4,6,8,10])
  check "C5.sumList"      (C5.sumList [1..4] == 10)
  check "C5.compose3"     (C5.compose3 (+1) (*2) negate 3 == -5)
  check "C5.applyTwice"   (C5.applyTwice (+3) 10 == 16)

  check "C6.unique"       (C6.unique [1,2,1,3,2,4] == [1,2,3,4])
  check "C6.sortDesc"     (C6.sortDesc [3,1,4,1,5] == [5,4,3,1,1])
  check "C6.countChars"   (C6.countChars "mississippi" == [('i',4),('m',1),('p',2),('s',4)])
  check "C6.digitSum"     (C6.digitSum "a1b2c3" == 6)
  check "C6.phoneBook"    (Map.lookup "Alice" (C6.phoneBook [("Alice","555-0101")]) == Just "555-0101")

  check "C7.area"         (near (C7.area (C7.Circle 2)) (4 * pi))
  check "C7.showPerson"   (C7.showPerson (C7.Person "Alice" 30) == "Alice (30)")
  check "C7.treeSum"      (C7.treeSum (C7.Node (C7.Node C7.Leaf 1 C7.Leaf) 2 (C7.Node C7.Leaf 3 C7.Leaf)) == 6)
  check "C7.safeDiv"      (C7.safeDiv 10 2 == Just 5 && C7.safeDiv 10 0 == Nothing)
  check "C7.describe"     (C7.describe (C7.Circle 2) == "circle with radius 2.0")

  check "C8.fmap"         (fmap (+1) (C8.MyJust 3) == C8.MyJust 4)
  check "C8.applicative"  ((pure (+1) <*> C8.MyJust 3) == C8.MyJust 4)
  check "C8.monad"        (((C8.MyJust 3) >>= (\x -> C8.MyJust (x + 1))) == C8.MyJust 4)
  check "C8.pairs"        (C8.pairs == [(1,3),(1,4),(2,3),(2,4)])
  check "C8.addMaybe"     (C8.addMaybe (Just 3) (Just 4) == Just 7 && C8.addMaybe (Just 3) Nothing == Nothing)

  putStrLn "All checks passed."

near :: Double -> Double -> Bool
near x y = abs (x - y) < 1e-9

check :: String -> Bool -> IO ()
check name True  = putStrLn ("ok   " ++ name)
check name False = error ("FAIL " ++ name)
