# tuple 字面量
# TODO，因为在 python 中有很多隐式的 tuple，比如多变量赋值的地方
# 而 lua 的多变量赋值并不需要 tuple，所以字面量会引发很多误解，暂时不支持

## init

#字面量暂时不支持
#t = (1, 2, 3)

t = tuple([1, 2, 3, None])

assert len(t) == 4
assert t[0] == 1
assert t[1] == 2
assert t[2] == 3
assert t[3] == None


## method

### count

t = tuple([1, 'a', 'z', 'pi', 'a', 'c', 'c', None])

assert t.count(1) == 1
assert t.count('a') == 2
assert t.count('b') == 0
assert t.count('c') == 2
assert t.count(None) == 1


### index

t = tuple([1, 'a', 'z', 'pi', 'a', 'c', 'c'])

assert t.index('a') == 1
assert t.index('a', 0) == 1
assert t.index('a', 1) == 1
assert t.index('a', 2) == 4
assert t.index('a', 3) == 4
assert t.index('a', 4) == 4
assert t.index('a', 1, 4) == 1
assert t.index('a', 2, 5) == 4


## operations

## in and not in

t = tuple([ 4, 1, 2, 0, 3 ])

assert 0 in t
assert 5 not in t

## +

t1 = tuple([ 4, 1, 2, 0, 3 ])
t2 = tuple([ 4, 1, 2, 0, 3 ])

t = t1 + t2

assert len(t) == 10
assert t[0] == 4
assert t[1] == 1
assert t[2] == 2
assert t[3] == 0
assert t[4] == 3
assert t[5] == 4
assert t[6] == 1
assert t[7] == 2
assert t[8] == 0
assert t[9] == 3

## *

t1 = tuple([ 4, 1, 2, 0, 3 ])

t = t1 * 2

assert len(t) == 10
assert t[0] == 4
assert t[1] == 1
assert t[2] == 2
assert t[3] == 0
assert t[4] == 3
assert t[5] == 4
assert t[6] == 1
assert t[7] == 2
assert t[8] == 0
assert t[9] == 3

## slice index

t = tuple([ 4, 1, 2, 0, 3 ])

assert t[0] == 4

ts = t[1:2]
assert len(ts) == 1
assert ts[0] == 1

ts2 = t[1:5:2]
assert len(ts2) == 2
assert ts2[0] == 1
assert ts2[1] == 0

