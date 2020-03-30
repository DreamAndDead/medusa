local a = (1 + 2)
assert(bool({}, (a == 3)))
a = (a - 4)
assert(bool({}, (a == (-1))))
a = (a * 10)
assert(bool({}, (a == (-10))))
a = (a / 4)
assert(bool({}, (a == (-2.5))))
local b = (math.floor(10 / 4))
assert(bool({}, (b == 2)))
local m = (math.fmod(100, 3))
assert(bool({}, (m == 1)))
local p = (math.pow(2, 10))
assert(bool({}, (p == 1024)))
local n = (1 + 1)
assert(bool({}, (n == 2)))
n = ((-1) - (-(-(-(-1)))))
assert(bool({}, (n == (-2))))
return {
    a = a,
    b = b,
    m = m,
    p = p,
    n = n,
}
