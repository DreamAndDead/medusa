# 

d = {'a': 2}

def f(a=1):
    return a

assert f(1) == 1
assert f(**d) == 2

