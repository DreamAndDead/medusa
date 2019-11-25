local function count()
    for _, i in range(10) do
        coroutine.yield(i)
        ::loop_label_1::
    end
end
count = meta_generator(count)
local c = count()
assert(bool((next(c) == 0)))
assert(bool((next(c) == 1)))
assert(bool((next(c) == 2)))
local function echo()
    local start = nil
    while bool(true) do
        local line = coroutine.yield(start)
        start = line
        ::loop_label_2::
    end
end
echo = meta_generator(echo)
local e = echo()
assert(bool((next(e) == nil)))
assert(bool((e.send(10) == 10)))
return {
    count = count,
    c = c,
    echo = echo,
    e = e,
}
