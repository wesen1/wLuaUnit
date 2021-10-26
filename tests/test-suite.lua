---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

-- Add the wLuaUnit src directory to package.path
package.path = package.path .. ";../src/?.lua"

-- Add the repository root directory to package.path
package.path = package.path .. ";../?.lua"

require "pl.compat"

local luaunit = require "luaunit"
luaunit.TABLE_EQUALS_KEYBYCONTENT = false


TestLuaUnit = require "tests.wLuaUnit.TestFramework.TestLuaUnit"

--require "tests.wLuaUnit.TestTestCase"

os.exit(luaunit.LuaUnit.run())
