dofile('./pythonlua/luainit.lua')

local a = 45
a = -a
local b = a
local c = bit32.bnot(a)
local test = true
local nt = not test
print(a, b, c)
print(test, nt)