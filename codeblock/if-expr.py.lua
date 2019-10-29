dofile('./polyfill/pypolyfill.lua')
local a = true and 1 or 0
assert((a == 1))
a = false and 0 or 1
assert((a == 1))
