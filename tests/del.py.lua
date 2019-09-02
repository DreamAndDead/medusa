dofile('./pythonlua/luainit.lua')

local a, b, c = 1, 2, 3
print(a, b, c)
a, b = nil, nil
print(a, b, c)
c = nil
print(a, b, c)