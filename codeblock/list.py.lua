dofile('./polyfill/pypolyfill.lua')
local l = list {_to_null(nil, 4, 3, nil, 2, 1, nil)}
assert((len(l) == 7))
assert((l[_to_null(0)] == nil))
assert((l[_to_null(1)] == 4))
assert((l[_to_null(2)] == 3))
assert((l[_to_null(3)] == nil))
assert((l[_to_null(4)] == 2))
assert((l[_to_null(5)] == 1))
assert((l[_to_null(6)] == nil))
l = list {_to_null(list {_to_null(0, 1, nil)}, list {_to_null(2, nil, 3)})}
assert((len(l) == 2))
assert((l[_to_null(0)][_to_null(0)] == 0))
assert((l[_to_null(0)][_to_null(1)] == 1))
assert((l[_to_null(0)][_to_null(2)] == nil))
assert((l[_to_null(1)][_to_null(0)] == 2))
assert((l[_to_null(1)][_to_null(1)] == nil))
assert((l[_to_null(1)][_to_null(2)] == 3))
l = list {_to_null(nil, 4, 3, nil, 2, 1, nil)}
local i = 0
for _, v in l do
    if (i == 0) then
        assert((v == nil))
    end
    if (i == 1) then
        assert((v == 4))
    end
    if (i == 2) then
        assert((v == 3))
    end
    if (i == 3) then
        assert((v == nil))
    end
    if (i == 4) then
        assert((v == 2))
    end
    if (i == 5) then
        assert((v == 1))
    end
    if (i == 6) then
        assert((v == nil))
    end
    i = (i + 1)
end
assert((i == 7))
l = list {_to_null(nil, 4, 3, 2, 1, nil)}
l.append(5)
assert((len(l) == 7))
assert((l[_to_null((-1))] == 5))
l.clear()
assert((len(l) == 0))
local l1 = list {_to_null(1, 2, 3, 4, nil)}
local l2 = l1.copy()
l2[_to_null(0)] = 0
l2.append(5)
assert((len(l1) == 5))
assert((len(l2) == 6))
assert((l1[_to_null(0)] == 1))
assert((l2[_to_null(0)] == 0))
l = list {_to_null(nil, 4, 3, 2, 4, nil, 2, 1, 0, 0, 0)}
assert((len(l) == 11))
assert((l.count(nil) == 2))
assert((l.count(4) == 2))
assert((l.count(3) == 1))
assert((l.count(2) == 2))
assert((l.count(1) == 1))
assert((l.count(0) == 3))
l = list {_to_null(nil, 4, 3, 2, 4, nil, 2, 1, 0, 0, 0)}
l.extend(list {_to_null(5, 6, 7)})
assert((len(l) == 14))
assert((l[_to_null((-1))] == 7))
assert((l[_to_null((-2))] == 6))
assert((l[_to_null((-3))] == 5))
l = list {_to_null(0, 1, 2, 3, 0, 1, 2, 3)}
assert((l.index(0) == 0))
assert((l.index(1) == 1))
assert((l.index(2) == 2))
assert((l.index(3) == 3))
assert((l.index(0, 0) == 0))
assert((l.index(0, 4) == 4))
assert((l.index(0, (-4)) == 4))
assert((l.index(0, 0, 4) == 0))
assert((l.index(0, (-8), 4) == 0))
assert((l.index(0, (-8), (-4)) == 0))
assert((l.index(0, 1, 5) == 4))
assert((l.index(0, (-7), 5) == 4))
assert((l.index(0, (-7), (-3)) == 4))
assert((l.index(0, (-20), 20) == 0))
l = list {_to_null(0)}
l.insert(0, (-1))
assert((l[_to_null(0)] == (-1)))
l.insert((-10), (-2))
assert((l[_to_null(0)] == (-2)))
l.insert(3, 1)
l.insert(10, 10)
assert((l[_to_null(3)] == 1))
assert((l[_to_null(4)] == 10))
l.insert((-1), nil)
assert((l[_to_null((-2))] == nil))
assert((l[_to_null((-1))] == 10))
l = list {_to_null(0, 1, nil, 2, 3, 4)}
local p = l.pop()
assert((len(l) == 5))
assert((l[_to_null((-1))] == 3))
assert((p == 4))
p = l.pop(0)
assert((l[_to_null(0)] == 1))
assert((p == 0))
p = l.pop((-2))
assert((l[_to_null((-1))] == 3))
assert((p == 2))
l = list {_to_null(0, nil, 1, 2, 3, 4, 0, nil)}
l.remove(0)
assert((len(l) == 7))
assert((l[_to_null(0)] == nil))
l.remove(0)
assert((len(l) == 6))
assert((l[_to_null((-1))] == nil))
l = list {_to_null(0, 1, 2, 3, nil, 4)}
l.reverse()
assert((len(l) == 6))
assert((l[_to_null(0)] == 4))
assert((l[_to_null(4)] == 1))
l = list {_to_null(4, 1, 2, 0, 3)}
l.sort()
assert((l[_to_null(0)] == 0))
assert((l[_to_null(1)] == 1))
assert((l[_to_null(2)] == 2))
assert((l[_to_null(3)] == 3))
assert((l[_to_null(4)] == 4))
