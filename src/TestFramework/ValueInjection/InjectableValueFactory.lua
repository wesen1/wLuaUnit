---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require "classic"

local InjectableValueFactory = Object:extend()


function InjectableValueFactory:getInjectableValue(_dependencyType, _dependencyId, _dependencyMock)

  if (_dependencyType == "globalVariable") then
    return GlobalTableInjectableValue(_dependencyId, _dependencyMock)
  else
    return LoadedPackagesInjectableValue(_dependencyId, _dependencyMock)
  end

end


return InjectableValueFactory
