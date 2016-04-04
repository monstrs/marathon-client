{-# LANGUAGE OverloadedStrings #-}

module Marathon.Data.HealthCheck where

import Prelude hiding (id)

import Control.Applicative
import Control.Lens hiding ((.=))
import Data.Aeson
import Data.Aeson.Lens

data HealthCheck = HealthCheck
    { command                   :: Maybe String
    , gracePeriodSeconds        :: Integer
    , intervalSeconds           :: Integer
    , maxConsecutiveFailures    :: Integer
    , portIndex                 :: Integer
    , timeoutSeconds            :: Integer
    , ignoreHttp1xx             :: Bool
    , path                      :: String
    , protocol                  :: String
    } deriving (Eq, Show)

instance FromJSON HealthCheck where
    parseJSON (Object v) =
        HealthCheck
            <$> v .:? "command"
            <*> v .: "gracePeriodSeconds"
            <*> v .: "intervalSeconds"
            <*> v .: "maxConsecutiveFailures"
            <*> v .: "portIndex"
            <*> v .: "timeoutSeconds"
            <*> v .: "ignoreHttp1xx"
            <*> v .: "path"
            <*> v .: "protocol"
    parseJSON _          = empty

instance ToJSON HealthCheck where
    toJSON a =
        object [ "command"                  .= command a
               , "gracePeriodSeconds"       .= gracePeriodSeconds a
               , "intervalSeconds"          .= intervalSeconds a
               , "maxConsecutiveFailures"   .= maxConsecutiveFailures a
               , "portIndex"                .= portIndex a
               , "timeoutSeconds"           .= timeoutSeconds a
               , "ignoreHttp1xx"            .= ignoreHttp1xx a
               , "path"                     .= path a
               , "protocol"                 .= protocol a]
