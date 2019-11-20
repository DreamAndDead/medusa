local module = require("module")
assert((module.name == "module"))
assert((module.func(10) == 10))
assert((module.func_2(10) == 20))
assert((module.Module("first").name == "first"))
assert((module.module_2.func(10) == 100))
assert((module.module_2.func_2(10) == 200))
local new_module = require("module")
assert((new_module.func(10) == 10))
assert((new_module.func_2(10) == 20))
local module = require("module")
local new_module_2 = require("module_2")
assert((module.func(10) == 10))
assert((module.func_2(10) == 20))
assert((new_module_2.func(10) == 100))
assert((new_module_2.func_2(10) == 200))
local new_module = require("module")
local new_module_2 = require("module_2")
assert((new_module.func(10) == 10))
assert((new_module.func_2(10) == 20))
assert((new_module_2.func(10) == 100))
assert((new_module_2.func_2(10) == 200))
local func = require("module").func
local func_2 = require("module").func_2
assert((func(10) == 10))
assert((func_2(10) == 20))
local new_func = require("module").func
assert((new_func(10) == 10))
local func = require("module").func
local new_func_2 = require("module").func_2
assert((func(10) == 10))
assert((new_func_2(10) == 20))
local new_func = require("module").func
local new_func_2 = require("module").func_2
assert((new_func(10) == 10))
assert((new_func_2(10) == 20))
return {
    module = module,
    new_module = new_module,
    module = module,
    new_module_2 = new_module_2,
    new_module = new_module,
    new_module_2 = new_module_2,
    func = func,
    func_2 = func_2,
    new_func = new_func,
    func = func,
    new_func_2 = new_func_2,
    new_func = new_func,
    new_func_2 = new_func_2,
}
