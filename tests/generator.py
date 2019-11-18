# generator

## simple
a = [0, 1, 2, 3]
b = (i+1 for i in a)

i = 0
for n in b:
    assert n == a[i] + 1
    i += 1

## if in front, as a map

a = [0, 1, 2, 3]
b = (i if i % 2 == 1 else 0 for i in a)

i = 0
for n in b:
    if i == 0:
        assert n == 0
    if i == 1:
        assert n == 1
    if i == 2:
        assert n == 0
    if i == 3:
        assert n == 3
    i += 1


## if in back, as a filter

a = [0, 1, 2, 3]
b = (i for i in a if i % 2 == 1)

i = 0
for n in b:
    if i == 0:
        assert n == 1
    if i == 1:
        assert n == 3
    i += 1


## multi list

a = [0, 1]
b = [10, 11]
c = (n - m for m in a for n in b)

### 先循环 a 后循环 b
i = 0
for n in c:
    if i == 0:
        assert n == 10
    if i == 1:
        assert n == 11
    if i == 2:
        assert n == 9
    if i == 3:
        assert n == 10
    i += 1

## nested list expr

a = [
        [0, 1],
        [2, 3]
    ]

b = (j for i in a for j in i)

i = 0
for n in b:
    if i == 0:
        assert n == 0
    if i == 1:
        assert n == 1
    if i == 2:
        assert n == 2
    if i == 3:
        assert n == 3
    i += 1


## random if and for

a = [
        [0, 1, 2],
        [0, 1],
        [0],
    ]

b = (j for i in a if len(i) == 2 for j in i if j == 0)

i = 0
for n in b:
    if i == 0:
        assert n == 0
    i += 1

assert i == 1


c = (j if j == 1 else 10 for i in a if len(i) == 2 for j in i if j == 0)

i = 0
for n in c:
    if i == 0:
        assert n == 10
    i += 1

assert i == 1

