local l = list {_to_null(1, 2)}
assert(bool((l.count(1) == 1)))
local T = class(function(T)
    local function __init__(self)
        self.name = "T"
    end
    T.__init__ = __init__
    return T
end, {}, "T")
local t = T()
assert(bool((t.name == "T")))
t.name = "New"
assert(bool((t.name == "New")))
return {
    l = l,
    T = T,
    t = t,
}
