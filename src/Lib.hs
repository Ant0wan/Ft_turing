module Lib
    ( usage
    ) where

{- Turing Machine Name -}
type Name     = String

{- Alphabet -}
type Symbol   = Char
type Alphabet = [Symbol]
type Blank    = Symbol {- need to be an element fron the Alphabet type -}

{- States -}
type State    = String {- will need to be defined as a parsed element -> a record -}
type States   = [State]
type Initial  = State
type Finals   = [State]

{- Fonctions de transitions -}
{- Put here -}


{- Deterministic Turing Machine Definition -}
data Machine =
  Machine { name         :: Name
          , alphabet     :: Alphabet
          , blank        :: Blank
          , states       :: States
          , initialState :: Initial
          , finalStates  :: Finals
            } deriving (Show, Eq)
