local function func(n)
    return (math.pow(n, 2))
end
local function func_2(n)
    return (2 * (math.pow(n, 2)))
end
return {
    func = func,
    func_2 = func_2,
}
