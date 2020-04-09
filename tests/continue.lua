for _, i in range(merge_kwargs({}, {}), 20) do
    if bool({}, ((mod_operator(i, 2)) == 0)) then
        goto loop_label_1
    end
    assert(bool({}, ((mod_operator(i, 2)) == 1)))
    for _, j in range(merge_kwargs({}, {}), 30) do
        if bool({}, ((mod_operator(j, 3)) == 0)) then
            goto loop_label_2
        end
        assert(bool({}, ((mod_operator(j, 3)) ~= 0)))
        ::loop_label_2::
    end
    ::loop_label_1::
end
local i = 0
while bool({}, (i < 100)) do
    i = (i + 1)
    if bool({}, ((mod_operator(i, 2)) == 0)) then
        goto loop_label_3
    end
    if bool({}, ((mod_operator(i, 3)) == 0)) then
        goto loop_label_3
    end
    assert(bool({}, ((mod_operator(i, 6)) ~= 0)))
    local j = 0
    while bool({}, (j < 200)) do
        j = (j + 1)
        if bool({}, ((mod_operator(j, 5)) == 0)) then
            goto loop_label_4
        end
        if bool({}, ((mod_operator(j, 7)) == 0)) then
            goto loop_label_4
        end
        assert(bool({}, ((mod_operator(j, 35)) ~= 0)))
        ::loop_label_4::
    end
    ::loop_label_3::
end
return {
    i = i,
    j = j,
}
