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


