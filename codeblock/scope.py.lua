dofile('./polyfill/pypolyfill.lua')
local g = 10
local function outer()
    local o = 20
    assert((g == 10))
    local function inner()
        assert((g == 10))
        assert((o == 20))
    end
    inner()
end
outer()
