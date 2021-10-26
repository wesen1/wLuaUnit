
local Object = require "classic"
local Color = require "Color"
local ColorCodeFinder = require "ColorCodeFinder"

local ColorFactory = Object:extend()


function ColorFactory:createColor(_colorName)

  local colorCode = ColorCodeFinder.getColorCodeFromColorName(_colorName)
  if (colorCode ~= nil) then

    local color = Color()
    color:setCode(colorCode)

    return color

  end

end


return ColorFactory
