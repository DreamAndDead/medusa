dofile('./pythonlua/luainit.lua')

for i in range(10) do
    if (i == 5) then
        goto loop_label_3
    end
    for j in range(10) do
        if (j == 7) then
            goto loop_label_4
        end
        print(i, " * ", j, " = ", (i * j))
        ::loop_label_4::
    end
    ::loop_label_3::
end