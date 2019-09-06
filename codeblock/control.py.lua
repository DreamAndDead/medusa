dofile('/home/manjaro/project/python-lua/pythonlua/luainit.lua')

for i in range(1, 10) do
    print(i)
end
for i in list {1, 2, 3} do
    print(i)
end
for i, v in enumerate(list {1, 2, 3}) do
    print(i)
    print(v)
end
for i in range(1, 10, 2) do
    print(i)
    if (i > 5) then
        break
    end
end
if true then
    print("true")
end
if true then
    print("true")
else
    print("false")
end
if 1 then
    print(1)
elseif 2 then
    print(2)
elseif 3 then
    print(3)
else
    print(4)
end
if 1 then
    print(1)
elseif 2 then
    print(2)
elseif 3 then
    print(3)
else
    print(4)
end
local res = true and "win" or "lose"
print(res)
local n = 0
while (n < 10) do
    n = (n + 1)
    print(n)
end
n = 0
while true do
    n = (n + 1)
    print(n)
    if (n > 10) then
        break
    end
end
