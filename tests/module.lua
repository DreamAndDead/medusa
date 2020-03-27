local module_2 = require("module_2")
local name = "module"
local function func(kvs, n)
    n = get_posarg(kvs, 'n', n, nil, 'func')
    return (math.pow(n, 1))
end
local function func_2(kvs, n)
    n = get_posarg(kvs, 'n', n, nil, 'func_2')
    return (2 * (math.pow(n, 1)))
end
local Module = class(function(Module)
    local function __init__(kvs, self, name)
        self = get_posarg(kvs, 'self', self, nil, '__init__')
        name = get_posarg(kvs, 'name', name, nil, '__init__')
        self.name = name
    end
    Module.__init__ = __init__
    return Module
end, {}, "Module")
local count = 0
local function incr(kvs)
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
