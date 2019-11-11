dofile('./polyfill/pypolyfill.lua')
local l = list {"a", "c", 1, 2, nil}
assert((len(l) == 5))
