local a = (1 + 2)
assert((a == 3))
a = (a - 4)
assert((a == (-1)))
a = (a * 10)
assert((a == (-10)))
a = (a / 4)
assert((a == (-2.5)))
local b = (math.floor(10 / 4))
assert((b == 2))
local m = (math.fmod(100, 3))
assert((m == 1))
local p = (math.pow(2, 10))
assert((p == 1024))
local n = (1 + 1)
assert((n == 2))
n = ((-1) - (-(-(-(-1)))))
assert((n == (-2)))
return {
    a = a,
    b = b,
    m = m,
    p = p,
    n = n,
}
