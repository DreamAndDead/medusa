# compare 比较运算

assert 1 == 1

assert 1 != 2

assert 1 < 2

assert 2 <= 2

assert 2 > 1

assert 2 >= 2


a = None
assert a is None

assert 10 is 10
assert 'str' is 'str'

a = []
b = a
c = []

assert a is b
assert a is not c

# in 的核心在于迭代器
assert 1 in {1, 2, 3}
assert 2 in {1, 2, 3}
assert 3 in {1, 2, 3}
assert 4 not in {1, 2, 3}
assert 5 not in {1, 2, 3}
assert 6 not in {1, 2, 3}
