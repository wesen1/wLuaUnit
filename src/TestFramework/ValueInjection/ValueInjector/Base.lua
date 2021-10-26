---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require "classic"

local BaseInjector = Object:extend()


function BaseInjector:canInject(_injectableValue)
end

function BaseInjector:inject(_injectableValue)
end


function BaseInjector:backupOriginalDependencies()
end

function BaseInjector:restoreOriginalDependencies()
end


return BaseInjector
