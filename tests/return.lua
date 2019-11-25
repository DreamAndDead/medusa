local function null()
    return 
end
assert(bool((null() == nil)))
local function inspect(n)
    return n
end
assert(bool((inspect(10) == 10)))
local function inspect_more(m, n)
    return m, n
end
local a, b = inspect_more(10, 20)
assert(bool((a == 10)))
assert(bool((b == 20)))
return {
    null = null,
    inspect = inspect,
    inspect_more = inspect_more,
    a, b = a, b,
}
