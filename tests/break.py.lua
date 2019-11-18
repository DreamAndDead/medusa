dofile('./polyfill/pypolyfill.lua')
local i = 0
while true do
    if (i > 99) then
        break
    end
    i = (i + 1)
end
assert((i == 100))
i = 0
local j = 0
while true do
    while true do
        if (i > 99) then
            break
        end
        i = (i + 1)
    end
    if (j > 49) then
        break
    end
    j = (j + 1)
end
assert((i == 100))
assert((j == 50))
