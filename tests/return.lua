local function null(kvs)
    return 
end
assert(bool({}, (null(merge_kwargs({}, {})) == nil)))
local function inspect(kvs, n)
    n = get_posarg(kvs, 'n', n, nil, 'inspect')
    return n
end
assert(bool({}, (inspect(merge_kwargs({}, {}), 10) == 10)))
local function inspect_more(kvs, m, n)
    m = get_posarg(kvs, 'm', m, nil, 'inspect_more')
    n = get_posarg(kvs, 'n', n, nil, 'inspect_more')
    return m, n
end
local a, b = inspect_more(merge_kwargs({}, {}), 10, 20)
assert(bool({}, (a == 10)))
assert(bool({}, (b == 20)))
return {
    null = null,
    inspect = inspect,
    inspect_more = inspect_more,
    a, b = a, b,
}
