# continue

## for

for i in range(20):
    if i % 2 == 0:
        continue

    assert i % 2 == 1
    
    for j in range(30):
        if j % 3 == 0:
            continue

        assert j % 3 != 0



## while

i = 0
while i < 100:
    i += 1
    if i % 2 == 0:
        continue

    if i % 3 == 0:
        continue

    assert i % 6 != 0

    j = 0
    while j < 200:
        j += 1

        if j % 5 == 0:
            continue

        if j % 7 == 0:
            continue

        assert j % 35 != 0
