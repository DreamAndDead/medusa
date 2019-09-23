dofile('./pypolyfill.lua')

local function print_list(l)
    for e in l do
        print(e)
    end
end
local l = list {1, 2, 3}
print_list(l)
l[0] = 10
print_list(l)
l.append(4)
print_list(l)
local l_copy = l.copy()
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
local function print_dict(d)
    for k, v in d.items() do
        print(k)
        print(v)
    end
end
local d = dict {["name"] = "d", ["size"] = 8}
print_dict(d)
local d_copy = d.copy()
d_copy["name"] = "d_copy"
print_dict(d)
print_dict(d_copy)
local f = d.fromkeys(list {"a", "b"}, 2)
print_dict(f)
print(d.get("name"))
print(d.get("age", 18))
for k, v in d.items() do
    print(k)
    print(v)
end
for k in d.keys() do
    print(k)
end
local v = d.pop("name")
print(v)
v = d.pop("age", 18)
print(v)
d["tel"] = "+86"
d["age"] = 81
local k, v = d.popitem()
print(k)
print(v)
v = d.setdefault("tel", "+00")
print(v)
v = d.setdefault("home", "cn")
print(v)
d.update(dict {["tel"] = "+186...", ["home"] = "us", ["height"] = 180})
print(d["tel"])
print(d["height"])
