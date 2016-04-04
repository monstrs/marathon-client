{-# LANGUAGE OverloadedStrings #-}

module Marathon.Data.Docker where

import Control.Applicative
import Control.Lens hiding ((.=))
import Data.Aeson
import Data.Aeson.Lens

import Marathon.Data.Port
import Marathon.Data.Parameter

data Docker = Docker
    { image          :: String
    , network        :: Maybe String
    , forcePullImage :: Maybe Bool
    , privileged     :: Maybe Bool
    , parameters     :: Maybe [Parameter]
    , portMappings   :: Maybe [Port]
    } deriving (Eq, Show)

instance FromJSON Docker where
    parseJSON (Object v) =
        Docker
            <$> v .: "image"
            <*> v .:? "network"
            <*> v .:? "forcePullImage"
            <*> v .:? "privileged"
            <*> v .:? "parameters"
            <*> v .:? "portMappings"
    parseJSON _          = empty

instance ToJSON Docker where
    toJSON a =
        object [ "image"          .= image a
               , "network"        .= network a
               , "forcePullImage" .= forcePullImage a
               , "privileged"     .= privileged a
               , "parameters"     .= parameters a
               , "portMappings"   .= portMappings a]
