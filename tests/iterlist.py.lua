dofile('./pythonlua/luainit.lua')

local a = list {1, 4, 8, 16, 52, 34, 78, 342}
local k = 0
local strange_sum = 0
for i in a do
    k = (k + 1)
    if (k > 3) then
        break
    end
    print("Current i is: ", i)
    strange_sum = (strange_sum + i)
    ::loop_label_1::
end
print("After break: ")
for i in a do
    print("Current i is: ", i)
    strange_sum = (strange_sum + i)
    ::loop_label_2::
end
print("Some strange sum is: ", strange_sum)