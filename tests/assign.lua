local a = 1
assert(bool((a == 1)))
local b = 1
local c = 1
assert(bool((b == 1)))
assert(bool((c == 1)))
local d, e = 2, 3
assert(bool((d == 2)))
assert(bool((e == 3)))
d, e = e, d
assert(bool((d == 3)))
assert(bool((e == 2)))
return {
    a = a,
    b = b,
    c = c,
    d, e = d, e,
}
