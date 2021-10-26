---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require "classic"

local DependencyInjector = Object:extend()


DependencyInjector.valueInjectors = nil


function DependencyInjector:new(_valueInjectors)
  self.valueInjectors = _valueInjectors
end


function DependencyInjector:inject(_injectableValue)

  for _, valueInjector in ipairs(self.valueInjectors) do
    if (valueInjector:canInject(_injectableValue)) then
      valueInjector:inject(_injectableValue)
      break
    end
  end

end

function DependencyInjector:getDependencyMock(_dependencyId)
  return self.dependencyMocks[_dependencyId]
end


return DependencyInjector
