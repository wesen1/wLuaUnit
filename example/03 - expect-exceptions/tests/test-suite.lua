
-- Add the wLuaUnit src directory to package.path
package.path = package.path .. ";../../../src/?.lua"

-- Add the minimal example src directory to package.path
package.path = package.path .. ";../src/?.lua"

local TestRunner = require "wLuaUnit.TestRunner"


local runner = TestRunner()

runner:addTestDirectory("expect-exceptions")
      :run()
