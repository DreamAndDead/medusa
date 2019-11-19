local name = "module"
local function func(n)
    return (math.pow(n, 1))
end
local function func_2(n)
    return (2 * (math.pow(n, 1)))
end
local Module = class(function(Module)
    function Module.__init__(self, name)
        self.name = name
    end
    return Module
end, {}, "Module")
local count = 0
local function incr()
    count = (count + 1)
    return count
end
return {
    name = name,
    func = func,
    func_2 = func_2,
    Module = Module,
    count = count,
    incr = incr,
}
