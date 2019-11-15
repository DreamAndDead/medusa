dofile('./polyfill/pypolyfill.lua')
local l = list {_null("a", "c", 1, 2, nil)}
assert((len(l) == 5))
