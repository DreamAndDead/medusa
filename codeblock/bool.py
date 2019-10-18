# Bool 运算

# and
a = 1 and 2
assert a == 2

# or
b = 1 or 2
assert b == 1

# not
c = not 1
assert c == False

c = not c
assert c == True


# and & or
d = 1 and 2 or 3
assert d == 2

e = 1 or 2 and 3
assert e == 1
