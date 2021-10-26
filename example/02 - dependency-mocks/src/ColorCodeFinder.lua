
local Object = require "classic"

local ColorCodeFinder = Object:extend()


function ColorCodeFinder.getColorCodeFromColorName(_colorName)

  if (_colorName == "white") then
    return "#FFF"
  elseif (_colorName == "black") then
    return "#000"
  end

end


return ColorCodeFinder
