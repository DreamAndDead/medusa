local a = set {_to_null(0, 1, 2, 3)}
local b = (function() local result = set {} for _, i in a do result.add((i + 1)) end return result end)()
assert(bool({}, (operator_in(1, b))))
assert(bool({}, (operator_in(2, b))))
assert(bool({}, (operator_in(3, b))))
assert(bool({}, (operator_in(4, b))))
a = set {_to_null(0, 1, 2, 3)}
b = (function() local result = set {} for _, i in a do result.add(bool({}, ((math.fmod(i, 2)) == 1)) and i or 0) end return result end)()
assert(bool({}, (len(merge_kwargs({}, {}), b) == 3)))
assert(bool({}, (operator_in(0, b))))
assert(bool({}, (operator_in(1, b))))
assert(bool({}, (operator_in(3, b))))
a = set {_to_null(0, 1, 2, 3)}
b = (function() local result = set {} for _, i in a do if bool({}, ((math.fmod(i, 2)) == 1)) then result.add(i) end end return result end)()
assert(bool({}, (len(merge_kwargs({}, {}), b) == 2)))
assert(bool({}, (operator_in(1, b))))
assert(bool({}, (operator_in(3, b))))
a = set {_to_null(0, 1)}
b = set {_to_null(10, 11)}
local c = (function() local result = set {} for _, m in a do for _, n in b do result.add((n - m)) end end return result end)()
assert(bool({}, (len(merge_kwargs({}, {}), c) == 3)))
assert(bool({}, (operator_in(9, c))))
assert(bool({}, (operator_in(10, c))))
assert(bool({}, (operator_in(11, c))))
a = list({}, {_to_null(set {_to_null(0, 1)}, set {_to_null(2, 3)})})
b = (function() local result = set {} for _, i in a do for _, j in i do result.add(j) end end return result end)()
assert(bool({}, (len(merge_kwargs({}, {}), b) == 4)))
assert(bool({}, (operator_in(0, b))))
assert(bool({}, (operator_in(1, b))))
assert(bool({}, (operator_in(2, b))))
assert(bool({}, (operator_in(3, b))))
a = list({}, {_to_null(set {_to_null(0, 1, 2)}, set {_to_null(0, 1)}, set {_to_null(0)})})
b = (function() local result = set {} for _, i in a do if bool({}, (len(merge_kwargs({}, {}), i) == 2)) then for _, j in i do if bool({}, (j == 0)) then result.add(j) end end end end return result end)()
assert(bool({}, (len(merge_kwargs({}, {}), b) == 1)))
assert(bool({}, (operator_in(0, b))))
c = (function() local result = set {} for _, i in a do if bool({}, (len(merge_kwargs({}, {}), i) == 2)) then for _, j in i do if bool({}, (j == 0)) then result.add(bool({}, (j == 1)) and j or 10) end end end end return result end)()
assert(bool({}, (len(merge_kwargs({}, {}), c) == 1)))
assert(bool({}, (operator_in(10, c))))
return {
    a = a,
    b = b,
    c = c,
}
