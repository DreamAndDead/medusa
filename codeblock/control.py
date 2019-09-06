# python control flow logic test
#

# for
for i in range(1, 10):
    print(i)

for i in [1, 2, 3]:
    print(i)

## more loop target
for i, v in enumerate([1, 2, 3]):
    print(i)
    print(v)

## with break
for i in range(1, 10, 2):
    print(i)
    if i > 5:
        break
    

# if
if True:
    print("true")

## if else
if True:
    print("true")
else:
    print("false")

## if elif 本质上，下面两种写法是等价的
if 1:
    print(1)
elif 2:
    print(2)
elif 3:
    print(3)
else:
    print(4)

if 1:
    print(1)
else:
    if 2:
        print(2)
    else:
        if 3:
            print(3)
        else:
            print(4)

## if expr
res = "win" if True else "lose"
print(res)


# while
n = 0
while n < 10:
    n += 1
    print(n)

## with break
n = 0
while True:
    n += 1
    print(n)
    if n > 10:
        break
