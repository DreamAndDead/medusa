# For 语句

## for and list
n = 0
for i in [1, 2, 3]:
    n += 1
    assert i == n


## for and dict
d = { 1: 1, 2: 2, 3: 3 }
for k, v in d.items():
    assert k == v


## for and range()
n = 0
for i in range(10):
    assert i == n
    n += 1

assert n == 10

n = 1
for i in range(1, 5):
    assert i == n
    n += 1

assert n == 5

n = 1
for i in range(1, 10, 2):
    assert i == n
    n += 2

assert n == 11

n = 10
for i in range(10, 1, -2):
    assert i == n
    n -= 2

assert n == 0
