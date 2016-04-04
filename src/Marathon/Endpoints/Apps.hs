{-# LANGUAGE OverloadedStrings #-}

module Marathon.Endpoints.Apps where

import Control.Applicative
import Control.Lens hiding ((.=))
import Data.Aeson
import Data.Aeson.Lens

import Marathon.Data.Config
import Marathon.Data.Error
import Marathon.Data.App
import Marathon.Request

data AppsEntry = AppsEntry
    { apps :: [App] } deriving (Eq, Show)

data AppEntry = AppEntry
    { app :: App } deriving (Eq, Show)

instance FromJSON AppsEntry where
    parseJSON (Object v) = AppsEntry <$> v .: "apps"
    parseJSON _          = empty

instance FromJSON AppEntry where
    parseJSON (Object v) = AppEntry <$> v .: "app"
    parseJSON _          = empty

getApps :: Config -> IO (Either Error [App])
getApps config = do
    res <- get config "/apps" :: IO (Either Error AppsEntry)
    case res of
        (Right r) -> return $ Right $ apps r
        (Left e) -> return $ Left e

createApp :: Config -> App -> IO (Either Error App)
createApp config = post config "/apps"

getApp :: Config -> String -> IO (Either Error App)
getApp config appId = do
    res <- get config ("/apps" ++ appId) :: IO (Either Error AppEntry)
    case res of
        (Right r) -> return $ Right $ app r
        (Left e) -> return $ Left e
