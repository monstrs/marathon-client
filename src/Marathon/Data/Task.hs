{-# LANGUAGE OverloadedStrings #-}

module Marathon.Data.Task where

import Prelude hiding (id)

import Control.Applicative
import Control.Lens hiding ((.=))
import Data.Aeson
import Data.Aeson.Lens

data Task = Task
    { host          :: String
    , id            :: String
    , appId         :: String
    , ports         :: [Integer]
    , stagedAt      :: Maybe String
    , startedAt     :: Maybe String
    } deriving (Eq, Show)

instance FromJSON Task where
    parseJSON (Object v) =
        Task
            <$> v .: "host"
            <*> v .: "id"
            <*> v .: "appId"
            <*> v .: "ports"
            <*> v .:? "stagedAt"
            <*> v .:? "startedAt"
    parseJSON _          = empty

instance ToJSON Task where
    toJSON a =
        object [ "host"         .= host a
               , "id"           .= id a
               , "appId"        .= appId a
               , "ports"        .= ports a
               , "stagedAt"     .= ports a
               , "startedAt"    .= ports a]
