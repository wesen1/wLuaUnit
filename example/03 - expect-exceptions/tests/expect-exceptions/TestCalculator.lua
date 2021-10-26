
local TestCase = require "wLuaUnit.TestCase"

local TestCalculator = TestCase:extend()


TestCalculator.testClassPath = "Calculator"


function TestCalculator:testThrowsExceptionWhenNonNumbersShouldBeSubtracted()

  local Calculator = self.testClass

  local calculator = Calculator()

  local exception = self:expectException(
    function()
      calculator:subtract(5, "a")
    end
  )

  self:assertStrContains(exception, "Cannot subtract non numbers")

end

function TestCalculator:testThrowsExceptionWhenNonNumbersShouldBeMultiplied()

  local Calculator = self.testClass

  local calculator = Calculator()

  local exception = self:expectException(
    function()
      calculator:multiply("zero", 10)
    end
  )

  self:assertEquals(exception.message, "Cannot multiply non numbers")

end



return TestCalculator
