dofile('./polyfill/pypolyfill.lua')
local g = 10
local function outer()
    local e = 20
    local function inner()
        local l = 30
        assert((g == 10))
        assert((e == 20))
        assert((l == 30))
    end
    inner()
    assert((g == 10))
    assert((e == 20))
end
outer()
assert((g == 10))
g = 10
local o = class(function(o)
    o.e = 20
    o.i = class(function(i)
        i.l = 30
        assert((g == 10))
        assert((l == 30))
        return i
    end, {}, "i")
    assert((g == 10))
    assert((e == 20))
    return o
end, {}, "o")
assert((g == 10))
g = 10
local l = function(e) return function(l) return ((g + e) + l) end end
assert((l(20)(30) == 60))
