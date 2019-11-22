# scopy 作用域

"""
python LEGB rule
local, enclosure, global, builtin

only function, lambda, class, generator create a new scope
only function, lambda create enclosure scope

only assign, function, class, import create symbol
"""


# scope

## function scope

g = 10

def func():
    g = 20
    assert g == 20

func()
assert g == 10


## lambda scope

g = 10

l = lambda g: g + 1

assert g == 10
assert l(1) == 2
assert g == 10


## class scope

g = 10

class c:
    g = 20
    assert g == 20

o = c()
assert g == 10


## generator scope

g = 10

l = [g for g in range(20)]

assert l[19] == 19
assert g == 10


# no scope

## if

g = 10

if True:
    g = 20
    assert g == 20

assert g == 20


if False:
    g = 30
    assert g == 30
else:
    g = 40
    assert g == 40

assert g == 40


## for

### FIXME
# g is considered as local var in for block in lua

#g = 10

#for g in range(20):
#    pass

#assert g == 19

g = 10

for i in range(20):
    g = 20

assert g == 20


## while

g = 10

while g < 20:
    g = 20

assert g == 20



## nonlocal
# only works for enclosure scope

g = 10

def outer():
    o = 20

    def inner():
        o = 30

    inner()
    assert o == 20

    g = 40

outer()

assert g == 10




g = 10

def outer():
    o = 20

    def inner():
        # nonlocal g is wrong, because g is in global not enclosure scope
        nonlocal o
        o = 30

    inner()
    assert o == 30

outer()




