dofile('./pythonlua/luainit.lua')

local a = 45
local b = 100
local a, b = b, a
local c = (a * b)
local d = (c / (1 + 1))
print(a)
print(b)
print(c)
print(d)