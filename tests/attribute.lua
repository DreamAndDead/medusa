local T = class(function(T)
    local function __init__(kvs, self)
        self = get_posarg(kvs, 'self', self, nil, '__init__')
        self.name = "T"
    end
    T.__init__ = __init__
    return T
end, {}, "T")
local t = T(merge_kwargs({}, {}))
assert(bool({}, (t.name == "T")))
t.name = "New"
assert(bool({}, (t.name == "New")))
return {
    T = T,
    t = t,
}
