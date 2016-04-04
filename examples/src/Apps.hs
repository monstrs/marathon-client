{-# LANGUAGE OverloadedStrings #-}

module Apps where

import Prelude hiding       (id)

import Common

import Marathon
import Marathon.Data.App
import Marathon.Data.Container
import Marathon.Data.Docker

createAppEx :: IO ()
createAppEx = do
    conf <- getConf
    res <- createApp conf app
    printRes res
    where
        cnt = Container
            { ctype = "DOCKER"
            , docker = Just Docker
                { image          = "tomcat:8.0"
                , network        = Just "BRIDGE"
                , forcePullImage = Nothing
                , privileged     = Nothing
                , parameters     = Nothing
                , portMappings   = Nothing
                }
            , volumes = Nothing
            }

        app = App
            { id                    = "/tomcat"
            , instances             = Just 1
            , cpus                  = Just 1.0
            , mem                   = Just 512
            , container             = Just cnt
            , cmd                   = Nothing
            , args                  = Nothing
            , uris                  = Nothing
            , constraints           = Nothing
            , acceptedResourceRoles = Nothing
            , env                   = Nothing
            , labels                = Nothing
            , executor              = Nothing
            , ports                 = Nothing
            , requirePorts          = Nothing
            , dependencies          = Nothing
            , backoffSeconds        = Nothing
            , backoffFactor         = Nothing
            , maxLaunchDelaySeconds = Nothing
            , tasks                 = Nothing
            , tasksStaged           = Nothing
            , tasksRunning          = Nothing
            , tasksHealthy          = Nothing
            , tasksUnhealthy        = Nothing
            , healthChecks          = Nothing
            , upgradeStrategy       = Nothing
            , version               = Nothing
            }

getAppsEx :: IO ()
getAppsEx = do
    conf <- getConf
    res <- getApps conf
    printRes res

getAppEx :: IO ()
getAppEx = do
    conf <- getConf
    res <- getApp conf "/tomcat"
    printRes res
