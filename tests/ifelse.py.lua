dofile('./pythonlua/luainit.lua')

local a = 45
local b = 0
if ((a > 5) and (b < 34)) then
    print("a > 5")
    if (a >= 45) then
        print("a >= 45")
    else
        print("a < 45")
    end
elseif (a < 5) then
    print("a < 5")
else
    print("a == 5")
end
if (a == 45) then
    print("a == 45")
end
local x = 100
if (50 < x and x < 150) then
    print("50 < x < 150")
else
    print("Something wrong.")
end