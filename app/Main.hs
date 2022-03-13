module Main where

import System.Environment

import Lib

{-
-}

main :: IO ()
main = do
  args <- getArgs
  let phrase = foldr (\x -> (++ " " ++ x)) [] args
  putStrLn (phrase)
  usage
