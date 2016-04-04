{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE OverloadedStrings #-}

module Marathon.Request where

import Data.Aeson
import Network.HTTP.Client      (HttpException)
import Control.Exception
import Control.Lens

import qualified Network.Wreq as W

import Marathon.Data.Config
import Marathon.Data.Error

get :: FromJSON a => Config -> String -> IO (Either Error a)
get config entry = execGet config entry `catch` onHttpException

post :: (ToJSON a, FromJSON b) => Config -> String -> a -> IO (Either Error b)
post config entry body = execPost config entry body `catch` onHttpException

execGet :: FromJSON a => Config -> String -> IO (Either Error a)
execGet config entry = do
    r <- W.asJSON =<< W.get (getUrl config entry)
    return $ Right $ r ^. W.responseBody

execPost :: (ToJSON a, FromJSON b) => Config -> String -> a -> IO (Either Error b)
execPost config entry body = do
    r <- W.asJSON =<< W.post (getUrl config entry) (toJSON body)
    return $ Right $ r ^. W.responseBody

getUrl :: Config -> String -> String
getUrl (Config url) entry = url ++ "/v2" ++ entry

onHttpException :: HttpException -> IO (Either Error a)
onHttpException error = return $ Left $ HTTPError error
