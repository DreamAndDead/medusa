dofile('./polyfill/pypolyfill.lua')
local a = (1 and 2)
assert((a == 2))
local b = (1 or 2)
assert((b == 1))
local c = not 1
assert((c == false))
c = not c
assert((c == true))
local d = ((1 and 2) or 3)
assert((d == 2))
local e = (1 or (2 and 3))
assert((e == 1))
