local a = 1
assert((a == 1))
local b = 1
local c = 1
assert((b == 1))
assert((c == 1))
local d, e = 2, 3
assert((d == 2))
assert((e == 3))
d, e = e, d
assert((d == 3))
assert((e == 2))
