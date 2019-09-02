dofile('./pythonlua/luainit.lua')

local foo = 42
local function bar()
    foo = 34
end
print("foo = ", foo)
bar()
print("foo = ", foo)