local i = 0
while true do
    if (i > 99) then
        break
    end
    i = (i + 1)
    ::loop_label_1::
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
        ::loop_label_3::
    end
    if (j > 49) then
        break
    end
    j = (j + 1)
    ::loop_label_2::
end
assert((i == 100))
assert((j == 50))
return {
    i = i,
    j = j,
}
