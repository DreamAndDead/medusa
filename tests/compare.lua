assert(bool({}, (1 == 1)))
assert(bool({}, (1 ~= 2)))
assert(bool({}, (1 < 2)))
assert(bool({}, (2 <= 2)))
assert(bool({}, (2 > 1)))
assert(bool({}, (2 >= 2)))
local a = nil
assert(bool({}, (operator_is(a, nil))))
assert(bool({}, (operator_is(10, 10))))
assert(bool({}, (operator_is("str", "str"))))
a = list({}, {_to_null()})
local b = a
local c = list({}, {_to_null()})
assert(bool({}, (operator_is(a, b))))
assert(bool({}, (not operator_is(a, c))))
assert(bool({}, (operator_in(1, set({}, {_to_null(1, 2, 3)})))))
assert(bool({}, (operator_in(2, set({}, {_to_null(1, 2, 3)})))))
assert(bool({}, (operator_in(3, set({}, {_to_null(1, 2, 3)})))))
assert(bool({}, (not operator_in(4, set({}, {_to_null(1, 2, 3)})))))
assert(bool({}, (not operator_in(5, set({}, {_to_null(1, 2, 3)})))))
assert(bool({}, (not operator_in(6, set({}, {_to_null(1, 2, 3)})))))
return {
    a = a,
    b = b,
    c = c,
}
