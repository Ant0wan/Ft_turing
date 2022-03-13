{-# LANGUAGE DeriveDataTypeable #-}
module Main where

import System.Console.CmdArgs

import Data.Aeson
import Data.Text
import Control.Applicative
import Control.Monad
import qualified Data.ByteString.Lazy as B
import GHC.Generics

import Lib

data Ft_turing = Ft_turing {
   file :: [FilePath]
  ,tape :: String
} deriving (Show, Data, Typeable)

arguments :: Ft_turing
arguments = Ft_turing
  { file = def &= typ "jsonfile" &= argPos 0
  , tape = def &= typ "input"    &= argPos 1
    } &= help "\n\
         \positional arguments:\n\
         \\n\
         \jsonfile       json description of the machine\n\
         \input          input of the machine\n"
      &= summary "Ft_turing v0.1-dev"

instance FromJSON Machine

{-
jsonFile :: FilePath
jsonFile = file
-}

getJSON :: IO B.ByteString
getJSON = B.readFile jsonFile {-jsonFile must be Ft_turing.file component after cli parsing -}

main :: IO ()
main = print =<< cmdArgs arguments
