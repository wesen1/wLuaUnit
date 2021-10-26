---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

MockCreator:extend()

---
-- Generates and returns a mock for a dependency.
--
-- @tparam mixed _dependency The dependency to mock
-- @tparam string _dependencyId The id of the dependency (Will be used to generate the mock name)
-- @tparam string _dependencyType The dependency type
--
-- @treturn table The mock for the depedency
--
function MockCreator:createDependencyMock(_dependency, _dependencyId, _dependencyType)

  local dependencyType = _dependencyType

  local dependency
  if (dependencyType == "globalVariable") then
    dependency = _G[dependencyPath]
  else
    dependency = require(dependencyPath)
  end


  if (dependencyType == "globalVariable") then
    dependencyType = "table"  -- TODO: need value parameter here too
  end

  local dependencyMock = self:createMock(_dependency, _dependencyId .. "Mock", dependencyType)

  if (dependencyType == "object") then

    setmetatable(dependencyMock, {

                   -- Make object instantiation work
                   __call = function(...)
                     return dependencyMock.__call(...)
                   end
    })

  end


  return dependencyMock

end
