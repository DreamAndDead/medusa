# builtin 函数


## abs

assert abs(10) == 10
assert abs(0) == 0
assert abs(-10) == 10
assert abs(1.07) == 1.07
assert abs(-0.52) == 0.52


## all

assert all([]) == True
assert all([1, 2]) == True
assert all([0, 1, 2]) == False
assert all([0, 0]) == False


## any

assert any([]) == False
assert any([1, 2]) == True
assert any([0, 1, 2]) == True
assert any([0, 0]) == False

## ascii

## bin

assert bin(0) == '0b0'
assert bin(10) == '0b1010'
assert bin(100) == '0b1100100'
assert bin(1000) == '0b1111101000'



## bool

assert bool(True)
assert bool(1)
assert bool('abc')
assert bool([1, 2])
assert not bool(False)
assert not bool([])
assert not bool('')
assert not bool(0)

## bytearray
## bytes

## callable

assert callable(abs)
assert callable(lambda x: x)
assert not callable(0)
assert not callable('abc')
assert not callable([])

## chr
## classmethod
## compile
## complex
## delattr


## dict

d = dict()
assert len(d) == 0

d[1] = 'a'
d[2] = 'b'
e = dict(d)
assert e[1] == 'a'
assert e[2] == 'b'

### todo，因为函数不支持键值
# dict(one=1, two=2)



## dir

## divmod

d, m = divmod(10, 3)
assert d == 3 and m == 1
d, m = divmod(-10, 3)
assert d == -4 and m == 2
d, m = divmod(10, -3)
assert d == -4 and m == -2
d, m = divmod(-10, -3)
assert d == 3 and m == -1


## enumerate

l = [0, 1, 2, 3, 4]

for i, n in enumerate(l):
    assert i == n

### todo: 如果应用于 dict，则只针对 keys() 值进行遍历
# d = { 'a': 1, 'b': 'z' }
# for i, k in enumerate(d):


## eval
## exec

## filter

## float

assert float(10) == 10.0
assert float(10.4) == 10.4
assert float('12') == 12.0
assert float('10.8') == 10.8



## format
## frozenset
## getattr
## globals
## hasattr
## hash
## help


## hex

assert hex(0) == '0x0'
assert hex(10) == '0xa'
assert hex(100) == '0x64'
assert hex(1000) == '0x3e8'
assert hex(10000) == '0x2710'
assert hex(100000) == '0x186a0'




## id
## input


## int

assert int() == 0
assert int(10) == 10
assert int(10.5) == 10
assert int(-10.5) == -10
assert int('10', 10) == 10
assert int('10', 16) == 16
assert int(' 10', 10) == 10
assert int('10 ', 16) == 16
assert int('0b10', 0) == 2
assert int('0x10', 0) == 16
assert int('-0b10', 0) == -2
assert int('-0x10', 0) == -16



## isinstance
## issubclass
## iter



## len

assert len('') == 0
assert len('abcd') == 4
assert len([]) == 0
assert len([1, 2, 3]) == 3
assert len({}) == 0
assert len({ 0: 0, 'a': 'z' }) == 2


## list

assert len(list()) == 0

l = list([1, 2, 3])
assert len(l) == 3
assert l[0] == 1
assert l[1] == 2
assert l[2] == 3


## locals
### not support


## map

## max
### todo


## memoryview


## min
### todo


## next
## object


## oct

assert oct(0) == '0o0'
assert oct(10) == '0o12'
assert oct(100) == '0o144'
assert oct(1000) == '0o1750'
assert oct(10000) == '0o23420'




## open



## ord






## pow

assert pow(2, 10) == 1024
assert pow(2, 9, 3) == 2


## print
## property


## range

l = [i for i in range(10)]

assert len(l) == 10
assert l[0] == 0
assert l[9] == 9

l = [i for i in range(1, 5)]

assert len(l) == 4
assert l[0] == 1
assert l[1] == 2
assert l[2] == 3
assert l[3] == 4

l = [i for i in range(1, 9, 2)]

assert len(l) == 4
assert l[0] == 1
assert l[1] == 3
assert l[2] == 5
assert l[3] == 7


## repr
## reversed


## round

assert round(10) == 10
assert round(10, 0) == 10
assert round(10, 1) == 10
assert round(10, 2) == 10
assert round(10, -1) == 10
assert round(10, -2) == 0
assert round(10.49, 0) == 10
assert round(10.51, 0) == 11
assert round(10.49, 1) == 10.5
assert round(10.51, 1) == 10.5

### TODO: in python, that's wired
#assert round(10.5) == 10
#assert round(9.5) == 10


## set
## setattr
## slice
## sorted
## staticmethod
## str

## sum

assert sum([1, 2, 3]) == 6
assert sum([]) == 0
assert sum([1, 2, 3], 0) == 6
assert sum([1, 2, 3], 4) == 10


## super
## tuple
## type
## vars
## zip
## __import__


