local l = list {_to_null(1, 2, 3, 4)}
assert((l[_to_null(0)] == 1))
assert((l[_to_null(1)] == 2))
assert((l[_to_null(2)] == 3))
assert((l[_to_null(3)] == 4))
assert((l[_to_null((-4))] == 1))
assert((l[_to_null((-3))] == 2))
assert((l[_to_null((-2))] == 3))
assert((l[_to_null((-1))] == 4))
local d = dict {[_to_null(1)] = _to_null(1), [_to_null(2)] = _to_null("b"), [_to_null(3)] = _to_null("c")}
assert((d[_to_null(1)] == 1))
assert((d[_to_null(2)] == "b"))
assert((d[_to_null(3)] == "c"))
l = list {_to_null(1, 2, 3, 4)}
local s = slice(0, 2)
local sl = l[_to_null(s)]
assert((len(sl) == 2))
assert((sl[_to_null(0)] == 1))
assert((sl[_to_null(1)] == 2))
l = list {_to_null(1, 2, 3, 4)}
s = slice(3)
sl = l[_to_null(s)]
assert((len(sl) == 3))
assert((sl[_to_null(0)] == 1))
assert((sl[_to_null(1)] == 2))
assert((sl[_to_null(2)] == 3))
l = list {_to_null(1, 2, 3, 4)}
sl = l[slice(0, 3, nil)]
assert((len(sl) == 3))
assert((sl[_to_null(0)] == 1))
assert((sl[_to_null(1)] == 2))
assert((sl[_to_null(2)] == 3))
l = list {_to_null(1, 2, 3, 4)}
sl = l[slice(0, (-1), nil)]
assert((len(sl) == 3))
assert((sl[_to_null(0)] == 1))
assert((sl[_to_null(1)] == 2))
assert((sl[_to_null(2)] == 3))
l = list {_to_null(1, 2, 3, 4)}
sl = l[slice(0, nil, nil)]
assert((len(sl) == 4))
assert((sl[_to_null(0)] == 1))
assert((sl[_to_null(1)] == 2))
assert((sl[_to_null(2)] == 3))
assert((sl[_to_null(3)] == 4))
l = list {_to_null(1, 2, 3, 4)}
sl = l[slice(nil, 4, nil)]
assert((len(sl) == 4))
assert((sl[_to_null(0)] == 1))
assert((sl[_to_null(1)] == 2))
assert((sl[_to_null(2)] == 3))
assert((sl[_to_null(3)] == 4))
