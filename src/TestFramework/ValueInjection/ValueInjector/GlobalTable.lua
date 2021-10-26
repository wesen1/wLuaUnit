---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local GlobalTableInjectableValue = require "wLuaUnit.TestFramework.ValueInjection.InjectableValue.GlobalTable"

local GlobalTableInjector = Object:extend()



function GlobalTableInjector:canInject(_injectableValue)
  return _injectableValue:is(GlobalTableInjectableValue)
end

function GlobalTableInjector:inject(_injectableValue)
  _G[_injectableValue:getDependencyIdentifier()] = _injectableValue:getDependencyReplacement()
end


return GlobalTableInjector
