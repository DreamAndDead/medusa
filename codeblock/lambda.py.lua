dofile('./polyfill/pypolyfill.lua')
local inc = function(x) return (x + 1) end
local i = 0
assert((inc(i) == 1))
assert((inc(inc(i)) == 2))
local add = function(x, y) return (x + y) end
assert((add(10, 20) == 30))
assert((add(10, add((-10), 5)) == 5))
local dec = function(x, n) n = n or 1; return (x - n) end
assert((dec(1) == 0))
assert((dec(10, 2) == 8))
assert((dec(dec(10, 2)) == 7))
local itself = function(n, ...) local rest = list {...}; return rest end
local t = 0
local l = list {_to_null(1, 2, 3, 4)}
for _, i in itself(unpack(l)) do
    t = (t + i)
end
assert((t == 9))
