module Marathon (
    -- * Apps
    -- | See <https://mesosphere.github.io/marathon/docs/generated/api.html#v2_apps>
    getApps,
    createApp,
    getApp,
    ) where

import Marathon.Endpoints.Apps
