module Main where
import Turing

machine42 :: Machine
machine42 =
  Machine {
    transition = t
    , startState = 0 -- scanright
    , acceptState = 5 -- scanright
    , eraseone = 1
    , subone = 2
    , skip = 3
    , rejectState = 4 -- HALT
  } where
  t 5 (Just '.') = (5, '.', MoveRight)
  t 5 (Just '1') = (5, '1', MoveRight)
  t 5 (Just '-') = (5, '-', MoveRight)
  t 5 (Just '=') = (1, '.', MoveLeft)
  t 1 (Just '1') = (2, '=', MoveLeft)
  t 1 (Just '-') = (4, '.', MoveLeft)
  t 2 (Just '1') = (2, '1', MoveLeft)
  t 2 (Just '-') = (3, '-', MoveLeft)
  t 3 (Just '.') = (3, '.', MoveLeft)
  t 3 (Just '1') = (0, '.', MoveRight)
  -- t _ (Just x) = (4, 'Q', MoveRight)
  -- t _ Nothing = (4, 'W', MoveRight)

-- testMachine :: Machine
-- testMachine =
--   Machine {
--     transition = t
--     , startState = 0
--     , acceptState = 2
--     , rejectState = 3
--   } where
--     t 0 (Just x) = (0,  x, MoveRight)
--     t 0 Nothing  = (1, 'E', MoveLeft)
--     t 1 (Just x) = (1,   x, MoveLeft)
--     t 1 Nothing  = (2, 'S', MoveRight)

main :: IO ()
main = print $ runMachine machine42 "111-11="
