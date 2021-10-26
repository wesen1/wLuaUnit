
local Object = require "classic"

local Calculator = Object:extend()


function Calculator:add(_numberA, _numberB)
  return _numberA + _numberB
end


return Calculator
