local inc = function(kvs, x) return (x + 1) end
local i = 0
assert(bool({}, (inc(merge_kwargs({}, {}), i) == 1)))
assert(bool({}, (inc(merge_kwargs({}, {}), inc(merge_kwargs({}, {}), i)) == 2)))
local add = function(kvs, x, y) return (x + y) end
assert(bool({}, (add(merge_kwargs({}, {}), 10, 20) == 30)))
assert(bool({}, (add(merge_kwargs({}, {}), 10, add(merge_kwargs({}, {}), (-10), 5)) == 5)))
local dec = function(kvs, x, n) n = n or 1; return (x - n) end
assert(bool({}, (dec(merge_kwargs({}, {}), 1) == 0)))
assert(bool({}, (dec(merge_kwargs({}, {}), 10, 2) == 8)))
assert(bool({}, (dec(merge_kwargs({}, {}), dec(merge_kwargs({}, {}), 10, 2)) == 7)))
local itself = function(kvs, n, ...) local rest = list {...}; return rest end
local t = 0
local l = list({}, {_to_null(1, 2, 3, 4)})
for _, i in itself(merge_kwargs({}, {}), unpack(l)) do
    t = (t + i)
    ::loop_label_1::
end
assert(bool({}, (t == 9)))
return {
    inc = inc,
    i = i,
    add = add,
    dec = dec,
    itself = itself,
    t = t,
    l = l,
}
