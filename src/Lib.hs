module Lib
    ( usage
    ) where

import System.Environment (getProgName)

usage :: IO ()
usage = do
  name <- getProgName
  let message = "usage: " ++ name ++ " [-h] jsonfile input\n\
\\n\
\positional arguments:\n\
\  jsonfile\tjson description of the machine\n\
\\n\
\  input\t\tinput of the machine\n\
\\n\
\optional arguments:\n\
\  -h, --help show this help message and exit"
  putStrLn message
