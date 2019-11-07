dofile('./polyfill/pypolyfill.lua')
assert((1 == 1))
assert((1 ~= 2))
assert((1 < 2))
assert((2 <= 2))
assert((2 > 1))
assert((2 >= 2))
local a = nil
assert((operator_is(a, nil)))
assert((operator_is(10, 10)))
assert((operator_is("str", "str")))
a = list {}
local b = a
local c = list {}
assert((operator_is(a, b)))
assert((not operator_is(a, c)))
assert((operator_in(1, set {1, 2, 3})))
assert((operator_in(2, set {1, 2, 3})))
assert((operator_in(3, set {1, 2, 3})))
assert((not operator_in(4, set {1, 2, 3})))
assert((not operator_in(5, set {1, 2, 3})))
assert((not operator_in(6, set {1, 2, 3})))
