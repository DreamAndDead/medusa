--[[
python LEGB rule
local, enclosure, global, builtin

only function, lambda, class, generator create a new scope
only function, lambda create enclosure scope

only assign, function, class, import create symbol
]]
local g = 10
local function func()
    local g = 20
    assert(bool((g == 20)))
end
func()
assert(bool((g == 10)))
g = 10
local l = function(g) return (g + 1) end
assert(bool((g == 10)))
assert(bool((l(1) == 2)))
assert(bool((g == 10)))
g = 10
local c = class(function(c)
    local g = 20
    assert(bool((g == 20)))
    c.g = g
    return c
end, {}, "c")
local o = c()
assert(bool((g == 10)))
g = 10
l = (function() local result = list {} for _, g in range(20) do result.append(g) end return result end)()
assert(bool((l[_to_null(19)] == 19)))
assert(bool((g == 10)))
g = 10
if bool(true) then
    g = 20
    assert(bool((g == 20)))
end
assert(bool((g == 20)))
if bool(false) then
    g = 30
    assert(bool((g == 30)))
else
    g = 40
    assert(bool((g == 40)))
end
assert(bool((g == 40)))
g = 10
for _, i in range(20) do
    g = 20
    ::loop_label_1::
end
assert(bool((g == 20)))
g = 10
while bool((g < 20)) do
    g = 20
    ::loop_label_2::
end
assert(bool((g == 20)))
g = 10
local function outer()
    local o = 20
    local function inner()
        local o = 30
    end
    inner()
    assert(bool((o == 20)))
    local g = 40
end
outer()
assert(bool((g == 10)))
g = 10
function outer()
    local o = 20
    local function inner()
        o = 30
    end
    inner()
    assert(bool((o == 30)))
end
outer()
return {
    g = g,
    func = func,
    l = l,
    c = c,
    o = o,
    outer = outer,
}
