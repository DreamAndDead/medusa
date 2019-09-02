dofile('./pythonlua/luainit.lua')

local function hello(name, age, nickname, ...)
    age = age or 20
    nickname = nickname or ""
    local args = list {...}
    print(((("Hello, my name is " + name) + " and I'm ") + str(age)))
    print(("My nickname is " + nickname))
end
hello("John", 12, "antikiller")
hello("Josh", 45)
hello("Jane")