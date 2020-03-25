local d = dict {[_to_null("a")] = _to_null(2)}
local function f(kvs, a)
    a = get_posarg(kvs, 'a', a, 1, 'f')
    return a
end
assert(bool((f(merge_kwargs({}, {}), 1) == 1)))
assert(bool((f(merge_kwargs({}, d)) == 2)))
return {
    d = d,
    f = f,
}
