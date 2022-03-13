module Lib
    ( usage
    ) where

import Data.Aeson

{- Turing Machine Name -}
type Name = String
data TapeAction = LEFT | RIGHT | HALT deriving (Enum)

{- Alphabet -}
type Symbol   = Char
type Alphabet = [Symbol]
type Blank    = Symbol {- need to be an element fron the Alphabet type -}

{- States -}
data State    = {- will need to be defined as a parsed element -> a record -}
  State { stateName   :: String
        , transitions :: [TransitionFunc]
          } deriving (Show, Eq)

type States   = [State]
type Initial  = State
type Finals   = [State]

{- Fonctions de transitions -}
{- Put here -}
data TransitionFunc =
  TransitionFunc { read    :: Symbol
                 , toState :: State
                 , write   :: Symbol
                 , headTo  :: TapeAction
                   } deriving (Show, Eq)

{- Deterministic Turing Machine Definition -}
data Machine =
  Machine { name         :: Name
          , alphabet     :: Alphabet
          , blank        :: Blank
          , states       :: States
          , initialState :: Initial
          , finalStates  :: Finals
            } deriving (Show, Eq)
