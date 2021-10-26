
local Object = require "classic"

local Calculator = Object:extend()


function Calculator:subtract(_numberA, _numberB)

  if (type(_numberA) ~= "number" or type(_numberB) ~= "number") then
    error("Cannot subtract non numbers")
  else
    return _numberA - _numberB
  end

end

function Calculator:multiply(_numberA, _numberB)

  if (type(_numberA) ~= "number" or type(_numberB) ~= "number") then
    error({ message = "Cannot multiply non numbers" })
  else
    return _numberA * _numberB
  end

end


return Calculator
