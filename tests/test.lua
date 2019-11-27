--[[
def f(a, b):
    pass

def f(a, b=1):
    pass

def f(a, b=1, *c):
    pass
]]
--[[
def f(a, b=1, *c, e, f):
    pass
]]
local function f(a, b, ...)
    b = b or 1
    local c = list {...}
    return (((a + b) + e) + f)
end
assert(bool((f(1) == 6)))
--[[
def f(a, b=1, *c, e=2, f, **g):
    pass
]]
return {
    f = f,
}
