# subscript 下标类型

## index

l = [1, 2, 3, 4]

assert l[0] == 1
assert l[1] == 2
assert l[2] == 3
assert l[3] == 4
assert l[-4] == 1
assert l[-3] == 2
assert l[-2] == 3
assert l[-1] == 4


d = { 1: 1, 2: 'b', 3: 'c' }

assert d[1] == 1
assert d[2] == 'b'
assert d[3] == 'c'


## slice

l = [1, 2, 3, 4]
s = slice(0, 2)
sl = l[s]

assert len(sl) == 2
assert sl[0] == 1
assert sl[1] == 2

l = [1, 2, 3, 4]
s = slice(3)
sl = l[s]

assert len(sl) == 3
assert sl[0] == 1
assert sl[1] == 2
assert sl[2] == 3


l = [1, 2, 3, 4]
sl = l[0:3]

assert len(sl) == 3
assert sl[0] == 1
assert sl[1] == 2
assert sl[2] == 3

l = [1, 2, 3, 4]
sl = l[0:-1]

assert len(sl) == 3
assert sl[0] == 1
assert sl[1] == 2
assert sl[2] == 3

l = [1, 2, 3, 4]
sl = l[0:]

assert len(sl) == 4
assert sl[0] == 1
assert sl[1] == 2
assert sl[2] == 3
assert sl[3] == 4

l = [1, 2, 3, 4]
sl = l[:4]

assert len(sl) == 4
assert sl[0] == 1
assert sl[1] == 2
assert sl[2] == 3
assert sl[3] == 4

