dofile('./pythonlua/luainit.lua')

for i in range(10) do
    print(i)
    ::loop_label_5::
end
local k = list {1, 2, 3}
print(len(k))