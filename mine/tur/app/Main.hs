module Main where
import Turing

testMachine :: Machine
testMachine =
  Machine {
    transition = t
    , startState = 0
    , acceptState = 2
    , rejectState = 3
  } where
    t 0 (Just x) = (0,  x, MoveRight)
    t 0 Nothing  = (1, 'E', MoveLeft)
    t 1 (Just x) = (1,   x, MoveLeft)
    t 1 Nothing  = (2, 'S', MoveRight)

main :: IO ()
main = print $ runMachine testMachine "10011"
