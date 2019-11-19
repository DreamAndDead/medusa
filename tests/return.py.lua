local function null()
    return 
end
assert((null() == nil))
local function inspect(n)
    return n
end
assert((inspect(10) == 10))
local function inspect_more(m, n)
    return m, n
end
local a, b = inspect_more(10, 20)
assert((a == 10))
assert((b == 20))
