{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
-- https://www.schoolofhaskell.com/school/starting-with-haskell/libraries-and-frameworks/text-manipulation/json
-- Data.ByteString.Char8
-- Data.ByteString.Lazy.Char8
import Data.Aeson
import qualified Data.ByteString.Lazy as B
import Network.HTTP.Conduit (simpleHttp)

-- smart way 
data Person =
  Person { firstName  :: !Text
         , lastName   :: !Text
         , age        :: Int
         , likesPizza :: Bool
           } deriving (Show,Generic)
-- not smart way
-- data Person =
--   Person { firstName  :: !Text
--          , lastName   :: !Text
--          , age        :: Int
--          , likesPizza :: Bool
--            } deriving Show

-- instance FromJSON Person where
--  parseJSON (Object v) =
--     Person <$> v .: "firstName"
--            <*> v .: "lastName"
--            <*> v .: "age"
--            <*> v .: "likesPizza"
--  parseJSON _ = mzero

-- instance ToJSON Person where
--  toJSON (Person firstName lastName age likesPizza) =
--     object [ "firstName"  .= firstName
--            , "lastName"   .= lastName
--            , "age"        .= age
--            , "likesPizza" .= likesPizza
--              ]

instance FromJSON Person
instance ToJSON Person

jsonURL :: String
jsonURL = "http://daniel-diaz.github.io/misc/pizza.json"

getJSON :: IO.ByteString
getJSON = simpleHttp jsonURL

main :: IO()
main = do
  -- get Json data and decode it
  d <- (eitherDecode <$> getJSON) :: IO (Either String [Person])
  case d of
    Left err -> putStrLn err
    Right ps -> print ps
