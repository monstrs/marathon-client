{-# LANGUAGE OverloadedStrings #-}

module Marathon.Data.Parameter where

import Control.Applicative
import Control.Lens hiding ((.=))
import Data.Aeson 
import Data.Aeson.Lens hiding (key)

data Parameter = Parameter
    { key   :: String
    , value :: String
    } deriving (Eq, Show)

instance FromJSON Parameter where
    parseJSON (Object v) =
        Parameter
            <$> v .: "key"
            <*> v .: "value"
    parseJSON _          = empty

instance ToJSON Parameter where
    toJSON a =
        object [ "key"   .= key a
               , "value" .= value a]
