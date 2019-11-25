local i = 0
while true do
    if (i > 10) then
        break
    end
    i = (i + 1)
    ::loop_label_1::
end
assert((i == 11))
i = 0
while (i < 10) do
    i = (i + 1)
    ::loop_label_2::
end
assert((i == 10))
return {
    i = i,
}
