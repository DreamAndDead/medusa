dofile('/home/manjaro/project/python-lua/pythonlua/luainit.lua')

print((10 + 20))
print((5 + 0.5))
print((10 - 20))
print((20 - 1.7))
print((3 * 0.5))
print((0.4 * 0.17))
print((5 / 2))
print((18.09 / 3))
print((math.floor(13 / 2)))
print((math.fmod(10, 3)))
print((math.fmod(109, 17)))
print((math.pow(2, 10)))
if true then
    print("true")
end
if not false then
    print("not false")
end
print((1 + 2))
print((2 - -10))
print((1 and 2 and 3))
print((1 or 2 or 3))
print(((1 and 2) or 3))
print((1 or (2 and 3)))
local a = 10
print(a)
local b = 20
local c = 20
print(b)
print(c)
local a, b = b, a
print(a)
print(b)
a = (a + 1)
print(a)
