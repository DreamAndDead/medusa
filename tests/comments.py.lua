dofile('./pythonlua/luainit.lua')

--[[ Documentation comments test ]]
local Animal = class(function(Animal)
    --[[ Class-level docstring ]]
    return Animal
end, {})
local function foo()
    --[[ Function-level docstring ]]
end
local name = ("John " + "Parrish")
print(name)
print("Hello!")