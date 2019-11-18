dofile('./polyfill/pypolyfill.lua')
local a = list {_to_null(0, 1, 2, 3)}
local b = (function() local result = list {} for _, i in a do result.append((i + 1)) end return result end)()
assert(((a[_to_null(0)] + 1) == b[_to_null(0)]))
assert(((a[_to_null(1)] + 1) == b[_to_null(1)]))
assert(((a[_to_null(2)] + 1) == b[_to_null(2)]))
assert(((a[_to_null(3)] + 1) == b[_to_null(3)]))
a = list {_to_null(0, 1, 2, 3)}
b = (function() local result = list {} for _, i in a do result.append(((math.fmod(i, 2)) == 1) and i or 0) end return result end)()
assert((b[_to_null(0)] == 0))
assert((b[_to_null(1)] == 1))
assert((b[_to_null(2)] == 0))
assert((b[_to_null(3)] == 3))
a = list {_to_null(0, 1, 2, 3)}
b = (function() local result = list {} for _, i in a do if ((math.fmod(i, 2)) == 1) then result.append(i) end end return result end)()
assert((b[_to_null(0)] == 1))
assert((b[_to_null(1)] == 3))
a = list {_to_null(0, 1)}
b = list {_to_null(10, 11)}
local c = (function() local result = list {} for _, m in a do for _, n in b do result.append((n - m)) end end return result end)()
assert((c[_to_null(0)] == 10))
assert((c[_to_null(1)] == 11))
assert((c[_to_null(2)] == 9))
assert((c[_to_null(3)] == 10))
a = list {_to_null(list {_to_null(0, 1)}, list {_to_null(2, 3)})}
b = (function() local result = list {} for _, i in a do for _, j in i do result.append(j) end end return result end)()
assert((b[_to_null(0)] == 0))
assert((b[_to_null(1)] == 1))
assert((b[_to_null(2)] == 2))
assert((b[_to_null(3)] == 3))
a = list {_to_null(list {_to_null(0, 1, 2)}, list {_to_null(0, 1)}, list {_to_null(0)})}
b = (function() local result = list {} for _, i in a do if (len(i) == 2) then for _, j in i do if (j == 0) then result.append(j) end end end end return result end)()
assert((len(b) == 1))
assert((b[_to_null(0)] == 0))
c = (function() local result = list {} for _, i in a do if (len(i) == 2) then for _, j in i do if (j == 0) then result.append((j == 1) and j or 10) end end end end return result end)()
assert((len(c) == 1))
assert((c[_to_null(0)] == 10))
