{-# LANGUAGE OverloadedStrings #-}

module Common where

import Data.Aeson               (ToJSON)
import Data.Yaml                (encode)
import Data.ByteString.Char8    (unpack)
import System.Environment       (lookupEnv)

import Marathon.Data.Config
import Marathon.Data.Error

printRes :: (ToJSON a) => (Either Error a) -> IO ()
printRes (Left e) = putStrLn $ show e
printRes (Right r) = putStrLn $ ("\x1b[32m" ++ (unpack $ encode r) ++ "\x1b[0m")

getConf :: (IO Config)
getConf = do
    url <- lookupEnv "MARATHON_URL"
    return $ Config $ getUrl url
    where
        getUrl :: (Maybe String) -> String
        getUrl Nothing = "http://127.0.0.1:8080"
        getUrl (Just []) = "http://127.0.0.1:8080"
        getUrl (Just u) = u
