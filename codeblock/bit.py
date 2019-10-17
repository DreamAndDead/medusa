# bit 位运算

# shift
a = 1 << 2
assert a == 4

a = 1 >> 3
assert a == 0

# and
b = 2 & 7
assert b == 2

# or
c = 2 | 7
assert c == 7

# invert
d = ~1
assert d == -2

# fixme: dead loop
#d = ~(-1)
#assert d == 0

# xor
e = 3 ^ 3
assert e == 0
