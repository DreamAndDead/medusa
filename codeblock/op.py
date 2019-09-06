# operations
# include: binop, unaryop, boolop, assignment
#
# TODO:
# - bit operation, ref: http://lua-users.org/wiki/BitwiseOperators

# binop

## add

print(10 + 20)
print(5 + 0.5)

## sub

print(10 - 20)
print(20 - 1.7)

## mult

print(3 * .5)
print(0.4 * .17)

## div

print(5 / 2)
print(18.09 / 3)

## floordiv

print(13 // 2)

## mod

print(10 % 3)
print(109 % 17)

## pow

print(2 ** 10)

## lshift
## rshift
## bitor
## bitxor
## bitand


# unaryop

## invert

## not

if True:
    print("true")

if not False:
    print("not false")

## uadd

print(+1 + +2)

## usub

print(+2 - -10)


# boolop

## and

print(1 and 2 and 3)

## or

print(1 or 2 or 3)

## and & or

print(1 and 2 or 3)
print(1 or 2 and 3)


# assignment

a = 10
print(a)

b = c = 20
print(b)
print(c)

a, b = b, a
print(a)
print(b)

#d, *e = 1, 2, 3
#print(d)
#for i in e:
#    print(i)

## ann assignment

a += 1
print(a)



