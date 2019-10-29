dofile('./polyfill/pypolyfill.lua')
local a = list {0, 1, 2, 3}
local b = (function() local result = list {} for i in a do result.append((i + 1)) end return result end)()
assert(((a[0] + 1) == b[0]))
assert(((a[1] + 1) == b[1]))
assert(((a[2] + 1) == b[2]))
assert(((a[3] + 1) == b[3]))
a = list {0, 1, 2, 3}
b = (function() local result = list {} for i in a do result.append(((math.fmod(i, 2)) == 1) and i or 0) end return result end)()
assert((b[0] == 0))
assert((b[1] == 1))
assert((b[2] == 0))
assert((b[3] == 3))
a = list {0, 1, 2, 3}
b = (function() local result = list {} for i in a do if ((math.fmod(i, 2)) == 1) then result.append(i) end end return result end)()
assert((b[0] == 1))
assert((b[1] == 3))
a = list {0, 1}
b = list {10, 11}
local c = (function() local result = list {} for m in a do for n in b do result.append((n - m)) end end return result end)()
assert((c[0] == 10))
assert((c[1] == 11))
assert((c[2] == 9))
assert((c[3] == 10))
a = list {list {0, 1}, list {2, 3}}
b = (function() local result = list {} for i in a do for j in i do result.append(j) end end return result end)()
assert((b[0] == 0))
assert((b[1] == 1))
assert((b[2] == 2))
assert((b[3] == 3))
a = list {list {0, 1, 2}, list {0, 1}, list {0}}
b = (function() local result = list {} for i in a do if (len(i) == 2) then for j in i do if (j == 0) then result.append(j) end end end end return result end)()
assert((len(b) == 1))
assert((b[0] == 0))
c = (function() local result = list {} for i in a do if (len(i) == 2) then for j in i do if (j == 0) then result.append((j == 1) and j or 10) end end end end return result end)()
assert((len(c) == 1))
assert((c[0] == 10))
