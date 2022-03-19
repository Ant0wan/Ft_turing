module Turing where

import Debug.Trace

import           Data.Foldable (toList)
import qualified Data.List as L
import qualified Data.Sequence as Seq
import           Data.Sequence (Seq, (<|), (|>), ViewL (..), ViewR(..))
-- <| : Add an element to the left end of a sequence.
-- |> : Add an element to the right end of a sequence.
-- ViewL and ViewR : view of the left/right end of a sequence

type State = Int
type Symbol = Char

-- | Tape head movement direction.
data Direction = MoveLeft | MoveRight

-- | original
-- data Machine = Machine {
--   transition :: State -> Maybe Symbol -> (State, Symbol, Direction)
-- , startState, acceptState, rejectState :: State
-- }
data Machine = Machine {
  transition :: State -> Maybe Symbol -> (State, Symbol, Direction)
, startState, eraseone, subone, skip, acceptState, rejectState :: State
}

data TapeCfg = TapeCfg {
  leftSyms  :: Seq Symbol    -- ^ symbols to the left of tape head
, currSym   :: Maybe Symbol  -- ^ symbol under the tape head
, rightSyms :: Seq Symbol    -- ^ symbols to the right of tape head
}

data MachineCfg = MachineCfg {
    currState :: State
  , tapeCfg :: TapeCfg
}

instance Show TapeCfg where
  show (TapeCfg l c r) = toList l ++ [maybe ' ' id c] ++ toList r

instance Show MachineCfg where
  show (MachineCfg s t) =
    show t ++ "\n" ++ replicate (Seq.length $ leftSyms t) ' ' ++ "| q"
    ++ show s
  showList = showString . L.intercalate "\n\n" . map show

-- | modif curr symbol by a new one then move tape head
updateTapeCfg :: TapeCfg -> Symbol -> Direction -> TapeCfg
updateTapeCfg _ symbol _ | trace ("updateTapeCfg symbol: " ++ show symbol) False = undefined
updateTapeCfg (TapeCfg lSyms _ rSyms) newSym MoveLeft =
  case Seq.viewr lSyms of EmptyR -> TapeCfg Seq.empty Nothing right
                          lInit :> lLast -> TapeCfg lInit (Just lLast) right
    where right = newSym <| rSyms
updateTapeCfg (TapeCfg lSyms _ rSyms) newSym MoveRight = 
  case Seq.viewl rSyms of EmptyL -> TapeCfg left Nothing Seq.empty
                          rHead :< rTail -> TapeCfg left (Just rHead) rTail
    where left = lSyms |> newSym

-- | Execute one transition step for given machine and config
updateMachineCfg :: Machine -> MachineCfg -> MachineCfg
updateMachineCfg m (MachineCfg state tape) =
  let (state', newSym, dir) = transition m state (currSym tape)
   in MachineCfg state' $ updateTapeCfg tape newSym dir

-- Initialise tape with input word
initTapeCfg :: [Symbol] -> TapeCfg
initTapeCfg [] = TapeCfg Seq.empty Nothing Seq.empty
initTapeCfg (x:xs) = TapeCfg Seq.empty (Just x) (Seq.fromList xs)

-- initialise machine config with input word
initMachineCfg :: Machine -> [Symbol] -> MachineCfg
initMachineCfg m input = MachineCfg (startState m) (initTapeCfg input)

-- Return true if the machine is in a final state
machineCfgFinal :: Machine -> MachineCfg -> Bool
machineCfgFinal m (MachineCfg {currState  = c}) =
  c == acceptState m ||
  c == rejectState m

-- Return requence of machine configs for given input word until final state
runMachine :: Machine -> [Symbol] -> [MachineCfg]
runMachine m =
  break' (machineCfgFinal m) . iterate (updateMachineCfg m) . initMachineCfg m
    where break' p xs = let (prefix, rest) = break p xs in prefix ++ [head rest]
