local l = list {_to_null(1, 2)}
assert((l.count(1) == 1))
local T = class(function(T)
    local function __init__(self)
        self.name = "T"
    end
    T.__init__ = __init__
    return T
end, {}, "T")
local t = T()
assert((t.name == "T"))
t.name = "New"
assert((t.name == "New"))
return {
    l = l,
    T = T,
    t = t,
}
