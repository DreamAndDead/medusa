# dict 生成式

## simple

d = { 0: 'a', 1: 'b', 'c': 3 }
e = { k: v for k, v in d.items() }
f = { v: k for k, v in d.items() }

assert d[0] == e[0]
assert d[1] == e[1]
assert d['c'] == e['c']

assert f['a'] == 0
assert f['b'] == 1
assert f[3] == 'c'


## if in front, as a map
d = { 0: 0, 1: 1, 2: 2 }
e = { k: v if k % 2 == 1 else 10 for k, v in d.items() }

assert e[0] == 10
assert e[1] == 1
assert e[2] == 10


f = { k if v == 0 else v+1 : v if k % 2 == 1 else 10 for k, v in d.items() }

assert f[0] == 10
assert f[2] == 1
assert f[3] == 10


## if in back, as a filter
d = { 0: 0, 1: 1, 2: 2 }
e = { k: v for k, v in d.items() if k > 1 }

assert 0 not in e
assert 1 not in e
assert 2 in e
assert e[2] == 2


## multi list generate dict

l = [0, 1, 2]
a = ['a', 'b']

d = { k: v for k in l for v in a }

assert d[0] == 'b'
assert d[1] == 'b'
assert d[2] == 'b'


## nested dict

d = {
     0: {
         'a': 1,
         'b': 2,
        },
     1: {
         'c': 3,
         'd': 4,
        }
    }

e = { nk: nv for k, v in d.items() for nk, nv in v.items() }

assert e['a'] == 1
assert e['b'] == 2
assert e['c'] == 3
assert e['d'] == 4


## random if and for

d = {
     0: {
         'a': 1,
         'b': 2,
        },
     1: {
         'c': 3,
         'd': 4,
        }
    }

e = { nk: nv if nv % 2 == 1 else nv + 1 for k, v in d.items() if k % 2 == 0 for nk, nv in v.items() if nv > 1 }

assert 'a' not in e
assert 'b' in e
assert e['b'] == 3
assert 'c' not in e
assert 'd' not in e
