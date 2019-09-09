dofile('./codeblock/luainit.lua')

local l = list {1, 2, 3}
print(l[0])
print(l[1])
print(l[2])
l[0] = 10
print(l[0])
print(l[1])
print(l[2])
l.append(4)
print(l[0])
print(l[1])
print(l[2])
print(l[3])
