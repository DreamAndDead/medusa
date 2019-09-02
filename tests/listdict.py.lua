dofile('./pythonlua/luainit.lua')

local a = list {1, 2, 5}
local b = list {list {1, 2, 3}, list {4, 5, 6}, list {7, 8, 9}}
local c = dict {["firstname"] = "John", ["lastname"] = "Doe", ["age"] = 42, ["children"] = list {dict {["name"] = "Sara", ["age"] = 4}}}
print(a[2])
print(b[1][2])
print(c["firstname"], c["lastname"])
local ch = c["children"][1]
print(ch["name"], ch["age"])