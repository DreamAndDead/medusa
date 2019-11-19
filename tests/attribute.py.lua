local l = list {_to_null(1, 2)}
assert((l.count(1) == 1))
local T = class(function(T)
    function T.__init__(self)
        self.name = "T"
    end
    return T
end, {}, "T")
local t = T()
assert((t.name == "T"))
t.name = "New"
assert((t.name == "New"))
