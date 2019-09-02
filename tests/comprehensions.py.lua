dofile('./pythonlua/luainit.lua')

local a = (function() local result = list {} for i in range(5) do for j in range(3) do if (((math.fmod((i * j), 2)) == 0) and (i > 0)) then result.append((i * j)) end end end return result end)()
for item in a do
    print(item)
    ::loop_label_9::
end
local b = (function() local result = dict {} for i in range(5) do result[i] = (math.pow(i, 2)) end return result end)()
for k, v in b.items() do
    print(k, v)
    ::loop_label_10::
end