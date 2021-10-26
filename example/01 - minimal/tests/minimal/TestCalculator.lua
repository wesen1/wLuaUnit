
local TestCase = require "wLuaUnit.TestCase"

local TestCalculator = TestCase:extend()


TestCalculator.testClassPath = "Calculator"


function TestCalculator:testCanAddOneAndTwo()

  local Calculator = self.testClass

  local calculator = Calculator()
  self:assertEquals(calculator:add(1, 2), 3)
  self:assertEquals(calculator:add(2, 3), 5)

end


return TestCalculator
