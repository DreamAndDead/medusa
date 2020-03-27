local function func(kvs, n)
    n = get_posarg(kvs, 'n', n, nil, 'func')
    return (math.pow(n, 2))
end
local function func_2(kvs, n)
    n = get_posarg(kvs, 'n', n, nil, 'func_2')
    return (2 * (math.pow(n, 2)))
end
return {
    func = func,
    func_2 = func_2,
}
