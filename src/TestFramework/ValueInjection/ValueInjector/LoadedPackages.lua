---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require "classic"

local LoadedPackagesInjector = Object:extend()


function LoadedPackagesInjector:inject(_injectableValue)
  package.loaded[_injectableValue:getDependencyIdentifier()] = _injectableValue:getDependencyReplacement()
end


return LoadedPackagesInjector
