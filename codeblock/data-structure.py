# pythou builtin data structure
# list, dict, set and others

# list

def print_list(l):
    for e in l:
        print(e)

l = [1, 2, 3]

print_list(l)

l[0] = 10

print_list(l)

l.append(4)

print_list(l)

# l.clear()

l_copy = l.copy()
l[0] = 1

print_list(l)
print_list(l_copy)


print(l.count(2))
print(l.count(4))


l.extend(l_copy)

print_list(l)


print(l.index(2))
print(l.index(10))
print(l.index(2, 3))


l.insert(0, 9)
print_list(l)


l.pop()
print_list(l)

l.pop(2)
print_list(l)


l.remove(1)
print_list(l)

l.remove(3)
print_list(l)


l.reverse()
print_list(l)


l.sort()
print_list(l)





# dict

# d = { "k": 1 }

