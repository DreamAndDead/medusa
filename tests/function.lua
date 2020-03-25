local function mul(kvs, a, b)
    a = get_posarg(kvs, 'a', a, nil, 'mul')
    b = get_posarg(kvs, 'b', b, nil, 'mul')
    --[[simple multiplication]]
    return (a * b)
end
assert(bool((mul(merge_kwargs({}, {}), 10, 2) == 20)))
assert(bool((mul(merge_kwargs({b = 10}, {}), 1) == 10)))
assert(bool((mul(merge_kwargs({a = 2, b = 4}, {})) == 8)))
assert(bool((mul(merge_kwargs({a = 3, b = 5}, {})) == 15)))
local function sub(kvs, a, b)
    a = get_posarg(kvs, 'a', a, nil, 'sub')
    b = get_posarg(kvs, 'b', b, 2, 'sub')
    --[[minus function]]
    return (a - b)
end
assert(bool((sub(merge_kwargs({}, {}), 10, 10) == 0)))
assert(bool((sub(merge_kwargs({}, {}), 10) == 8)))
assert(bool((sub(merge_kwargs({b = 8}, {}), 10) == 2)))
assert(bool((sub(merge_kwargs({a = 11, b = 3}, {})) == 8)))
assert(bool((sub(merge_kwargs({b = 11, a = 3}, {})) == (-8))))
local function sum(kvs, first, second, ...)
    first = get_posarg(kvs, 'first', first, nil, 'sum')
    second = get_posarg(kvs, 'second', second, nil, 'sum')
    local more = list {...}
    --[[sum of the parameters]]
    local s = (first + second)
    for _, i in more do
        s = (s + i)
        ::loop_label_1::
    end
    return s
end
assert(bool((sum(merge_kwargs({}, {}), 1, 2, 3, 4) == 10)))
assert(bool((sum(merge_kwargs({}, {}), 1, 2, 3) == 6)))
assert(bool((sum(merge_kwargs({}, {}), 1, 2) == 3)))
assert(bool((sum(merge_kwargs({second = 2}, {}), 1) == 3)))
assert(bool((sum(merge_kwargs({first = 1, second = 2}, {})) == 3)))
local function add(kvs, a, b, ...)
    a = get_posarg(kvs, 'a', a, nil, 'add')
    b = get_posarg(kvs, 'b', b, nil, 'add')
    local c = list {...}
    local d = get_kwonlyarg(kvs, 'd', nil, 'add')
    local e = get_kwonlyarg(kvs, 'e', nil, 'add')
    return (((a + b) + d) + e)
end
assert(bool((add(merge_kwargs({d = 1, e = 2}, {}), 1, 2, 3, 4) == 6)))
assert(bool((add(merge_kwargs({d = 1, e = 2}, {}), 1, 2) == 6)))
assert(bool((add(merge_kwargs({b = 2, d = 1, e = 2}, {}), 1) == 6)))
assert(bool((add(merge_kwargs({a = 1, b = 2, d = 1, e = 2}, {})) == 6)))
assert(bool((add(merge_kwargs({d = 1, e = 2, a = 1, b = 2}, {})) == 6)))
function add(kvs, a, b, ...)
    a = get_posarg(kvs, 'a', a, nil, 'add')
    b = get_posarg(kvs, 'b', b, nil, 'add')
    local c = list {...}
    local d = get_kwonlyarg(kvs, 'd', 0, 'add')
    local e = get_kwonlyarg(kvs, 'e', nil, 'add')
    return (((a + b) + d) + e)
end
assert(bool((add(merge_kwargs({d = 1, e = 2}, {}), 1, 2, 3, 4) == 6)))
assert(bool((add(merge_kwargs({e = 2}, {}), 1, 2, 3, 4) == 5)))
assert(bool((add(merge_kwargs({d = 1, e = 2}, {}), 1, 2) == 6)))
assert(bool((add(merge_kwargs({e = 2}, {}), 1, 2) == 5)))
assert(bool((add(merge_kwargs({b = 2, d = 1, e = 2}, {}), 1) == 6)))
assert(bool((add(merge_kwargs({b = 2, e = 2}, {}), 1) == 5)))
assert(bool((add(merge_kwargs({a = 1, b = 2, d = 1, e = 2}, {})) == 6)))
assert(bool((add(merge_kwargs({a = 1, b = 2, e = 2}, {})) == 5)))
assert(bool((add(merge_kwargs({d = 1, e = 2, a = 1, b = 2}, {})) == 6)))
assert(bool((add(merge_kwargs({e = 2, a = 1, b = 2}, {})) == 5)))
function add(kvs, a, b, ...)
    a = get_posarg(kvs, 'a', a, nil, 'add')
    b = get_posarg(kvs, 'b', b, nil, 'add')
    local c = list {...}
    local d = get_kwonlyarg(kvs, 'd', nil, 'add')
    local e = get_kwonlyarg(kvs, 'e', nil, 'add')
    local f = get_kwargs(kvs, {a = true, b = true, d = true, e = true})
    return (((((a + b) + d) + e) + f[_to_null("c")]) + f[_to_null("f")])
end
assert(bool((add(merge_kwargs({d = 1, e = 2, c = 3, f = 4}, {}), 1, 2, 3, 4) == 13)))
assert(bool((add(merge_kwargs({d = 1, e = 2, c = 3, f = 4}, {}), 1, 2) == 13)))
assert(bool((add(merge_kwargs({b = 2, d = 1, e = 2, c = 3, f = 4}, {}), 1) == 13)))
assert(bool((add(merge_kwargs({a = 1, b = 2, d = 1, e = 2, c = 3, f = 4}, {})) == 13)))
assert(bool((add(merge_kwargs({d = 1, e = 2, a = 1, b = 2, c = 3, f = 4}, {})) == 13)))
local function registerClickEvent(kvs, callback)
    callback = get_posarg(kvs, 'callback', callback, nil, 'registerClickEvent')
    --[[register a function as callback]]
    local event = dict {[_to_null("id")] = _to_null("click")}
    callback(merge_kwargs({}, {}), event)
end
local function callback(kvs, event)
    event = get_posarg(kvs, 'event', event, nil, 'callback')
    --[[simple callback]]
    assert(bool((event[_to_null("id")] == "click")))
end
registerClickEvent(merge_kwargs({}, {}), callback)
local function plus_factory(kvs, plus_num)
    plus_num = get_posarg(kvs, 'plus_num', plus_num, nil, 'plus_factory')
    --[[plus factory]]
    local function plus_func(kvs, n)
        n = get_posarg(kvs, 'n', n, nil, 'plus_func')
        --[[plus function]]
        return (n + plus_num)
    end
    return plus_func
end
local plus_10 = plus_factory(merge_kwargs({}, {}), 10)
assert(bool((plus_10(merge_kwargs({}, {}), 20) == 30)))
assert(bool((plus_10(merge_kwargs({}, {}), (-10)) == 0)))
local function clamp_wrapper(kvs, func)
    func = get_posarg(kvs, 'func', func, nil, 'clamp_wrapper')
    --[[a clamp decorator]]
    local function wrapper(kvs, ...)
        local args = list {...}
        local kwargs = get_kwargs(kvs, {})
        local res = func(merge_kwargs({}, kwargs), unpack(args))
        if bool((res < 0)) then
            res = 0
        end
        return res
    end
    return wrapper
end
local function minus(kvs, a, b, ...)
    a = get_posarg(kvs, 'a', a, nil, 'minus')
    b = get_posarg(kvs, 'b', b, 10, 'minus')
    local c = list {...}
    local d = get_kwonlyarg(kvs, 'd', 10, 'minus')
    local e = get_kwonlyarg(kvs, 'e', 1, 'minus')
    local f = get_kwargs(kvs, {a = true, b = true, d = true, e = true})
    return (a - d)
end
minus = clamp_wrapper({}, minus)
assert(bool((minus(merge_kwargs({}, {}), 10, 1) == 0)))
assert(bool((minus(merge_kwargs({}, {}), 10, 20) == 0)))
assert(bool((minus(merge_kwargs({}, {}), 1) == 0)))
assert(bool((minus(merge_kwargs({d = 0}, {}), 1) == 1)))
local function clamp_wrapper_with(kvs, left, right)
    left = get_posarg(kvs, 'left', left, nil, 'clamp_wrapper_with')
    right = get_posarg(kvs, 'right', right, nil, 'clamp_wrapper_with')
    --[[a clamp decorator with left and right limit]]
    local function clamp_wrapper(kvs, func)
        func = get_posarg(kvs, 'func', func, nil, 'clamp_wrapper')
        local function wrapper(kvs, ...)
            local args = list {...}
            local kwargs = get_kwargs(kvs, {})
            local res = func(merge_kwargs({}, kwargs), unpack(args))
            if bool((res < left)) then
                res = left
            elseif bool((res > right)) then
                res = right
            end
            return res
        end
        return wrapper
    end
    return clamp_wrapper
end
function sum(kvs, a, b, ...)
    a = get_posarg(kvs, 'a', a, nil, 'sum')
    b = get_posarg(kvs, 'b', b, nil, 'sum')
    local c = list {...}
    local d = get_kwonlyarg(kvs, 'd', nil, 'sum')
    local e = get_kwonlyarg(kvs, 'e', nil, 'sum')
    local f = get_kwargs(kvs, {a = true, b = true, d = true, e = true})
    local t = 0
    for _, i in c do
        t = (t + i)
        ::loop_label_2::
    end
    return ((((t + a) + b) + d) + e)
end
sum = clamp_wrapper_with(merge_kwargs({}, {}), 1, 10)({}, sum)
assert(bool((sum(merge_kwargs({d = 4, e = 5}, {}), 1, 2, 3) == 10)))
assert(bool((sum(merge_kwargs({d = (-3), e = (-4)}, {}), (-1), (-2)) == 1)))
assert(bool((sum(merge_kwargs({a = 1, b = (-1), c = 0, d = 1, e = (-10)}, {})) == 1)))
return {
    mul = mul,
    sub = sub,
    sum = sum,
    add = add,
    registerClickEvent = registerClickEvent,
    callback = callback,
    plus_factory = plus_factory,
    plus_10 = plus_10,
    clamp_wrapper = clamp_wrapper,
    minus = minus,
    clamp_wrapper_with = clamp_wrapper_with,
}
