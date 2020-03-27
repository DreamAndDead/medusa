local l = list {_to_null(1, 2)}
assert(bool((l.count(merge_kwargs({}, {}), 1) == 1)))
local T = class(function(T)
    local function __init__(kvs, self)
        self = get_posarg(kvs, 'self', self, nil, '__init__')
        self.name = "T"
    end
    T.__init__ = __init__
    return T
end, {}, "T")
local t = T(merge_kwargs({}, {}))
assert(bool((t.name == "T")))
t.name = "New"
assert(bool((t.name == "New")))
return {
    l = l,
    T = T,
    t = t,
}
