
-- Add the wLuaUnit src directory to package.path
package.path = package.path .. ";../../../src/?.lua"

-- Add the class-dependency-mocks example src directory to package.path
package.path = package.path .. ";../src/?.lua"

local TestRunner = require "wLuaUnit.TestRunner"


local runner = TestRunner()

runner:addTestDirectory("dependency-mocks")
      :run()
