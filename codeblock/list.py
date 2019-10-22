# List 字面量

# 创建

l = [ 4, 3, 2, 1 ]

assert len(l) == 4
assert l[0] == 4
assert l[1] == 3
assert l[2] == 2
assert l[3] == 1

# 运算

## not support ==
#assert l == [ 4, 3, 2, 1 ]

## not support +
#l = l + [0]
#assert l[4] == 0


# 方法

## append

l.append(5)

assert len(l) == 5
assert l[-1] == 5


## clear

l.clear()

assert len(l) == 0


## copy

l1 = [ 1, 2, 3, 4 ]
l2 = l1.copy()

l2[0] = 0
l2.append(5)

assert len(l1) == 4
assert len(l2) == 5
assert l1[0] == 1
assert l2[0] == 0


## count

l = [ 4, 3, 2, 4, 2, 1, 0, 0, 0 ]

assert len(l) == 9
assert l.count(4) == 2
assert l.count(3) == 1
assert l.count(2) == 2
assert l.count(1) == 1
assert l.count(0) == 3


## extend

l.extend([5, 6, 7])

assert len(l) == 12
assert l[-1] == 7
assert l[-2] == 6
assert l[-3] == 5


## index

l = [ 0, 1, 2, 3, 0, 1, 2, 3 ]

assert l.index(0) == 0
assert l.index(1) == 1
assert l.index(2) == 2
assert l.index(3) == 3

assert l.index(0, 0) == 0
assert l.index(0, 4) == 4
assert l.index(0, -4) == 4

assert l.index(0, 0, 4) == 0
assert l.index(0, -8, 4) == 0
assert l.index(0, -8, -4) == 0

assert l.index(0, 1, 5) == 4
assert l.index(0, -7, 5) == 4
assert l.index(0, -7, -3) == 4

assert l.index(0, -20, 20) == 0


## insert

l = [ 0 ]
l.insert(0, -1)

assert l[0] == -1

l.insert(-10, -2)

assert l[0] == -2

l.insert(3, 1)
l.insert(10, 10)

assert l[3] == 1
assert l[4] == 10


## pop

l = [ 0, 1, 2, 3, 4 ]

p = l.pop()

assert len(l) == 4
assert l[-1] == 3
assert p == 4

p = l.pop(0)

assert l[0] == 1
assert p == 0

p = l.pop(-2)

assert l[-1] == 3
assert p == 2


## remove

l = [ 0, 1, 2, 3, 4, 0 ]

l.remove(0)

assert len(l) == 5
assert l[0] == 1

l.remove(0)

assert len(l) == 4
assert l[-1] == 4


## reverse

l = [ 0, 1, 2, 3, 4 ]

l.reverse()

assert len(l) == 5
assert l[0] == 4
assert l[4] == 0


## sort

l = [ 4, 1, 2, 0, 3 ]

l.sort()

assert l[0] == 0
assert l[4] == 4


