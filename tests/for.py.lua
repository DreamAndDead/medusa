local n = 0
for _, i in list {_to_null(1, 2, 3)} do
    n = (n + 1)
    assert((i == n))
end
local d = dict {[_to_null(1)] = _to_null(1), [_to_null(2)] = _to_null(2), [_to_null(3)] = _to_null(3)}
for _, k, v in d.items() do
    assert((k == v))
end
n = 0
for _, i in range(10) do
    assert((i == n))
    n = (n + 1)
end
assert((n == 10))
n = 1
for _, i in range(1, 5) do
    assert((i == n))
    n = (n + 1)
end
assert((n == 5))
n = 1
for _, i in range(1, 10, 2) do
    assert((i == n))
    n = (n + 2)
end
assert((n == 11))
n = 10
for _, i in range(10, 1, (-2)) do
    assert((i == n))
    n = (n - 2)
end
assert((n == 0))
