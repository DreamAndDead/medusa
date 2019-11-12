dofile('./polyfill/pypolyfill.lua')
local a = set {0, 1, 2, 3}
local b = (function() local result = set {} for i in a do result.add((i + 1)) end return result end)()
assert((operator_in(1, b)))
assert((operator_in(2, b)))
assert((operator_in(3, b)))
assert((operator_in(4, b)))
a = set {0, 1, 2, 3}
b = (function() local result = set {} for i in a do result.add(((math.fmod(i, 2)) == 1) and i or 0) end return result end)()
assert((len(b) == 3))
assert((operator_in(0, b)))
assert((operator_in(1, b)))
assert((operator_in(3, b)))
a = set {0, 1, 2, 3}
b = (function() local result = set {} for i in a do if ((math.fmod(i, 2)) == 1) then result.add(i) end end return result end)()
assert((len(b) == 2))
assert((operator_in(1, b)))
assert((operator_in(3, b)))
a = set {0, 1}
b = set {10, 11}
local c = (function() local result = set {} for m in a do for n in b do result.add((n - m)) end end return result end)()
assert((len(c) == 3))
assert((operator_in(9, c)))
assert((operator_in(10, c)))
assert((operator_in(11, c)))
a = list {set {0, 1}, set {2, 3}}
b = (function() local result = set {} for i in a do for j in i do result.add(j) end end return result end)()
assert((len(b) == 4))
assert((operator_in(0, b)))
assert((operator_in(1, b)))
assert((operator_in(2, b)))
assert((operator_in(3, b)))
a = list {set {0, 1, 2}, set {0, 1}, set {0}}
b = (function() local result = set {} for i in a do if (len(i) == 2) then for j in i do if (j == 0) then result.add(j) end end end end return result end)()
assert((len(b) == 1))
assert((operator_in(0, b)))
c = (function() local result = set {} for i in a do if (len(i) == 2) then for j in i do if (j == 0) then result.add((j == 1) and j or 10) end end end end return result end)()
assert((len(c) == 1))
assert((operator_in(10, c)))