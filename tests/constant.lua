local a = true
assert(a)
local b = false
assert(not b)
local c = nil
assert(not c)
return {
    a = a,
    b = b,
    c = c,
}
