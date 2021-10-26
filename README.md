# wLuaUnit
wesen's Lua unit test framework



Note: Metamethods are not mocked, only __call will point to __call to make Object instantiation work.
However __index does still work as expected (inheritance stuff)
