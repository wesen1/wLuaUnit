---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local luaunit = require "luaunit"
local Object = require "classic"

---
-- Object representation of the luaunit library.
-- Also defines some custom luaunit methods.
--
-- @type LuaUnit
--
local LuaUnit = Object:extend()


---
-- Expects a function to raise an exception.
--
-- @tparam function _exceptionRaisingFunction The function that is expected to raise an exception
--
-- @treturn Exception The Exception that the function raised
--
function LuaUnit:expectException(_exceptionRaisingFunction)

  local success, exception = pcall(_exceptionRaisingFunction)

  self:assertFalse(success)
  self:assertNotNil(exception)

  return exception

end


---
-- Method that will be called when a table field is attempted to be accessed that was not found in self.
-- Checks if the parent class or luaunit have a field with the name and returns these values if one of
-- these have fields with the target field name.
--
-- @tparam string _fieldName The name of the table field
--
-- @treturn mixed|nil The value for the field
--
function LuaUnit:__index(_fieldName)

  -- Check LuaUnit class
  if (LuaUnit[_fieldName]) then
    return LuaUnit[_fieldName]
  end

  -- Check the parent class
  local parentClass = getmetatable(self).super
  if (parentClass[_fieldName]) then
    return parentClass[_fieldName]

  -- Check luaunit
  elseif (luaunit[_fieldName] ~= nil) then
    if (type(luaunit[_fieldName]) == "function") then

      local methodWrapper = MethodWrapper(luaunit[_fieldName])
      methodWrapper:ignoreSelfParameter(self)

      return methodWrapper

      --[[
      return function (...)

        local arguments = table.pack(...)
        if (arguments[1] == self) then
          -- The method was called with a ":", remove the TestCase instance from the argument list
          table.remove(arguments, 1)
        end

        luaunit[_fieldName](table.unpack(arguments))

      end
      --]]

    else
      return luaunit[_fieldName]
    end
  end

end


return LuaUnit
