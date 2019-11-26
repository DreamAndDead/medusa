local d = dict {[_to_null(0)] = _to_null("a"), [_to_null(1)] = _to_null("b"), [_to_null("c")] = _to_null(3)}
local e = (function() local result = dict {} for _, k, v in d.items() do result[k] = v end return result end)()
local f = (function() local result = dict {} for _, k, v in d.items() do result[v] = k end return result end)()
assert(bool((d[_to_null(0)] == e[_to_null(0)])))
assert(bool((d[_to_null(1)] == e[_to_null(1)])))
assert(bool((d[_to_null("c")] == e[_to_null("c")])))
assert(bool((f[_to_null("a")] == 0)))
assert(bool((f[_to_null("b")] == 1)))
assert(bool((f[_to_null(3)] == "c")))
d = dict {[_to_null(0)] = _to_null(0), [_to_null(1)] = _to_null(1), [_to_null(2)] = _to_null(2)}
e = (function() local result = dict {} for _, k, v in d.items() do result[k] = bool(((math.fmod(k, 2)) == 1)) and v or 10 end return result end)()
assert(bool((e[_to_null(0)] == 10)))
assert(bool((e[_to_null(1)] == 1)))
assert(bool((e[_to_null(2)] == 10)))
f = (function() local result = dict {} for _, k, v in d.items() do result[bool((v == 0)) and k or (v + 1)] = bool(((math.fmod(k, 2)) == 1)) and v or 10 end return result end)()
assert(bool((f[_to_null(0)] == 10)))
assert(bool((f[_to_null(2)] == 1)))
assert(bool((f[_to_null(3)] == 10)))
d = dict {[_to_null(0)] = _to_null(0), [_to_null(1)] = _to_null(1), [_to_null(2)] = _to_null(2)}
e = (function() local result = dict {} for _, k, v in d.items() do if bool((k > 1)) then result[k] = v end end return result end)()
assert(bool((not operator_in(0, e))))
assert(bool((not operator_in(1, e))))
assert(bool((operator_in(2, e))))
assert(bool((e[_to_null(2)] == 2)))
local l = list {_to_null(0, 1, 2)}
local a = list {_to_null("a", "b")}
d = (function() local result = dict {} for _, k in l do for _, v in a do result[k] = v end end return result end)()
assert(bool((d[_to_null(0)] == "b")))
assert(bool((d[_to_null(1)] == "b")))
assert(bool((d[_to_null(2)] == "b")))
d = dict {[_to_null(0)] = _to_null(dict {[_to_null("a")] = _to_null(1), [_to_null("b")] = _to_null(2)}), [_to_null(1)] = _to_null(dict {[_to_null("c")] = _to_null(3), [_to_null("d")] = _to_null(4)})}
e = (function() local result = dict {} for _, k, v in d.items() do for _, nk, nv in v.items() do result[nk] = nv end end return result end)()
assert(bool((e[_to_null("a")] == 1)))
assert(bool((e[_to_null("b")] == 2)))
assert(bool((e[_to_null("c")] == 3)))
assert(bool((e[_to_null("d")] == 4)))
d = dict {[_to_null(0)] = _to_null(dict {[_to_null("a")] = _to_null(1), [_to_null("b")] = _to_null(2)}), [_to_null(1)] = _to_null(dict {[_to_null("c")] = _to_null(3), [_to_null("d")] = _to_null(4)})}
e = (function() local result = dict {} for _, k, v in d.items() do if bool(((math.fmod(k, 2)) == 0)) then for _, nk, nv in v.items() do if bool((nv > 1)) then result[nk] = bool(((math.fmod(nv, 2)) == 1)) and nv or (nv + 1) end end end end return result end)()
assert(bool((not operator_in("a", e))))
assert(bool((operator_in("b", e))))
assert(bool((e[_to_null("b")] == 3)))
assert(bool((not operator_in("c", e))))
assert(bool((not operator_in("d", e))))
return {
    d = d,
    e = e,
    f = f,
    l = l,
    a = a,
}
