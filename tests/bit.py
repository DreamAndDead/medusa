# bit 位运算

# rshift
assert (10 >> 1) == 5
assert (10 >> 2) == 2
assert (10 >> 3) == 1
assert (10 >> 4) == 0
assert (10 >> 14) == 0
assert (10 >> 24) == 0
assert (10 >> 34) == 0

assert (-10 >> 1) == -5
assert (-10 >> 2) == -3
assert (-10 >> 3) == -2
assert (-10 >> 4) == -1
assert (-10 >> 5) == -1
assert (-10 >> 6) == -1
assert (-10 >> 16) == -1
assert (-10 >> 26) == -1
assert (-10 >> 36) == -1

# lshift
assert (1 << 0) == 1
assert (1 << 1) == 2
assert (1 << 2) == 4
assert (1 << 10) == 1024
assert (1 << 20) == 1048576
assert (1 << 30) == 1073741824


# and
assert 0b1111 & 0b0000 == 0b0000
assert 0b1111 & 0b0010 == 0b0010
assert 0b1111 & 0b0100 == 0b0100
assert 0b1111 & 0b1000 == 0b1000
assert 0b1111 & 0b1010 == 0b1010
assert 0b1111 & 0b0101 == 0b0101

# or
assert 0b1111 | 0b0000 == 0b1111
assert 0b1111 | 0b0010 == 0b1111
assert 0b1111 | 0b0100 == 0b1111
assert 0b1111 | 0b1000 == 0b1111
assert 0b1111 | 0b1010 == 0b1111
assert 0b1111 | 0b0101 == 0b1111


# invert
assert ~1 == -2
assert ~10 == -11


# xor
assert 0b1111 ^ 0b1111 == 0b0000
assert 0b1111 ^ 0b1011 == 0b0100
assert 0b1111 ^ 0b1101 == 0b0010
assert 0b1111 ^ 0b1110 == 0b0001


