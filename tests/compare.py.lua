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
a = list {_to_null()}
local b = a
local c = list {_to_null()}
assert((operator_is(a, b)))
assert((not operator_is(a, c)))
assert((operator_in(1, set {_to_null(1, 2, 3)})))
assert((operator_in(2, set {_to_null(1, 2, 3)})))
assert((operator_in(3, set {_to_null(1, 2, 3)})))
assert((not operator_in(4, set {_to_null(1, 2, 3)})))
assert((not operator_in(5, set {_to_null(1, 2, 3)})))
assert((not operator_in(6, set {_to_null(1, 2, 3)})))
