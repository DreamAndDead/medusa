# List 字面量

# 创建

l = [ None, 4, 3, None, 2, 1, None]

assert len(l) == 7
assert l[0] == None
assert l[1] == 4
assert l[2] == 3
assert l[3] == None
assert l[4] == 2
assert l[5] == 1
assert l[6] == None

## nested

l = [
        [0, 1, None],
        [2, None, 3]
    ]

assert len(l) == 2
assert l[0][0] == 0
assert l[0][1] == 1
assert l[0][2] == None
assert l[1][0] == 2
assert l[1][1] == None
assert l[1][2] == 3


# iterator

l = [ None, 4, 3, None, 2, 1, None]

i = 0
for v in l:
    if i == 0:
        assert v == None
    if i == 1:
        assert v == 4
    if i == 2:
        assert v == 3
    if i == 3:
        assert v == None
    if i == 4:
        assert v == 2
    if i == 5:
        assert v == 1
    if i == 6:
        assert v == None
    i += 1

assert i == 7


# 运算

## not support ==
#assert l == [ 4, 3, 2, 1 ]

## not support +
#l = l + [0]
#assert l[4] == 0


# 方法

l = [ None, 4, 3, 2, 1, None ]

## append

l.append(5)

assert len(l) == 7
assert l[-1] == 5


## clear

l.clear()

assert len(l) == 0


## copy

l1 = [ 1, 2, 3, 4, None ]
l2 = l1.copy()

l2[0] = 0
l2.append(5)

assert len(l1) == 5
assert len(l2) == 6
assert l1[0] == 1
assert l2[0] == 0

## count

l = [ None, 4, 3, 2, 4, None, 2, 1, 0, 0, 0 ]

assert len(l) == 11
assert l.count(None) == 2
assert l.count(4) == 2
assert l.count(3) == 1
assert l.count(2) == 2
assert l.count(1) == 1
assert l.count(0) == 3


## extend

l = [ None, 4, 3, 2, 4, None, 2, 1, 0, 0, 0 ]

l.extend([5, 6, 7])

assert len(l) == 14
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

# [-1, 0]
assert l[0] == -1

l.insert(-10, -2)

# [-2, -1, 0]
assert l[0] == -2

l.insert(3, 1)
l.insert(10, 10)

# [-2, -1, 0, 3, 10]
assert l[3] == 1
assert l[4] == 10

l.insert(-1, None)

# [-2, -1, 0, 3, None, 10]
assert l[-2] == None
assert l[-1] == 10


## pop

l = [ 0, 1, None, 2, 3, 4 ]

p = l.pop()

assert len(l) == 5
assert l[-1] == 3
assert p == 4

p = l.pop(0)

assert l[0] == 1
assert p == 0

p = l.pop(-2)

assert l[-1] == 3
assert p == 2


## remove

l = [ 0, None, 1, 2, 3, 4, 0, None ]

l.remove(0)

assert len(l) == 7
assert l[0] == None

l.remove(0)

assert len(l) == 6
assert l[-1] == None


## reverse

l = [ 0, 1, 2, 3, None, 4 ]

l.reverse()

assert len(l) == 6
assert l[0] == 4
assert l[4] == 1


## sort

l = [ 4, 1, 2, 0, 3 ]

l.sort()

assert l[0] == 0
assert l[1] == 1
assert l[2] == 2
assert l[3] == 3
assert l[4] == 4



