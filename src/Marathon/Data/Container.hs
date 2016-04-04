{-# LANGUAGE OverloadedStrings #-}

module Marathon.Data.Container where

import Control.Applicative
import Control.Lens hiding ((.=))
import Data.Aeson
import Data.Aeson.Lens

import Marathon.Data.Docker
import Marathon.Data.Volume

data Container = Container
    { ctype   :: String
    , docker  :: Maybe Docker
    , volumes :: Maybe [Volume]
    } deriving (Eq, Show)

instance FromJSON Container where
    parseJSON (Object v) =
        Container
            <$> v .: "type"
            <*> v .: "docker"
            <*> v .: "volumes"
    parseJSON _          = empty

instance ToJSON Container where
    toJSON a =
        object [ "type"    .= ctype a
               , "docker"  .= docker a
               , "volumes" .= volumes a]
