# if 表达式

## true
a = 1 if True else 0

assert a == 1


## false
a = 0 if False else 1

assert a == 1


## all false values

a = 0 if False or 0 or "" or None else 1

assert a == 1
