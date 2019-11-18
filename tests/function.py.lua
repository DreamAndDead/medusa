dofile('./polyfill/pypolyfill.lua')
local function mul(a, b)
    --[[simple multiplication]]
    return (a * b)
end
assert((mul(10, 2) == 20))
assert((mul((-2), 32) == (-64)))
local function sub(a, b)
    b = b or 2
    --[[minus function]]
    return (a - b)
end
assert((sub(10, 10) == 0))
assert((sub(10) == 8))
local function sum(first, second, ...)
    local more = list {...}
    --[[sum of the parameters]]
    local s = (first + second)
    for _, i in more do
        s = (s + i)
    end
    return s
end
assert((sum(1, 2) == 3))
assert((sum(1, 2, 3) == 6))
assert((sum(1, 2, 3, 4) == 10))
local function registerClickEvent(callback)
    --[[register a function as callback]]
    local event = dict {[_to_null("id")] = _to_null("click")}
    callback(event)
end
local function callback(event)
    --[[simple callback]]
    assert((event[_to_null("id")] == "click"))
end
registerClickEvent(callback)
local function plus_factory(plus_num)
    --[[plus factory]]
    local function plus_func(n)
        --[[plus function]]
        return (n + plus_num)
    end
    return plus_func
end
local plus_10 = plus_factory(10)
assert((plus_10(20) == 30))
assert((plus_10((-10)) == 0))
local function clamp_wrapper(func)
    --[[a clamp decorator]]
    local function wrapper(...)
        local params = list {...}
        local res = func(unpack(params))
        if (res < 0) then
            res = 0
        end
        return res
    end
    return wrapper
end
local function minus(a, b)
    b = b or 10
    return (a - b)
end
minus = clamp_wrapper(minus)
assert((minus(10, 1) == 9))
assert((minus(10, 20) == 0))
assert((minus(1) == 0))
local function clamp_wrapper_with(left, right)
    --[[a clamp decorator with left and right limit]]
    function clamp_wrapper(func)
        local function wrapper(...)
            local params = list {...}
            local res = func(unpack(params))
            if (res < left) then
                res = left
            elseif (res > right) then
                res = right
            end
            return res
        end
        return wrapper
    end
    return clamp_wrapper
end
function sum(...)
    local n = list {...}
    local t = 0
    for _, i in n do
        t = (t + i)
    end
    return t
end
sum = clamp_wrapper_with(1, 10)(sum)
assert((sum(1, 2, 3) == 6))
assert((sum((-1), (-2), (-3)) == 1))
assert((sum(4, 5, 6) == 10))
