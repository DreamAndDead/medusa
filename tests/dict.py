# Dict 字面量

# 创建
# python 3.4 不支持 e = { **d } 的方法来创建
# with None as key and as value

d = { 'name' : 'john', 1 : 26, 'age' : 20, None: None }

assert d['name'] == 'john'
assert d[1] == 26
assert d['age'] == 20
assert d[None] == None

assert len(d) == 4


## nested dict

d = {
     0: {
         'a': 1,
         'b': 2,
        },
     1: {
         'c': 3,
         'd': 4,
        },
     None: {
         None: None,
        }
    }

assert d[0]['a'] == 1
assert d[0]['b'] == 2
assert d[1]['c'] == 3
assert d[1]['d'] == 4
assert d[None][None] == None


# 操作符

## ==
# not support
#assert d == {}


# 方法

## clear

d.clear()

assert len(d) == 0


## copy

d = { 'name' : 'john', 1 : 26, 'age' : 20, None: None }
m = d.copy()

d['name'] = 'jane'
d[None] = 'nil'
m['age'] = 56

assert d['age'] == 20
assert d[None] == 'nil'
assert m['name'] == 'john'
assert m[None] == None


## fromkeys

m = d.fromkeys([1, 2, 'height', None])

assert m[1] == None
assert m[2] == None
assert m['height'] == None
assert m[None] == None

m = d.fromkeys([1, 2, 'height', None], 40)

assert m[1] == 40
assert m[2] == 40
assert m['height'] == 40
assert m[None] == 40


## get

d = { 'name' : 'john', 1 : 26, 'age' : 20 }

assert d.get('name') == 'john'
assert d.get('home') == None
assert d.get('home', 'cn') == 'cn'


## items

d = { 'name' : 'john', 1 : 26, 'age' : 20 }

for k, v in d.items():
    if k == 'name':
        assert v == 'john'
    elif k == 1:
        assert v == 26
    elif k == 'age':
        assert v == 20


## keys

d = { 'name' : 'john', 1 : 26, 'age' : 20 }

for k in d.keys():
    assert k == 'name' or k == 1 or k == 'age'


## pop

d = { 'name' : 'john', 1 : 26, 'age' : 20 }

assert d.pop('name') == 'john'
# raise KeyError in python
#assert d.pop('name') == None
assert d.pop('name', 'jane') == 'jane'


## popitem

d = { 'name' : 'john', 1 : 26, 'age' : 20 }

k, v = d.popitem()
if k == 'name':
    assert v == 'john'
elif k == 1:
    assert v == 26
elif k == 'age':
    assert v == 20


## setdefault

d = { 'name' : 'john', 1 : 26, 'age' : 20 }

v = d.setdefault('name', 'bing')
assert v == 'john'
assert d['name'] == 'john'

v = d.setdefault('hair', 'black')
assert v == 'black'
assert d['hair'] == 'black'


## update

d = { 'name' : 'john', 1 : 26, 'age' : 20 }

d.update({ 'age' : 22, 'hair' : 'blond' })
assert d['age'] == 22
assert d['hair'] == 'blond'


## values

d = { 'name' : 'john', 1 : 26, 'age' : 20 }

for v in d.values():
    assert v == 'john' or v == 26 or v == 20


