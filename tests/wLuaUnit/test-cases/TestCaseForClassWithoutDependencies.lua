---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local TestCase = require "TestCase"


local TestCaseForClassWithoutDependencies = TestCase:extend()
TestCaseForClassWithoutDependencies.testClassPath = "tests.wLuaUnit.example-src.ExampleClass"


function TestCaseForClassWithoutDependencies:getTestClass()

  return self.testClass

end


return TestCaseForClassWithoutDependencies
