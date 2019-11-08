# set 生成式

## simple

a = {0, 1, 2, 3}
b = {i + 1 for i in a}

assert 1 in b
assert 2 in b
assert 3 in b
assert 4 in b


## if in front, as a map

a = {0, 1, 2, 3}
b = {i if i % 2 == 1 else 0 for i in a}

assert len(b) == 3
assert 0 in b
assert 1 in b
assert 3 in b


## if in back, as a filter
a = {0, 1, 2, 3}
b = {i for i in a if i % 2 == 1}

assert len(b) == 2
assert 1 in b
assert 3 in b


## multi list
a = {0, 1}
b = {10, 11}
c = {n - m for m in a for n in b}

### 先循环 a 后循环 b
assert len(c) == 3
assert 9 in c
assert 10 in c
assert 11 in c


## nested list expr
### set is not hashable
### ref: https://stackoverflow.com/questions/6754102/typeerror-unhashable-type

a = [
        {0, 1},
        {2, 3}
    ]

b = {j for i in a for j in i}

assert len(b) == 4
assert 0 in b
assert 1 in b
assert 2 in b
assert 3 in b

## random if and for
a = [
        {0, 1, 2},
        {0, 1},
        {0,}
    ]

b = {j for i in a if len(i) == 2 for j in i if j == 0}

assert len(b) == 1
assert 0 in b

c = {j if j == 1 else 10 for i in a if len(i) == 2 for j in i if j == 0}

assert len(c) == 1
assert 10 in c


