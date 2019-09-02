dofile('./pythonlua/luainit.lua')

local i = 10
while (i > 0) do
    print(i)
    i = (i - 1)
    ::loop_label_11::
end