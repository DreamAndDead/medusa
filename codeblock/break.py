# break 语句

## break in one loop
i = 0
while True:
    if i > 99:
        break
    i += 1

assert i == 100


## break in more loop

i = j = 0
while True:
    while True:
        if i > 99:
            break
        i += 1

    if j > 49:
        break
    j += 1

assert i == 100
assert j == 50
