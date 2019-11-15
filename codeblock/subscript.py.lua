dofile('./polyfill/pypolyfill.lua')
local l = list {_null(1, 2, 3, 4)}
assert((l[0] == 1))
assert((l[1] == 2))
assert((l[2] == 3))
assert((l[3] == 4))
assert((l[(-4)] == 1))
assert((l[(-3)] == 2))
assert((l[(-2)] == 3))
assert((l[(-1)] == 4))
local d = dict {[1] = 1, [2] = "b", [3] = "c"}
assert((d[1] == 1))
assert((d[2] == "b"))
assert((d[3] == "c"))
l = list {_null(1, 2, 3, 4)}
local s = slice(0, 2)
local sl = l[s]
assert((len(sl) == 2))
assert((sl[0] == 1))
assert((sl[1] == 2))
l = list {_null(1, 2, 3, 4)}
s = slice(3)
sl = l[s]
assert((len(sl) == 3))
assert((sl[0] == 1))
assert((sl[1] == 2))
assert((sl[2] == 3))
l = list {_null(1, 2, 3, 4)}
sl = l[slice(0, 3, nil)]
assert((len(sl) == 3))
assert((sl[0] == 1))
assert((sl[1] == 2))
assert((sl[2] == 3))
l = list {_null(1, 2, 3, 4)}
sl = l[slice(0, (-1), nil)]
assert((len(sl) == 3))
assert((sl[0] == 1))
assert((sl[1] == 2))
assert((sl[2] == 3))
l = list {_null(1, 2, 3, 4)}
sl = l[slice(0, nil, nil)]
assert((len(sl) == 4))
assert((sl[0] == 1))
assert((sl[1] == 2))
assert((sl[2] == 3))
assert((sl[3] == 4))
l = list {_null(1, 2, 3, 4)}
sl = l[slice(nil, 4, nil)]
assert((len(sl) == 4))
assert((sl[0] == 1))
assert((sl[1] == 2))
assert((sl[2] == 3))
assert((sl[3] == 4))
