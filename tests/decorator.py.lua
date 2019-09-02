dofile('./pythonlua/luainit.lua')

local function strong(old_fun)
    local function wrapper(...)
        local args = list {...}
        local s = (("<strong>" + old_fun(unpack(args))) + "</strong>")
        return s
    end
    return wrapper
end
local function italic(old_fun)
    local function wrapper(...)
        local args = list {...}
        local s = (("<em>" + old_fun(unpack(args))) + "</em>")
        return s
    end
    return wrapper
end
local function hello(name)
    return (("Hello, " + name) + "!")
end
hello = strong(hello)
hello = italic(hello)
print(hello("John"))