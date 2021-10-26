---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require "classic"

local Base = Object:extend()


function BaseInjector:backupOriginalDependencies()
end

function BaseInjector:restoreOriginalDependencies()
end


return Base
