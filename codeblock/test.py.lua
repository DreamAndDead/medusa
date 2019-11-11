dofile('./polyfill/pypolyfill.lua')
local l = list {"a", "c", 1, 2, 3}
local sl = l[slice(0, nil, nil)]
