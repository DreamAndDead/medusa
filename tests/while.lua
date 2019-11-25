local i = 0
while bool(true) do
    if bool((i > 10)) then
        break
    end
    i = (i + 1)
    ::loop_label_1::
end
assert(bool((i == 11)))
i = 0
while bool((i < 10)) do
    i = (i + 1)
    ::loop_label_2::
end
assert(bool((i == 10)))
return {
    i = i,
}
