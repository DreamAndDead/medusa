def add(*a):
    t = 0
    for i in a:
        t += i
    return t

p = [ 1, 2, 3, 4 ]
assert add(*p) == 10

