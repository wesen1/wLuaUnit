---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require "classic"

local MockCreator = Object:extend()


function MockCreator:create(_valueBackupCollection)
end


---
-- Returns the mock for a object or class.
--
-- @tparam table _mockTarget The mock target (May be a require path, class or table)
-- @tparam string _mockName The name of the mock
-- @tparam string _mockType The mock type (Can be either "object" or "table")
--
-- @treturn table The mock of the object or class
--
function TestCase:createMock(_mockTarget, _mockName, _mockType)

  local mockTarget = self:findTarget(_mockTarget)

  if (_mockType == nil or _mockType == "object") then
    return self.mach.mock_object(mockTarget, _mockName)
  elseif (_mockType == "table") then
    return self.mach.mock_table(mockTarget, _mockName)
  end

end



function MockCreator:findTarget(_mockTarget)

  local mockTarget
  if (type(_mockTarget) == "string") then

    if (self.valueBackupCollection:hasBackupFor(_mockTarget)) then
      mockTarget = self.valueBackupCollection:getBackupFor(_mockTarget)
    else
      mockTarget = require(_mockTarget)
    end

  else
    mockTarget = _mockTarget
  end

  return mockTarget

end


return MockCreator
