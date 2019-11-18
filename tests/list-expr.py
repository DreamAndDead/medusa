# list 生成式

## simple
a = [0, 1, 2, 3]
b = [i + 1 for i in a]

assert a[0] + 1 == b[0]
assert a[1] + 1 == b[1]
assert a[2] + 1 == b[2]
assert a[3] + 1 == b[3]


## if in front, as a map
a = [0, 1, 2, 3]
b = [i if i % 2 == 1 else 0 for i in a]

assert b[0] == 0
assert b[1] == 1
assert b[2] == 0
assert b[3] == 3


## if in back, as a filter
a = [0, 1, 2, 3]
b = [i for i in a if i % 2 == 1]

assert b[0] == 1
assert b[1] == 3


## multi list
a = [0, 1]
b = [10, 11]
c = [n - m for m in a for n in b]

### 先循环 a 后循环 b
assert c[0] == 10
assert c[1] == 11
assert c[2] == 9
assert c[3] == 10


## nested list expr

a = [
        [0, 1],
        [2, 3]
    ]

b = [j for i in a for j in i]

assert b[0] == 0
assert b[1] == 1
assert b[2] == 2
assert b[3] == 3


## random if and for
a = [
        [0, 1, 2],
        [0, 1],
        [0],
    ]

b = [j for i in a if len(i) == 2 for j in i if j == 0]

assert len(b) == 1
assert b[0] == 0

c = [j if j == 1 else 10 for i in a if len(i) == 2 for j in i if j == 0]

assert len(c) == 1
assert c[0] == 10

