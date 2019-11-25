local module_2 = require("module_2")
local name = "module"
local function func(n)
    return (math.pow(n, 1))
end
local function func_2(n)
    return (2 * (math.pow(n, 1)))
end
local Module = class(function(Module)
    local function __init__(self, name)
        self.name = name
    end
    Module.__init__ = __init__
    return Module
end, {}, "Module")
local count = 0
local function incr()
    count = (count + 1)
    return count
end
return {
    module_2 = module_2,
    name = name,
    func = func,
    func_2 = func_2,
    Module = Module,
    count = count,
    incr = incr,
}
