{-# LANGUAGE OverloadedStrings #-}

module Marathon.Data.Volume where

import Control.Applicative
import Control.Lens hiding ((.=))
import Data.Aeson
import Data.Aeson.Lens

data Volume = Volume
    { containerPath :: String
    , hostPath      :: String
    , mode          :: String
    } deriving (Eq, Show)

instance FromJSON Volume where
    parseJSON (Object v) =
        Volume
            <$> v .: "containerPath"
            <*> v .: "hostPath"
            <*> v .: "mode"
    parseJSON _          = empty

instance ToJSON Volume where
    toJSON a =
        object [ "containerPath" .= containerPath a
               , "hostPath"      .= hostPath a
               , "mode"          .= mode a]
