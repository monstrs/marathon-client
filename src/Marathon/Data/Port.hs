{-# LANGUAGE OverloadedStrings #-}

module Marathon.Data.Port where

import Control.Applicative
import Control.Lens hiding ((.=))
import Data.Aeson
import Data.Aeson.Lens

data Port = Port
    { containerPort :: Integer
    , hostPort      :: Maybe Integer
    , servicePort   :: Maybe Integer
    , protocol      :: Maybe String
    } deriving (Eq, Show)

instance FromJSON Port where
    parseJSON (Object v) =
        Port
            <$> v .: "containerPort"
            <*> v .:? "hostPort"
            <*> v .:? "servicePort"
            <*> v .:? "protocol"
    parseJSON _          = empty

instance ToJSON Port where
    toJSON a =
        object [ "containerPort" .= containerPort a
               , "hostPort"      .= hostPort a
               , "servicePort"   .= servicePort a
               , "protocol"      .= protocol a]
