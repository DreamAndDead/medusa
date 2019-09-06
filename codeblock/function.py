# function test
#
# not support
# - function keyword parameter

# normal
def move(direction, distance):
    """move dist to a direction"""
    print("move to direction")
    print(direction)
    print("with distance")
    print(distance)

move("north", 10)


# default value
def say(word, time=2):
    """say word in time seconds"""
    print(word)
    print("wait")
    print(time)
    print("seconds")

say("hello python", 1)
say("hello lua", 2)


# var args
# TODO: there's an interesting detail
# if use end=1000, it will cause syntax error because end is considered as keyword end in lua
def play(start=0, finish=1000, *other):
    print(start)
    print(finish)
    for a in other:
        print(a)

play(20, 40, "hello python", "hello lua")


# nested functions
def plus_factory(plus_num):
    def plus_func(n):
        return n + plus_num
    return plus_func

print(plus_factory(10)(1))


# decorators
def output_wrapper(func):
    def wrapper(*params):
        print("function start")
        func(*params)
        print("function end")
    return wrapper


@output_wrapper
def wait(second):
    print("wait")
    print(second)
    print("seconds")

wait(20)


def output_wrapper_with(beginning, finish):
    def output_wrapper(func):
        def wrapper(*params):
            print(beginning)
            func(*params)
            print(finish)
        return wrapper
    return output_wrapper
        
@output_wrapper_with("begin wait", "end wait")
def wait(second):
    print("wait")
    print(second)
    print("seconds")

wait(40)

# callbacks
# 在 lua 中，可以直接在函数调用时，定义匿名函数作为参数，就像
# registerClickEvent(function () ... end)
# 在 python 中，不存在对应的机制，由于缩进严格，要做到将函数作为参数，只能先定义一个函数，再将函数名作为参数进行传参

def registerClickEvent(callback):
    """register click event"""
    event = { "id": "click" }
    callback(event)

def callback(event):
    """callback function"""
    print(event["id"])

registerClickEvent(callback)

