# yield

## simple
def count():
    for i in range(10):
        yield i

c = count()

assert next(c) == 0
assert next(c) == 1
assert next(c) == 2


## pass parameters

def echo():
    start = None
    while True:
        line = yield start
        start = line

e = echo()

assert next(e) == None
assert e.send(10) == 10


