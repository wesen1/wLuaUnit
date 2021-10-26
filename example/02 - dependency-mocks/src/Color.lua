
local Object = require "classic"

local Color = Object:extend()


Color.code = nil


function Color:setCode(_code)
  self.code = _code
end

function Color:getCode()
  return self.code
end


return Color
