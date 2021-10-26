---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require "classic"

local BaseInjectable = Object:extend()


BaseInjectable.identifier = nil
BaseInjectable.replacement = nil


function BaseInjectable:new(_identifier, _replacement)
  self.identifier = _identifier
  self.replacement = _replacement
end


function BaseInjectable:getDependencyIdentifier()
  return self.identifier
end

function BaseInjectable:getDependencyReplacement()
  return self.replacement
end


return BaseInjectable
