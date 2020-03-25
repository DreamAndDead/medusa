# Function and Call 函数定义和调用

## 位置参数
def mul(a, b):
    """simple multiplication"""
    return a * b

assert mul(10, 2) == 20
assert mul(1, b=10) == 10
assert mul(a=2, b=4) == 8
assert mul(a=3, b=5) == 15


## 默认值参数
def sub(a, b=2):
    """minus function"""
    return a - b

assert sub(10, 10) == 0
assert sub(10) == 8
assert sub(10, b=8) == 2
assert sub(a=11, b=3) == 8
assert sub(b=11, a=3) == -8


## vararg，在 python 中如 *args 的写法，写在位置参数的最后，分隔位置参数和键值参数
## 多余的位置参数都由它来吸收
def sum(first, second, *more):
    """sum of the parameters"""
    s = first + second
    for i in more:
        s += i
    return s

assert sum(1, 2, 3, 4) == 10
assert sum(1, 2, 3) == 6
assert sum(1, 2) == 3

assert sum(1, second=2) == 3
assert sum(first=1, second=2) == 3



## 键值参数，在定义 vararg 之后的都是键值参数
## 有默认值为可选值，无默认值为必选值
def add(a, b, *c, d, e):
    return a + b + d + e

assert add(1, 2, 3, 4, d=1, e=2) == 6
assert add(1, 2, d=1, e=2) == 6
assert add(1, b=2, d=1, e=2) == 6
assert add(a=1, b=2, d=1, e=2) == 6
assert add(d=1, e=2, a=1, b=2) == 6

def add(a, b, *c, d=0, e):
    return a + b + d + e

assert add(1, 2, 3, 4, d=1, e=2) == 6
assert add(1, 2, 3, 4, e=2) == 5
assert add(1, 2, d=1, e=2) == 6
assert add(1, 2, e=2) == 5
assert add(1, b=2, d=1, e=2) == 6
assert add(1, b=2, e=2) == 5
assert add(a=1, b=2, d=1, e=2) == 6
assert add(a=1, b=2, e=2) == 5
assert add(d=1, e=2, a=1, b=2) == 6
assert add(e=2, a=1, b=2) == 5


## kwargs，在定义所有键值之后，可定义 kwargs，吸收所有未定义的键值对
## 键值的调用可以复用 c 和 f
def add(a, b, *c, d, e, **f):
    return a + b + d + e + f['c'] + f['f']

assert add(1, 2, 3, 4, d=1, e=2, c=3, f=4) == 13
assert add(1, 2, d=1, e=2, c=3, f=4) == 13
assert add(1, b=2, d=1, e=2, c=3, f=4) == 13
assert add(a=1, b=2, d=1, e=2, c=3, f=4) == 13
assert add(d=1, e=2, a=1, b=2, c=3, f=4) == 13


## 函数作为参数
## 在 python 中，函数作为一等公民，可以作为其它函数的参数
def registerClickEvent(callback):
    """register a function as callback"""
    event = { "id": "click" }
    callback(event)

def callback(event):
    """simple callback"""
    assert event["id"] == "click"

## 调用
registerClickEvent(callback)


## 嵌套函数定义，并返回一个函数
## 函数作为一等公民，也可以作为返回值
def plus_factory(plus_num):
    """plus factory"""
    def plus_func(n):
        """plus function"""
        return n + plus_num
    return plus_func

## 调用
plus_10 = plus_factory(10)
assert plus_10(20) == 30
assert plus_10(-10) == 0


## 装饰器
def clamp_wrapper(func):
    """a clamp decorator"""
    def wrapper(*args, **kwargs):
        res = func(*args, **kwargs)
        if res < 0:
            res = 0
        return res
    return wrapper

@clamp_wrapper
def minus(a, b=10, *c, d=10, e=1, **f):
    return a - d

assert minus(10, 1) == 0
assert minus(10, 20) == 0
assert minus(1) == 0
assert minus(1, d=0) == 1


## 多层装饰器
def clamp_wrapper_with(left, right):
    """a clamp decorator with left and right limit"""
    def clamp_wrapper(func):
        def wrapper(*args, **kwargs):
            res = func(*args, **kwargs)
            if res < left:
                res = left
            elif res > right:
                res = right
            return res
        return wrapper
    return clamp_wrapper
        
@clamp_wrapper_with(1, 10)
def sum(a, b, *c, d, e, **f):
    t = 0
    for i in c:
        t += i
    return t + a + b + d + e

## 调用
assert sum(1, 2, 3, d=4, e=5) == 10
assert sum(-1, -2, d=-3, e=-4) == 1
assert sum(a=1, b=-1, c=0, d=1, e=-10) == 1

