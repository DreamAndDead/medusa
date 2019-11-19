local function add(...)
    local a = list {...}
    local t = 0
    for _, i in a do
        t = (t + i)
    end
    return t
end
local p = list {_to_null(1, 2, 3, 4)}
assert((add(unpack(p)) == 10))
