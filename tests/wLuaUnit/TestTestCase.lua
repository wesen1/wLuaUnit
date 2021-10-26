---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local luaunit = require "luaunit"
local mach = require "mach"

local luaunitMock = mach.mock_object(luaunit, "luaunitMock")
local machMock = mach.mock_object(mach, "machMock")

package.loaded["luaunit"] = luaunitMock
package.loaded["mach"] = machMock


-- Require the test TestCases

local TestCaseForClassWithoutDependencies = require "tests.wLuaUnit.test-cases.TestCaseForClassWithoutDependencies"

local TestCase = require "TestCase"
local testCase


-- 1. Loads testClass from testClassPath




function testLoadsTestClassFromTestClassPath()

  local ExampleClass = require "tests.wLuaUnit.example-src.ExampleClass"

  testCase = TestCaseForClassWithoutDependencies()
  testCase:setUp()

  luaunit.assertEquals(testCase:getTestClass(), ExampleClass)

end


-- TODO: Add the following tests

-- 2. Mocks only configured dependencies
-- 3. Mocks configured depdencies in the correct way
-- 3.1 Can mock class
-- 3.2 Can mock table
-- 3.3 Can mock global constant/variable that is not a table
-- 3.4 Can mock global table
-- 4. Mocks configured dependencies before each test and clears all loaded dependencies after each test
-- 5. mach attribute is really the mach dependency?
-- 6. Allows calling luaunit methods as own methods
-- 6.1 with "."
-- 6.2 with ":"
-- 7. Calling parent class stuff still works
-- 8. Allows fetching luaunit fields that are not methods
-- 9. Special case: Test class was already loaded while mocking its dependencies, should be reloaded with mocked dependencies so it doesn't use the real dependencies
-- 10. Can expect exception
-- 11. Can create mocks
-- 11.1 Can load class that is also mocked dependency from a string
-- 11.2 Can load class that is not a mocked depedency from a string
-- 11.3 Can mock a class that is passed to it
-- 11.4 Can mock a table that is passed to it

