dofile('./pythonlua/luainit.lua')

local function factorial(value)
    return (value == 0) and 1 or (value * factorial((value - 1)))
end
print(factorial(5))
print(factorial(10))
print(factorial(3))
print(factorial(0))