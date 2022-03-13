{-# LANGUAGE DeriveDataTypeable #-}
module Main where

import System.Console.CmdArgs

import Lib

data Ft_turing = Ft_turing {
   files :: [FilePath]
  ,tape  :: String
} deriving (Show, Data, Typeable)

arguments :: Ft_turing
arguments = Ft_turing
  { files = def &= typ "jsonfile" &= argPos 0
  , tape  = def &= typ "input"    &= argPos 1
    } &= help "\n\
         \positional arguments:\n\
         \\n\
         \jsonfile       json description of the machine\n\
         \input          input of the machine\n"
      &= summary "Ft_turing v0.1-dev"

action :: TapeAction
action = LEFT

main :: IO ()
main = print =<< cmdArgs arguments
