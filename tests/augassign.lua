local a = 1
assert(bool({}, (a == 1)))
a = (a + 2)
assert(bool({}, (a == 3)))
a = (a - 4)
assert(bool({}, (a == (-1))))
a = (a * 5)
assert(bool({}, (a == (-5))))
a = (a / (-2))
assert(bool({}, (a == 2.5)))
local b = 2
assert(bool({}, (b == 2)))
b = (math.pow(b, 10))
assert(bool({}, (b == 1024)))
b = (mod_operator(b, 3))
assert(bool({}, (b == 1)))
return {
    a = a,
    b = b,
}
