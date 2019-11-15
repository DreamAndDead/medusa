dofile('./polyfill/pypolyfill.lua')
local function count()
    for _, i in range(10) do
        coroutine.yield(i)
    end
end
count = meta_generator(count)
local c = count()
assert((next(c) == 0))
assert((next(c) == 1))
assert((next(c) == 2))
local function echo()
    local start = nil
    while true do
        local line = coroutine.yield(start)
        start = line
    end
end
echo = meta_generator(echo)
local e = echo()
assert((next(e) == nil))
assert((e.send(10) == 10))
