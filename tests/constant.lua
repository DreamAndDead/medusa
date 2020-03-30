local a = true
assert(bool({}, a))
local b = false
assert(bool({}, not bool(b)))
local c = nil
assert(bool({}, not bool(c)))
return {
    a = a,
    b = b,
    c = c,
}
