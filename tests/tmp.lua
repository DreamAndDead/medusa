local function add(kvs, ...)
    local a = list({}, {...})
    local t = 0
    for _, i in a do
        t = (t + i)
        ::loop_label_1::
    end
    return t
end
local p = list({}, {_to_null(1, 2, 3, 4)})
assert(bool({}, (add(merge_kwargs({}, {}), unpack(p)) == 10)))
return {
    add = add,
    p = p,
}
