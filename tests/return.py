# Return 语句

## nothing
def null():
    return

assert null() == None


## single value
def inspect(n):
    return n

assert inspect(10) == 10


## multi values
def inspect_more(m, n):
    return m, n

a, b = inspect_more(10, 20)

assert a == 10
assert b == 20
