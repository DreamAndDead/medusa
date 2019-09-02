dofile('./pythonlua/luainit.lua')

local function foo()

end
local function varargs(name, ...)
    local args = list {...}
    print("Name is: ", name)
    print(unpack(args))
end
varargs("first", 1, 3, 6, 4, 7)
varargs("second", "hello", "python", "world")