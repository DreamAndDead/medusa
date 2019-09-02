dofile('./pythonlua/luainit.lua')

local a = list {1, 2, 3, 4}
local b = dict {["name"] = "John", ["age"] = 42}
local c = "Hello, world!"
if (2 < 3) then
    print("2 < 3")
end
print((operator_in(1, a)))
print((operator_in(2, a)))
print((operator_in(5, a)))
print((operator_in("name", b)))
print((operator_in("surname", b)))
print((operator_in("Hell", c)))
print((operator_in("world", c)))
print((operator_in("Foo", c)))
print((not operator_in("Hells", c)))