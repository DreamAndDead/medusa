dofile('./polyfill/pypolyfill.lua')
local a = list {_null(0, 1, 2, 3)}
local b = coroutine.wrap(function() for i in a do coroutine.yield((i + 1)) end end)
local i = 0
for _, n in b do
    assert((n == (a[i] + 1)))
    i = (i + 1)
end
a = list {_null(0, 1, 2, 3)}
b = coroutine.wrap(function() for i in a do coroutine.yield(((math.fmod(i, 2)) == 1) and i or 0) end end)
i = 0
for _, n in b do
    if (i == 0) then
        assert((n == 0))
    end
    if (i == 1) then
        assert((n == 1))
    end
    if (i == 2) then
        assert((n == 0))
    end
    if (i == 3) then
        assert((n == 3))
    end
    i = (i + 1)
end
a = list {_null(0, 1, 2, 3)}
b = coroutine.wrap(function() for i in a do if ((math.fmod(i, 2)) == 1) then coroutine.yield(i) end end end)
i = 0
for _, n in b do
    if (i == 0) then
        assert((n == 1))
    end
    if (i == 1) then
        assert((n == 3))
    end
    i = (i + 1)
end
a = list {_null(0, 1)}
b = list {_null(10, 11)}
local c = coroutine.wrap(function() for m in a do for n in b do coroutine.yield((n - m)) end end end)
i = 0
for _, n in c do
    if (i == 0) then
        assert((n == 10))
    end
    if (i == 1) then
        assert((n == 11))
    end
    if (i == 2) then
        assert((n == 9))
    end
    if (i == 3) then
        assert((n == 10))
    end
    i = (i + 1)
end
a = list {_null(list {_null(0, 1)}, list {_null(2, 3)})}
b = coroutine.wrap(function() for i in a do for j in i do coroutine.yield(j) end end end)
i = 0
for _, n in b do
    if (i == 0) then
        assert((n == 0))
    end
    if (i == 1) then
        assert((n == 1))
    end
    if (i == 2) then
        assert((n == 2))
    end
    if (i == 3) then
        assert((n == 3))
    end
    i = (i + 1)
end
a = list {_null(list {_null(0, 1, 2)}, list {_null(0, 1)}, list {_null(0)})}
b = coroutine.wrap(function() for i in a do if (len(i) == 2) then for j in i do if (j == 0) then coroutine.yield(j) end end end end end)
i = 0
for _, n in b do
    if (i == 0) then
        assert((n == 0))
    end
    i = (i + 1)
end
assert((i == 1))
c = coroutine.wrap(function() for i in a do if (len(i) == 2) then for j in i do if (j == 0) then coroutine.yield((j == 1) and j or 10) end end end end end)
i = 0
for _, n in c do
    if (i == 0) then
        assert((n == 10))
    end
    i = (i + 1)
end
assert((i == 1))
