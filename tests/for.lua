local n = 0
for _, i in list {_to_null(1, 2, 3)} do
    n = (n + 1)
    assert((i == n))
    ::loop_label_1::
end
local d = dict {[_to_null(1)] = _to_null(1), [_to_null(2)] = _to_null(2), [_to_null(3)] = _to_null(3)}
for _, k, v in d.items() do
    assert((k == v))
    ::loop_label_2::
end
n = 0
for _, i in range(10) do
    assert((i == n))
    n = (n + 1)
    ::loop_label_3::
end
assert((n == 10))
n = 1
for _, i in range(1, 5) do
    assert((i == n))
    n = (n + 1)
    ::loop_label_4::
end
assert((n == 5))
n = 1
for _, i in range(1, 10, 2) do
    assert((i == n))
    n = (n + 2)
    ::loop_label_5::
end
assert((n == 11))
n = 10
for _, i in range(10, 1, (-2)) do
    assert((i == n))
    n = (n - 2)
    ::loop_label_6::
end
assert((n == 0))
return {
    n = n,
    d = d,
}
