module Marathon.Data.Error where

import Network.HTTP.Client      (HttpException)
import Data.Data                (Data, Typeable)
import Data.Text                (Text)
import Network.Wreq

data Error
    = HTTPError !HttpException
    | ParseError !Text
    deriving (Show, Typeable)
