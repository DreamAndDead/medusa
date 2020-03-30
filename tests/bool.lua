local a = (1 and 2)
assert(bool({}, (a == 2)))
local b = (1 or 2)
assert(bool({}, (b == 1)))
local c = not bool(1)
assert(bool({}, (c == false)))
c = not bool(c)
assert(bool({}, (c == true)))
local d = ((1 and 2) or 3)
assert(bool({}, (d == 2)))
local e = (1 or (2 and 3))
assert(bool({}, (e == 1)))
return {
    a = a,
    b = b,
    c = c,
    d = d,
    e = e,
}
