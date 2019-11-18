# Lambda 表达式

## anonymous function
inc = lambda x: x + 1

i = 0
assert inc(i) == 1
assert inc(inc(i)) == 2


## multi parameters
add = lambda x, y: x + y

assert add(10, 20) == 30
assert add(10, add(-10, 5)) == 5


## parameter default
dec = lambda x, n = 1: x - n

assert dec(1) == 0
assert dec(10, 2) == 8
assert dec(dec(10, 2)) == 7


## vararg
itself = lambda n, *rest: rest

t = 0
l = [ 1, 2, 3, 4 ]
for i in itself(*l):
    t += i

assert t == 9


## TODO
## 不支持键值参数

