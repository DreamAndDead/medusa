local module = require("module")
assert(bool((module.name == "module")))
assert(bool((module.func(merge_kwargs({}, {}), 10) == 10)))
assert(bool((module.func_2(merge_kwargs({}, {}), 10) == 20)))
assert(bool((module.Module(merge_kwargs({}, {}), "first").name == "first")))
assert(bool((module.module_2.func(merge_kwargs({}, {}), 10) == 100)))
assert(bool((module.module_2.func_2(merge_kwargs({}, {}), 10) == 200)))
local new_module = require("module")
assert(bool((new_module.func(merge_kwargs({}, {}), 10) == 10)))
assert(bool((new_module.func_2(merge_kwargs({}, {}), 10) == 20)))
local module = require("module")
local new_module_2 = require("module_2")
assert(bool((module.func(merge_kwargs({}, {}), 10) == 10)))
assert(bool((module.func_2(merge_kwargs({}, {}), 10) == 20)))
assert(bool((new_module_2.func(merge_kwargs({}, {}), 10) == 100)))
assert(bool((new_module_2.func_2(merge_kwargs({}, {}), 10) == 200)))
local new_module = require("module")
local new_module_2 = require("module_2")
assert(bool((new_module.func(merge_kwargs({}, {}), 10) == 10)))
assert(bool((new_module.func_2(merge_kwargs({}, {}), 10) == 20)))
assert(bool((new_module_2.func(merge_kwargs({}, {}), 10) == 100)))
assert(bool((new_module_2.func_2(merge_kwargs({}, {}), 10) == 200)))
local func = require("module").func
local func_2 = require("module").func_2
assert(bool((func(merge_kwargs({}, {}), 10) == 10)))
assert(bool((func_2(merge_kwargs({}, {}), 10) == 20)))
local new_func = require("module").func
assert(bool((new_func(merge_kwargs({}, {}), 10) == 10)))
local func = require("module").func
local new_func_2 = require("module").func_2
assert(bool((func(merge_kwargs({}, {}), 10) == 10)))
assert(bool((new_func_2(merge_kwargs({}, {}), 10) == 20)))
local new_func = require("module").func
local new_func_2 = require("module").func_2
assert(bool((new_func(merge_kwargs({}, {}), 10) == 10)))
assert(bool((new_func_2(merge_kwargs({}, {}), 10) == 20)))
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
