# If 语句

## single if

b = 0
if True:
    b = 1

assert b == 1


## if ... else ...

b = 0
if b == 0:
    b = 1
else:
    b = 2

assert b == 1

if b == 0:
    b = 1
else:
    b = 2

assert b == 2


## if ... elif ...

b = 0
if b == 0:
    b = 1
elif b == 1:
    b = 2

assert b == 1

if b == 0:
    b = 1
elif b == 1:
    b = 2

assert b == 2


## if ... elif ... else ...

b = 0
if b == 0:
    b = 1
elif b == 1:
    b = 2
else:
    b = 3

assert b == 1

if b == 0:
    b = 1
elif b == 1:
    b = 2
else:
    b = 3

assert b == 2

if b == 0:
    b = 1
elif b == 1:
    b = 2
else:
    b = 3

assert b == 3

