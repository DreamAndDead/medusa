# pythou builtin data structure
# list, dict, set and others
#
# TODO
# - set


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

def print_dict(d):
    for k, v in d.items():
        print(k)
        print(v)

d = { "name": "d", "size": 8 }
print_dict(d)


## d.clear()


d_copy = d.copy()
d_copy["name"] = "d_copy"

print_dict(d)
print_dict(d_copy)


f = d.fromkeys(['a', 'b'], 2)
print_dict(f)


print(d.get("name"))
print(d.get("age", 18))


for k, v in d.items():
    print(k)
    print(v)

    
for k in d.keys():
    print(k)


v = d.pop("name")
print(v)

v = d.pop("age", 18)
print(v)


d["tel"] = "+86"
d["age"] = 81

k, v = d.popitem()
print(k)
print(v)


v = d.setdefault("tel", "+00")
print(v)

v = d.setdefault("home", "cn")
print(v)


d.update({ "tel": "+186...", "home": "us", "height": 180 })
print(d["tel"])
print(d["height"])


## d.values() return a iterator
## for in iter print different order with lua iter





















# set
