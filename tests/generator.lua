local a = list({}, {_to_null(0, 1, 2, 3)})
local b = coroutine_wrap(function() for _, i in a do coroutine.yield((i + 1)) end end)
local i = 0
for _, n in b do
    assert(bool({}, (n == (a[_to_null(i)] + 1))))
    i = (i + 1)
    ::loop_label_1::
end
a = list({}, {_to_null(0, 1, 2, 3)})
b = coroutine_wrap(function() for _, i in a do coroutine.yield(bool({}, ((math.fmod(i, 2)) == 1)) and i or 0) end end)
i = 0
for _, n in b do
    if bool({}, (i == 0)) then
        assert(bool({}, (n == 0)))
    end
    if bool({}, (i == 1)) then
        assert(bool({}, (n == 1)))
    end
    if bool({}, (i == 2)) then
        assert(bool({}, (n == 0)))
    end
    if bool({}, (i == 3)) then
        assert(bool({}, (n == 3)))
    end
    i = (i + 1)
    ::loop_label_2::
end
a = list({}, {_to_null(0, 1, 2, 3)})
b = coroutine_wrap(function() for _, i in a do if bool({}, ((math.fmod(i, 2)) == 1)) then coroutine.yield(i) end end end)
i = 0
for _, n in b do
    if bool({}, (i == 0)) then
        assert(bool({}, (n == 1)))
    end
    if bool({}, (i == 1)) then
        assert(bool({}, (n == 3)))
    end
    i = (i + 1)
    ::loop_label_3::
end
a = list({}, {_to_null(0, 1)})
b = list({}, {_to_null(10, 11)})
local c = coroutine_wrap(function() for _, m in a do for _, n in b do coroutine.yield((n - m)) end end end)
i = 0
for _, n in c do
    if bool({}, (i == 0)) then
        assert(bool({}, (n == 10)))
    end
    if bool({}, (i == 1)) then
        assert(bool({}, (n == 11)))
    end
    if bool({}, (i == 2)) then
        assert(bool({}, (n == 9)))
    end
    if bool({}, (i == 3)) then
        assert(bool({}, (n == 10)))
    end
    i = (i + 1)
    ::loop_label_4::
end
a = list({}, {_to_null(list({}, {_to_null(0, 1)}), list({}, {_to_null(2, 3)}))})
b = coroutine_wrap(function() for _, i in a do for _, j in i do coroutine.yield(j) end end end)
i = 0
for _, n in b do
    if bool({}, (i == 0)) then
        assert(bool({}, (n == 0)))
    end
    if bool({}, (i == 1)) then
        assert(bool({}, (n == 1)))
    end
    if bool({}, (i == 2)) then
        assert(bool({}, (n == 2)))
    end
    if bool({}, (i == 3)) then
        assert(bool({}, (n == 3)))
    end
    i = (i + 1)
    ::loop_label_5::
end
a = list({}, {_to_null(list({}, {_to_null(0, 1, 2)}), list({}, {_to_null(0, 1)}), list({}, {_to_null(0)}))})
b = coroutine_wrap(function() for _, i in a do if bool({}, (len(merge_kwargs({}, {}), i) == 2)) then for _, j in i do if bool({}, (j == 0)) then coroutine.yield(j) end end end end end)
i = 0
for _, n in b do
    if bool({}, (i == 0)) then
        assert(bool({}, (n == 0)))
    end
    i = (i + 1)
    ::loop_label_6::
end
assert(bool({}, (i == 1)))
c = coroutine_wrap(function() for _, i in a do if bool({}, (len(merge_kwargs({}, {}), i) == 2)) then for _, j in i do if bool({}, (j == 0)) then coroutine.yield(bool({}, (j == 1)) and j or 10) end end end end end)
i = 0
for _, n in c do
    if bool({}, (i == 0)) then
        assert(bool({}, (n == 10)))
    end
    i = (i + 1)
    ::loop_label_7::
end
assert(bool({}, (i == 1)))
return {
    a = a,
    b = b,
    i = i,
    c = c,
}
