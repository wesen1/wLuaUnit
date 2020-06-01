---
-- @author wesen
-- @copyright 2019-2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local lfs = require "lfs"
local luaunit = require "luaunit"
local Object = require "classic"

---
-- Allows to configure and run a test suite of luaunit tests.
--
-- @type TestRunner
--
local TestRunner = Object:extend()


---
-- Adds a test directory to load tests from to this TestRunner.
--
-- @tparam string _directoryPath The directory path to add
-- @tparam string[] _excludePatterns The patterns for files to ignore inside the directory (optional)
--
-- @treturn TestRunner The TestRunner instance to allow chaining other method calls
--
function TestRunner:addTestDirectory(_directoryPath, _excludePatterns)

  local excludePatterns
  if (type(_excludePatterns) == "table") then
    excludePatterns = _excludePatterns
  else
    excludePatterns = {}
  end

  self:requireTestsRecursive(_directoryPath, excludePatterns)
  return self

end

---
-- Enables code coverage analysis.
--
-- @tparam string _configFileName The name of the luacov config file to use
--
-- @treturn TestRunner The TestRunner instance to allow chaining other method calls
--
function TestRunner:enableCoverageAnalysis(_configFileName)

  local configFileName
  if (type(_configFileName) == "string") then
    configFileName = _configFileName
  else
    configFileName = ".luacov"
  end

  require("luacov.runner")(configFileName)
  return self
end

---
-- Runs the luaunit tests and exits the lua script with luaunit's return status.
--
function TestRunner:run()
  os.exit(luaunit.LuaUnit.run())
end


-- Private Methods

---
-- Requires all unit test lua files from a specified directory recursively.
--
-- @tparam string _testDirectoryPath The path to the directory relative from the entry point file's directory
-- @tparam string[] _excludePatterns The patterns for files to ignore inside the directory
--
function TestRunner:requireTestsRecursive(_testDirectoryPath, _excludePatterns)

  for fileName in lfs.dir(_testDirectoryPath) do

    if (fileName ~= "." and fileName ~= "..") then

      local filePath = _testDirectoryPath .. "/" .. fileName
      local filePathMatchesExcludePattern = false
      for _, excludePattern in ipairs(_excludePatterns) do
        if (filePath:match(excludePattern)) then
          filePathMatchesExcludePattern = true
          break
        end
      end

      if (not filePathMatchesExcludePattern) then

        local fileAttributes = lfs.attributes(filePath)

        if (fileAttributes.mode == "directory") then
          self:requireTestsRecursive(filePath, _excludePatterns)
        elseif (fileName:match("^Test.+%.lua$")) then

          -- Use the entire file path as variable name so that tests with the same name
          -- but in different directories are all loaded as expected
          local globalVariableName = "Test" .. filePath:gsub("%.lua$", "")
          local classRequirePath = filePath:gsub("%.lua$", "")

          -- Add the class to the "globals" table because LuaUnit will only execute test functions that
          -- start with "test" and that it finds inside that table
          _G[globalVariableName] = require(classRequirePath)

        end

      end

    end

  end

end


return TestRunner
