---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local luaunit = require "luaunit"
local LuaUnit = require "TestFramework.LuaUnit"
local Object = require "classic"

local TestLuaUnit = Object:extend()


function TestLuaUnit:testCanExpectException()

  local exception = {
    message = "This is an exception"
  }
  local exceptionRaisingFunction = function ()
    error(exception)
  end


  local luaUnit = LuaUnit()

  local detectedException
  local success, raisedException = pcall(function()
      detectedException = luaUnit:expectException(exceptionRaisingFunction)
    end
  )

  print(raisedException)

  -- Exception should have been handled by the LuaUnit instance
  luaunit.assertEquals(success, true)
  luaunit.assertNil(raisedException)

  luaunit.assertEquals(detectedException, exception)

  -- TODO: Check with string exceptions as well

end


return TestLuaUnit
