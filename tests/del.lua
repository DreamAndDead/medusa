local v = "exist"
assert(bool(v))
v = nil
return {
    v = v,
}
