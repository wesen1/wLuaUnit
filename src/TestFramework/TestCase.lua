---
-- @author wesen
-- @copyright 2018-2021 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local LuaUnit = require "wLuaUnit.TestFramework.LuaUnit"
local mach = require "mach"

---
-- Base class for all unit tests.
-- Internally uses luaunit as unit test framework and mach as mocking framework.
--
local TestCase = LuaUnit:extend()


---
-- The require path for the class that is tested by this TestCase
-- Must be set by each child class
--
-- @tfield string testClassPath
--
TestCase.testClassPath = nil

---
-- The test class
-- This is loaded via the testClassPath during each test's setup
--
-- @tfield table testClass
--
TestCase.testClass = nil

---
-- The infos of the classes that the test class depends on
--
-- Each entry must be in the following format:
-- {
--   id = <string>, -- The dependency ID by which it can be retrieved from getDependencyMock()
--   path = <string>, -- The require path of the dependency
--   type = <string>, -- The type of the dependency ("object" = default, "table", "globalVariable")
--   value = <mixed> -- The value to set the dependency to (only possible for type "globalVariable")
-- }
--
-- Every dependency in this list will be mocked during each test's setup
--
-- @tfield table[] dependencies
--
TestCase.dependencies = {}

---
-- The mocking framework
--
-- @tfield mach mach
--
TestCase.mach = mach

TestCase.dependencyInjector = nil
TestCase.mockCreator = nil


-- Public Methods

function TestCase:new()

  local valueBackupCollection = ValueBackupCollection()

  self.dependencyInjector = DependencyInjector()
  self.mockCreator = MockCreator()
end

---
-- Method that is called before a test is executed.
-- Initializes the dependency mocks and loads the test class.
--
function TestCase:setUp()

  self.dependencyInjector:backupOriginalDependencies()
  self.dependencyInjector:initializeDependencyMocks()

  -- Unload the test class for the case that it was loaded while requiring one of its dependencies
  package.loaded[self.testClassPath] = nil

  -- Load the test class
  self.testClass = require(self.testClassPath)

end

---
-- Method that is called after a test was executed.
-- Clears the mocks and restores the packages that were loaded before the test was executed.
--
function TestCase:tearDown()
  self.dependencyInjector:restoreOriginalDependencies()
  self.testClass = nil
end


-- Protected Methods

---
-- Generates and returns a mock for a object or class.
--
-- @tparam table _mockTarget The mock target (May be a require path, class or table)
-- @tparam string _mockName The name of the mock
-- @tparam string _mockType The mock type (Can be either "object" or "table")
--
-- @treturn table The mock of the object or class
--
function TestCase:createMock(_mockTarget, _mockName, _mockType)
  self.mockCreator:createMock(_mockTarget, _mockName, _mockType)
end

---
-- Returns one of the dependency mocks.
--
-- @tparam string _dependencyId The id of the dependency in the dependencyPaths table
--
-- @treturn table The dependency mock or nil if there is no dependency mock for that id
--
function TestCase:getDependencyMock(_dependencyId)
  return self.dependencyInjector:getDependencyMock(_dependencyId)
end


return TestCase
