# Function and Call 函数定义和调用

## 位置参数
def mul(a, b):
    """simple multiplication"""
    return a * b

## 只使用位置参数进行调用，位置参数的数量要和定义中匹配，这是语言要求
assert mul(10, 2) == 20
assert mul(-2, 32) == -64


## 默认值参数
def sub(a, b=2):
    """minus function"""
    return a - b

## 默认值参数也是一种位置参数，不过在调用时，如果不传位置参数，则会自动赋值默认值
assert sub(10, 10) == 0
assert sub(10) == 8


## vararg，在 python 中如 *args 的写法，写在位置参数的最后，分隔位置参数和键值参数
## 多余的位置参数都由它来吸收
def sum(first, second, *more):
    """sum of the parameters"""
    s = first + second
    for i in more:
        s += i
    return s

## 调用有 vararg 定义的函数时，不需要限定位置参数的数量，因为多余的会被 vararg 吸收
assert sum(1, 2) == 3
assert sum(1, 2, 3) == 6
assert sum(1, 2, 3, 4) == 10



## 键值参数
## TODO，暂时不支持


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
    def wrapper(*params):
        res = func(*params)
        if res < 0:
            res = 0
        return res
    return wrapper

@clamp_wrapper
def minus(a, b = 10):
    return a - b

## 调用
assert minus(10, 1) == 9
assert minus(10, 20) == 0
assert minus(1) == 0


## 多层装饰器
def clamp_wrapper_with(left, right):
    """a clamp decorator with left and right limit"""
    def clamp_wrapper(func):
        def wrapper(*params):
            res = func(*params)
            if res < left:
                res = left
            elif res > right:
                res = right
            return res
        return wrapper
    return clamp_wrapper
        
@clamp_wrapper_with(1, 10)
def sum(*n):
    t = 0
    for i in n:
        t += i
    return t

## 调用
assert sum(1, 2, 3) == 6
assert sum(-1, -2, -3) == 1
assert sum(4, 5, 6) == 10

