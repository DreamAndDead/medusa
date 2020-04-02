local inc = function(kvs, x) x = get_posarg(kvs, 'x', x, nil, 'lambda'); return (x + 1) end
local i = 0
assert(bool({}, (inc(merge_kwargs({}, {}), i) == 1)))
assert(bool({}, (inc(merge_kwargs({}, {}), inc(merge_kwargs({}, {}), i)) == 2)))
local add = function(kvs, x, y) x = get_posarg(kvs, 'x', x, nil, 'lambda'); y = get_posarg(kvs, 'y', y, nil, 'lambda'); return (x + y) end
assert(bool({}, (add(merge_kwargs({}, {}), 10, 20) == 30)))
assert(bool({}, (add(merge_kwargs({}, {}), 10, add(merge_kwargs({}, {}), (-10), 5)) == 5)))
local dec = function(kvs, x, n) x = get_posarg(kvs, 'x', x, nil, 'lambda'); n = get_posarg(kvs, 'n', n, 1, 'lambda'); return (x - n) end
assert(bool({}, (dec(merge_kwargs({}, {}), 1) == 0)))
assert(bool({}, (dec(merge_kwargs({}, {}), 10, 2) == 8)))
assert(bool({}, (dec(merge_kwargs({}, {}), dec(merge_kwargs({}, {}), 10, 2)) == 7)))
local itself = function(kvs, n, ...) n = get_posarg(kvs, 'n', n, nil, 'lambda'); local rest = list({}, {...}); return rest end
local t = 0
local l = list({}, {_to_null(1, 2, 3, 4)})
for _, i in itself(merge_kwargs({}, {}), unpack(l)) do
    t = (t + i)
    ::loop_label_1::
end
assert(bool({}, (t == 9)))
local func = function(kvs, a, b, ...) a = get_posarg(kvs, 'a', a, nil, 'lambda'); b = get_posarg(kvs, 'b', b, 1, 'lambda'); local c = list({}, {...}); local d = get_kwonlyarg(kvs, 'd', 2, 'lambda'); local e = get_kwonlyarg(kvs, 'e', nil, 'lambda'); local f = get_kwargs(kvs, {a = true, b = true, d = true, e = true}); return ((((((a + b) + c[_to_null(0)]) + d) + e) + f[_to_null("c")]) + f[_to_null("f")]) end
assert(bool({}, (func(merge_kwargs({d = 3, e = 4, c = 10, f = 20}, {}), 0, 1, 2, 3, 4) == 40)))
return {
    inc = inc,
    i = i,
    add = add,
    dec = dec,
    itself = itself,
    t = t,
    l = l,
    func = func,
}
