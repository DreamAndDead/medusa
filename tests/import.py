# import

## import
import module

assert module.name == 'module'
assert module.func(10) == 10
assert module.func_2(10) == 20
assert module.Module('first').name == 'first'
assert module.module_2.func(10) == 100
assert module.module_2.func_2(10) == 200


## import as
import module as new_module

assert new_module.func(10) == 10
assert new_module.func_2(10) == 20


## import and import as
import module, module_2 as new_module_2

assert module.func(10) == 10
assert module.func_2(10) == 20

assert new_module_2.func(10) == 100
assert new_module_2.func_2(10) == 200

## multi import as
import module as new_module, module_2 as new_module_2

assert new_module.func(10) == 10
assert new_module.func_2(10) == 20

assert new_module_2.func(10) == 100
assert new_module_2.func_2(10) == 200


## from import
from module import func, func_2

assert func(10) == 10
assert func_2(10) == 20

## from import as
from module import func as new_func

assert new_func(10) == 10

## multi from import as
from module import func, func_2 as new_func_2

assert func(10) == 10
assert new_func_2(10) == 20

## multi from import as
from module import func as new_func, func_2 as new_func_2

assert new_func(10) == 10
assert new_func_2(10) == 20

