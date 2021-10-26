
local TestCase = require "wLuaUnit.TestCase"

local TestColorFactory = TestCase:extend()

TestColorFactory.testClassPath = "ColorFactory"

TestColorFactory.dependencyPaths = {
  { id = "ColorCodeFinder", path = "ColorCodeFinder", ["type"] = "table" },
  { id = "Color", path = "Color" } -- Default type is "object"
}


TestColorFactory.colorCodeFinderMock = nil


function TestColorFactory:testCanCreateColor()

  local ColorFactory = self.testClass
  local ColorCodeFinderDependencyMock = self.dependencyMocks["ColorCodeFinder"]
  local ColorDependencyMock = self.dependencyMocks["Color"]

  local colorMock = self:getMock("Color")
  local color

  ColorCodeFinderDependencyMock.getColorCodeFromColorName
                               :should_be_called_with("black")
                               :and_will_return("thecolorcode")
                               :and_then(
                                 ColorDependencyMock.__call
                                                    :should_be_called()
                                                    :and_will_return(colorMock)
                               )
                               :and_then(
                                 colorMock.setCode
                                          :should_be_called_with("thecolorcode")
                               )
                               :when(
                                 function()
                                   local colorFactory = ColorFactory()
                                   color = colorFactory:createColor("black")
                                 end
                               )

  self:assertEquals(color, colorMock)

end


return TestColorFactory
