local v = "exist"
assert(v)
v = nil
return {
    v = v,
}
