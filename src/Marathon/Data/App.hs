{-# LANGUAGE OverloadedStrings #-}

module Marathon.Data.App where

import Prelude hiding (id)

import Control.Applicative
import Control.Lens hiding ((.=))
import Data.Aeson
import Data.Aeson.Lens
import Data.Map (Map)

import Marathon.Data.Container
import Marathon.Data.Task hiding (id, ports)
import Marathon.Data.HealthCheck
import Marathon.Data.UpgradeStrategy

data App = App
    { id                    :: String
    , cmd                   :: Maybe String
    , args                  :: Maybe [String]
    , instances             :: Maybe Integer
    , cpus                  :: Maybe Double
    , mem                   :: Maybe Double
    , uris                  :: Maybe [String]
    , constraints           :: Maybe [[String]]
    , acceptedResourceRoles :: Maybe [String]
    , container             :: Maybe Container
    , env                   :: Maybe (Map String String)
    , labels                :: Maybe (Map String String)
    , executor              :: Maybe String
    , ports                 :: Maybe [Integer]
    , requirePorts          :: Maybe Bool
    , dependencies          :: Maybe [String]
    , backoffSeconds        :: Maybe Integer
    , backoffFactor         :: Maybe Double
    , maxLaunchDelaySeconds :: Maybe Integer
    , tasks                 :: Maybe [Task]
    , tasksStaged           :: Maybe Integer
    , tasksRunning          :: Maybe Integer
    , tasksHealthy          :: Maybe Integer
    , tasksUnhealthy        :: Maybe Integer
    , healthChecks          :: Maybe [HealthCheck]
    , upgradeStrategy       :: Maybe UpgradeStrategy
    , version               :: Maybe String
    } deriving (Eq, Show)

instance FromJSON App where
    parseJSON (Object v) =
        App
            <$> v .: "id"
            <*> v .:? "cmd"
            <*> v .: "args"
            <*> v .: "instances"
            <*> v .: "cpus"
            <*> v .: "mem"
            <*> v .: "uris"
            <*> v .: "constraints"
            <*> v .: "acceptedResourceRoles"
            <*> v .: "container"
            <*> v .: "env"
            <*> v .: "labels"
            <*> v .: "executor"
            <*> v .: "ports"
            <*> v .: "requirePorts"
            <*> v .: "dependencies"
            <*> v .: "backoffSeconds"
            <*> v .: "backoffFactor"
            <*> v .: "maxLaunchDelaySeconds"
            <*> v .:? "tasks"
            <*> v .: "tasksStaged"
            <*> v .: "tasksRunning"
            <*> v .: "tasksHealthy"
            <*> v .: "tasksUnhealthy"
            <*> v .:? "healthChecks"
            <*> v .: "upgradeStrategy"
            <*> v .: "version"
    parseJSON _          = empty

instance ToJSON App where
    toJSON a =
        object [ "id"                    .= id a
               , "cmd"                   .= cmd a
               , "args"                  .= args a
               , "instances"             .= instances a
               , "cpus"                  .= cpus a
               , "mem"                   .= mem a
               , "uris"                  .= uris a
               , "constraints"           .= constraints a
               , "acceptedResourceRoles" .= acceptedResourceRoles a
               , "container"             .= container a
               , "env"                   .= env a
               , "labels"                .= labels a
               , "executor"              .= executor a
               , "ports"                 .= ports a
               , "requirePorts"          .= requirePorts a
               , "dependencies"          .= dependencies a
               , "backoffSeconds"        .= backoffSeconds a
               , "backoffFactor"         .= backoffFactor a
               , "maxLaunchDelaySeconds" .= maxLaunchDelaySeconds a
               , "tasks"                 .= tasks a
               , "tasksStaged"           .= tasksStaged a
               , "tasksRunning"          .= tasksRunning a
               , "tasksHealthy"          .= tasksHealthy a
               , "tasksUnhealthy"        .= tasksUnhealthy a
               , "healthChecks"          .= healthChecks a
               , "upgradeStrategy"       .= upgradeStrategy a
               , "version"               .= version a]
