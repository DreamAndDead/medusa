local l = list {_to_null(1, 2, 3, 4)}
assert(bool((l[_to_null(0)] == 1)))
assert(bool((l[_to_null(1)] == 2)))
assert(bool((l[_to_null(2)] == 3)))
assert(bool((l[_to_null(3)] == 4)))
assert(bool((l[_to_null((-4))] == 1)))
assert(bool((l[_to_null((-3))] == 2)))
assert(bool((l[_to_null((-2))] == 3)))
assert(bool((l[_to_null((-1))] == 4)))
local d = dict {[_to_null(1)] = _to_null(1), [_to_null(2)] = _to_null("b"), [_to_null(3)] = _to_null("c")}
assert(bool((d[_to_null(1)] == 1)))
assert(bool((d[_to_null(2)] == "b")))
assert(bool((d[_to_null(3)] == "c")))
l = list {_to_null(1, 2, 3, 4)}
local s = slice(merge_kwargs({}, {}), 0, 2)
local sl = l[_to_null(s)]
assert(bool((len(merge_kwargs({}, {}), sl) == 2)))
assert(bool((sl[_to_null(0)] == 1)))
assert(bool((sl[_to_null(1)] == 2)))
l = list {_to_null(1, 2, 3, 4)}
s = slice(merge_kwargs({}, {}), 3)
sl = l[_to_null(s)]
assert(bool((len(merge_kwargs({}, {}), sl) == 3)))
assert(bool((sl[_to_null(0)] == 1)))
assert(bool((sl[_to_null(1)] == 2)))
assert(bool((sl[_to_null(2)] == 3)))
l = list {_to_null(1, 2, 3, 4)}
sl = l[slice(0, 3, nil)]
assert(bool((len(merge_kwargs({}, {}), sl) == 3)))
assert(bool((sl[_to_null(0)] == 1)))
assert(bool((sl[_to_null(1)] == 2)))
assert(bool((sl[_to_null(2)] == 3)))
l = list {_to_null(1, 2, 3, 4)}
sl = l[slice(0, (-1), nil)]
assert(bool((len(merge_kwargs({}, {}), sl) == 3)))
assert(bool((sl[_to_null(0)] == 1)))
assert(bool((sl[_to_null(1)] == 2)))
assert(bool((sl[_to_null(2)] == 3)))
l = list {_to_null(1, 2, 3, 4)}
sl = l[slice(0, nil, nil)]
assert(bool((len(merge_kwargs({}, {}), sl) == 4)))
assert(bool((sl[_to_null(0)] == 1)))
assert(bool((sl[_to_null(1)] == 2)))
assert(bool((sl[_to_null(2)] == 3)))
assert(bool((sl[_to_null(3)] == 4)))
l = list {_to_null(1, 2, 3, 4)}
sl = l[slice(nil, 4, nil)]
assert(bool((len(merge_kwargs({}, {}), sl) == 4)))
assert(bool((sl[_to_null(0)] == 1)))
assert(bool((sl[_to_null(1)] == 2)))
assert(bool((sl[_to_null(2)] == 3)))
assert(bool((sl[_to_null(3)] == 4)))
return {
    l = l,
    d = d,
    s = s,
    sl = sl,
}
