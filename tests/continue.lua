for _, i in range(20) do
    if ((math.fmod(i, 2)) == 0) then
        goto loop_label_1
    end
    assert(((math.fmod(i, 2)) == 1))
    for _, j in range(30) do
        if ((math.fmod(j, 3)) == 0) then
            goto loop_label_2
        end
        assert(((math.fmod(j, 3)) ~= 0))
        ::loop_label_2::
    end
    ::loop_label_1::
end
local i = 0
while (i < 100) do
    i = (i + 1)
    if ((math.fmod(i, 2)) == 0) then
        goto loop_label_3
    end
    if ((math.fmod(i, 3)) == 0) then
        goto loop_label_3
    end
    assert(((math.fmod(i, 6)) ~= 0))
    local j = 0
    while (j < 200) do
        j = (j + 1)
        if ((math.fmod(j, 5)) == 0) then
            goto loop_label_4
        end
        if ((math.fmod(j, 7)) == 0) then
            goto loop_label_4
        end
        assert(((math.fmod(j, 35)) ~= 0))
        ::loop_label_4::
    end
    ::loop_label_3::
end
return {
    i = i,
    j = j,
}
