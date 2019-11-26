local l = list {_to_null(nil, 4, 3, nil, 2, 1, nil)}
assert(bool((len(l) == 7)))
assert(bool((l[_to_null(0)] == nil)))
assert(bool((l[_to_null(1)] == 4)))
assert(bool((l[_to_null(2)] == 3)))
assert(bool((l[_to_null(3)] == nil)))
assert(bool((l[_to_null(4)] == 2)))
assert(bool((l[_to_null(5)] == 1)))
assert(bool((l[_to_null(6)] == nil)))
l = list {_to_null(list {_to_null(0, 1, nil)}, list {_to_null(2, nil, 3)})}
assert(bool((len(l) == 2)))
assert(bool((l[_to_null(0)][_to_null(0)] == 0)))
assert(bool((l[_to_null(0)][_to_null(1)] == 1)))
assert(bool((l[_to_null(0)][_to_null(2)] == nil)))
assert(bool((l[_to_null(1)][_to_null(0)] == 2)))
assert(bool((l[_to_null(1)][_to_null(1)] == nil)))
assert(bool((l[_to_null(1)][_to_null(2)] == 3)))
l = list {_to_null(nil, 4, 3, nil, 2, 1, nil)}
local i = 0
for _, v in l do
    if bool((i == 0)) then
        assert(bool((v == nil)))
    end
    if bool((i == 1)) then
        assert(bool((v == 4)))
    end
    if bool((i == 2)) then
        assert(bool((v == 3)))
    end
    if bool((i == 3)) then
        assert(bool((v == nil)))
    end
    if bool((i == 4)) then
        assert(bool((v == 2)))
    end
    if bool((i == 5)) then
        assert(bool((v == 1)))
    end
    if bool((i == 6)) then
        assert(bool((v == nil)))
    end
    i = (i + 1)
    ::loop_label_1::
end
assert(bool((i == 7)))
l = list {_to_null(nil, 4, 3, 2, 1, nil)}
l.append(5)
assert(bool((len(l) == 7)))
assert(bool((l[_to_null((-1))] == 5)))
l.clear()
assert(bool((len(l) == 0)))
local l1 = list {_to_null(1, 2, 3, 4, nil)}
local l2 = l1.copy()
l2[_to_null(0)] = 0
l2.append(5)
assert(bool((len(l1) == 5)))
assert(bool((len(l2) == 6)))
assert(bool((l1[_to_null(0)] == 1)))
assert(bool((l2[_to_null(0)] == 0)))
l = list {_to_null(nil, 4, 3, 2, 4, nil, 2, 1, 0, 0, 0)}
assert(bool((len(l) == 11)))
assert(bool((l.count(nil) == 2)))
assert(bool((l.count(4) == 2)))
assert(bool((l.count(3) == 1)))
assert(bool((l.count(2) == 2)))
assert(bool((l.count(1) == 1)))
assert(bool((l.count(0) == 3)))
l = list {_to_null(nil, 4, 3, 2, 4, nil, 2, 1, 0, 0, 0)}
l.extend(list {_to_null(5, 6, 7)})
assert(bool((len(l) == 14)))
assert(bool((l[_to_null((-1))] == 7)))
assert(bool((l[_to_null((-2))] == 6)))
assert(bool((l[_to_null((-3))] == 5)))
l = list {_to_null(0, 1, 2, 3, 0, 1, 2, 3)}
assert(bool((l.index(0) == 0)))
assert(bool((l.index(1) == 1)))
assert(bool((l.index(2) == 2)))
assert(bool((l.index(3) == 3)))
assert(bool((l.index(0, 0) == 0)))
assert(bool((l.index(0, 4) == 4)))
assert(bool((l.index(0, (-4)) == 4)))
assert(bool((l.index(0, 0, 4) == 0)))
assert(bool((l.index(0, (-8), 4) == 0)))
assert(bool((l.index(0, (-8), (-4)) == 0)))
assert(bool((l.index(0, 1, 5) == 4)))
assert(bool((l.index(0, (-7), 5) == 4)))
assert(bool((l.index(0, (-7), (-3)) == 4)))
assert(bool((l.index(0, (-20), 20) == 0)))
l = list {_to_null(0)}
l.insert(0, (-1))
assert(bool((l[_to_null(0)] == (-1))))
l.insert((-10), (-2))
assert(bool((l[_to_null(0)] == (-2))))
l.insert(3, 1)
l.insert(10, 10)
assert(bool((l[_to_null(3)] == 1)))
assert(bool((l[_to_null(4)] == 10)))
l.insert((-1), nil)
assert(bool((l[_to_null((-2))] == nil)))
assert(bool((l[_to_null((-1))] == 10)))
l = list {_to_null(0, 1, nil, 2, 3, 4)}
local p = l.pop()
assert(bool((len(l) == 5)))
assert(bool((l[_to_null((-1))] == 3)))
assert(bool((p == 4)))
p = l.pop(0)
assert(bool((l[_to_null(0)] == 1)))
assert(bool((p == 0)))
p = l.pop((-2))
assert(bool((l[_to_null((-1))] == 3)))
assert(bool((p == 2)))
l = list {_to_null(0, nil, 1, 2, 3, 4, 0, nil)}
l.remove(0)
assert(bool((len(l) == 7)))
assert(bool((l[_to_null(0)] == nil)))
l.remove(0)
assert(bool((len(l) == 6)))
assert(bool((l[_to_null((-1))] == nil)))
l = list {_to_null(0, 1, 2, 3, nil, 4)}
l.reverse()
assert(bool((len(l) == 6)))
assert(bool((l[_to_null(0)] == 4)))
assert(bool((l[_to_null(4)] == 1)))
l = list {_to_null(4, 1, 2, 0, 3)}
l.sort()
assert(bool((l[_to_null(0)] == 0)))
assert(bool((l[_to_null(1)] == 1)))
assert(bool((l[_to_null(2)] == 2)))
assert(bool((l[_to_null(3)] == 3)))
assert(bool((l[_to_null(4)] == 4)))
l = list {_to_null(4, 1, 2, 0, 3)}
assert(bool((operator_in(0, l))))
assert(bool((not operator_in(5, l))))
l1 = list {_to_null(4, 1, 2, 0, 3)}
l2 = list {_to_null(4, 1, 2, 0, 3)}
l = (l1 + l2)
assert(bool((len(l) == 10)))
assert(bool((l[_to_null(0)] == 4)))
assert(bool((l[_to_null(1)] == 1)))
assert(bool((l[_to_null(2)] == 2)))
assert(bool((l[_to_null(3)] == 0)))
assert(bool((l[_to_null(4)] == 3)))
assert(bool((l[_to_null(5)] == 4)))
assert(bool((l[_to_null(6)] == 1)))
assert(bool((l[_to_null(7)] == 2)))
assert(bool((l[_to_null(8)] == 0)))
assert(bool((l[_to_null(9)] == 3)))
l1 = list {_to_null(4, 1, 2, 0, 3)}
l = (l1 * 2)
assert(bool((len(l) == 10)))
assert(bool((l[_to_null(0)] == 4)))
assert(bool((l[_to_null(1)] == 1)))
assert(bool((l[_to_null(2)] == 2)))
assert(bool((l[_to_null(3)] == 0)))
assert(bool((l[_to_null(4)] == 3)))
assert(bool((l[_to_null(5)] == 4)))
assert(bool((l[_to_null(6)] == 1)))
assert(bool((l[_to_null(7)] == 2)))
assert(bool((l[_to_null(8)] == 0)))
assert(bool((l[_to_null(9)] == 3)))
l = list {_to_null(4, 1, 2, 0, 3)}
assert(bool((l[_to_null(0)] == 4)))
local ls = l[slice(1, 2, nil)]
assert(bool((len(ls) == 1)))
assert(bool((ls[_to_null(0)] == 1)))
local ls2 = l[slice(1, 5, 2)]
assert(bool((len(ls2) == 2)))
assert(bool((ls2[_to_null(0)] == 1)))
assert(bool((ls2[_to_null(1)] == 0)))
l = list {_to_null(4, 1, 2, 0, 3)}
assert(bool((l[_to_null(0)] == 4)))
l[_to_null(0)] = 2
assert(bool((l[_to_null(0)] == 2)))
l = list {_to_null(4, 1, 2, 0, 3)}
l[slice(1, 3, nil)] = list {_to_null(10, 11, 12)}
assert(bool((len(l) == 6)))
assert(bool((l[_to_null(0)] == 4)))
assert(bool((l[_to_null(1)] == 10)))
assert(bool((l[_to_null(2)] == 11)))
assert(bool((l[_to_null(3)] == 12)))
assert(bool((l[_to_null(4)] == 0)))
assert(bool((l[_to_null(5)] == 3)))
l = list {_to_null(4, 1, 2, 0, 3)}
l[slice(0, 5, 2)] = list {_to_null(10, 11, 12)}
assert(bool((len(l) == 5)))
assert(bool((l[_to_null(0)] == 10)))
assert(bool((l[_to_null(1)] == 1)))
assert(bool((l[_to_null(2)] == 11)))
assert(bool((l[_to_null(3)] == 0)))
assert(bool((l[_to_null(4)] == 12)))
l = list {_to_null(4, 1, 2, 0, 3)}
l[slice(1, 3, nil)] = nil
assert(bool((len(l) == 3)))
assert(bool((l[_to_null(0)] == 4)))
assert(bool((l[_to_null(1)] == 0)))
assert(bool((l[_to_null(2)] == 3)))
l = list {_to_null(4, 1, 2, 0, 3)}
l[slice(0, 5, 2)] = nil
assert(bool((len(l) == 2)))
assert(bool((l[_to_null(0)] == 1)))
assert(bool((l[_to_null(1)] == 0)))
return {
    l = l,
    i = i,
    l1 = l1,
    l2 = l2,
    p = p,
    ls = ls,
    ls2 = ls2,
}
