local function count(kvs)
    for _, i in range(merge_kwargs({}, {}), 10) do
        coroutine.yield(i)
        ::loop_label_1::
    end
end
count = meta_generator(count)
local c = count(merge_kwargs({}, {}))
assert(bool({}, (next(merge_kwargs({}, {}), c) == 0)))
assert(bool({}, (next(merge_kwargs({}, {}), c) == 1)))
assert(bool({}, (next(merge_kwargs({}, {}), c) == 2)))
local function echo(kvs)
    local start = nil
    while bool({}, true) do
        local line = coroutine.yield(start)
        start = line
        ::loop_label_2::
    end
end
echo = meta_generator(echo)
local e = echo(merge_kwargs({}, {}))
assert(bool({}, (next(merge_kwargs({}, {}), e) == nil)))
assert(bool({}, (e.send(merge_kwargs({}, {}), 10) == 10)))
return {
    count = count,
    c = c,
    echo = echo,
    e = e,
}
