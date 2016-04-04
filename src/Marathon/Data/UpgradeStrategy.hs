{-# LANGUAGE OverloadedStrings #-}

module Marathon.Data.UpgradeStrategy where

import Prelude hiding (id)

import Control.Applicative
import Control.Lens hiding ((.=))
import Data.Aeson
import Data.Aeson.Lens

data UpgradeStrategy = UpgradeStrategy
    { minimumHealthCapacity     :: Double
    , maximumOverCapacity       :: Double
    } deriving (Eq, Show)

instance FromJSON UpgradeStrategy where
    parseJSON (Object v) =
        UpgradeStrategy
            <$> v .: "minimumHealthCapacity"
            <*> v .: "maximumOverCapacity"
    parseJSON _          = empty

instance ToJSON UpgradeStrategy where
    toJSON a =
        object [ "minimumHealthCapacity"    .= minimumHealthCapacity a
               , "maximumOverCapacity"      .= maximumOverCapacity a]
