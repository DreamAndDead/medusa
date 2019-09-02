dofile('./pythonlua/luainit.lua')

local i = 10
local j = 5
while (i > 0) do
    print(i)
    i = (i - 1)
    local test = 3434
    ::loop_label_8::
end
local test = 56
local function fact(n)
    return (n == 0) and 1 or (n * fact((n - 1)))
end
local Foo = class(function(Foo)
    function Foo.__init__(self)
        self.cls_var = 45
        local localvar = 56
    end
    return Foo
end, {})