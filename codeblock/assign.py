# assign 赋值

# 单变量赋值
a = 1
assert a == 1

# 多变量赋相同值
b = c = 1
assert b == 1
assert c == 1

# 多变量同时赋值
d, e = 2, 3
assert d == 2
assert e == 3

d, e = e, d
assert d == 3
assert e == 2

# 不均衡情况

# FIXME: 当使用如下赋值方式时，a 被赋值为元组 (1, 2)
# 在 lua 中使用同样的写法，a 被赋值为 1
#a = 1, 2
#assert a == (1, 2)


# FIXME: 在 python 中，下面的写法会引发运行错误
# ValueError: too many values to unpack (expected 2)
# 而在 lua 中，执行后会赋值 d = 2, e = 3
#d, e = 2, 3, 4


# FIXME: 在 python 中，当变量多于赋值 数会引发错误
# TypeError: cannot unpack non-iterable int object
# ValueError: not enough values to unpack (expected 3, got 2)
# 而在 lua 中，会赋值
# d = 2, e = nil
# d = 2, e = 3, f = nil

#d, e = 2
#d, e, f = 2, 3                                                                                


# 考虑 Star * 的情况

# 在 python 中，* 可以吸收多余的变量，成为一个数组
# TODO: 在 lua 中暂时不支持用 * 赋值
#a, *b = 1, 2                                                        
#assert a == 1
#assert b == [2]

#a, *b = 1, 2, 3, 4
#assert a == 1
#assert b == [2, 3, 4]


# 但是如果右侧只有一个值，且不是可迭代对象，就会引发错误
# cannot unpack non-iterable int object
#a, *b = 1

