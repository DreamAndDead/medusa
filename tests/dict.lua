local d = dict({}, {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20), [_to_null(nil)] = _to_null(nil)})
assert(bool({}, (d[_to_null("name")] == "john")))
assert(bool({}, (d[_to_null(1)] == 26)))
assert(bool({}, (d[_to_null("age")] == 20)))
assert(bool({}, (d[_to_null(nil)] == nil)))
assert(bool({}, (len(merge_kwargs({}, {}), d) == 4)))
d = dict({}, {[_to_null(0)] = _to_null(dict({}, {[_to_null("a")] = _to_null(1), [_to_null("b")] = _to_null(2)})), [_to_null(1)] = _to_null(dict({}, {[_to_null("c")] = _to_null(3), [_to_null("d")] = _to_null(4)})), [_to_null(nil)] = _to_null(dict({}, {[_to_null(nil)] = _to_null(nil)}))})
assert(bool({}, (d[_to_null(0)][_to_null("a")] == 1)))
assert(bool({}, (d[_to_null(0)][_to_null("b")] == 2)))
assert(bool({}, (d[_to_null(1)][_to_null("c")] == 3)))
assert(bool({}, (d[_to_null(1)][_to_null("d")] == 4)))
assert(bool({}, (d[_to_null(nil)][_to_null(nil)] == nil)))
d.clear(merge_kwargs({}, {}))
assert(bool({}, (len(merge_kwargs({}, {}), d) == 0)))
d = dict({}, {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20), [_to_null(nil)] = _to_null(nil)})
local m = d.copy(merge_kwargs({}, {}))
d[_to_null("name")] = "jane"
d[_to_null(nil)] = "nil"
m[_to_null("age")] = 56
assert(bool({}, (d[_to_null("age")] == 20)))
assert(bool({}, (d[_to_null(nil)] == "nil")))
assert(bool({}, (m[_to_null("name")] == "john")))
assert(bool({}, (m[_to_null(nil)] == nil)))
m = d.fromkeys(merge_kwargs({}, {}), list({}, {_to_null(1, 2, "height", nil)}))
assert(bool({}, (m[_to_null(1)] == nil)))
assert(bool({}, (m[_to_null(2)] == nil)))
assert(bool({}, (m[_to_null("height")] == nil)))
assert(bool({}, (m[_to_null(nil)] == nil)))
m = d.fromkeys(merge_kwargs({}, {}), list({}, {_to_null(1, 2, "height", nil)}), 40)
assert(bool({}, (m[_to_null(1)] == 40)))
assert(bool({}, (m[_to_null(2)] == 40)))
assert(bool({}, (m[_to_null("height")] == 40)))
assert(bool({}, (m[_to_null(nil)] == 40)))
d = dict({}, {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)})
assert(bool({}, (d.get(merge_kwargs({}, {}), "name") == "john")))
assert(bool({}, (d.get(merge_kwargs({}, {}), "home") == nil)))
assert(bool({}, (d.get(merge_kwargs({}, {}), "home", "cn") == "cn")))
d = dict({}, {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)})
for _, k, v in d.items(merge_kwargs({}, {})) do
    if bool({}, (k == "name")) then
        assert(bool({}, (v == "john")))
    elseif bool({}, (k == 1)) then
        assert(bool({}, (v == 26)))
    elseif bool({}, (k == "age")) then
        assert(bool({}, (v == 20)))
    end
    ::loop_label_1::
end
d = dict({}, {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)})
for _, k in d.keys(merge_kwargs({}, {})) do
    assert(bool({}, ((k == "name") or (k == 1) or (k == "age"))))
    ::loop_label_2::
end
d = dict({}, {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)})
assert(bool({}, (d.pop(merge_kwargs({}, {}), "name") == "john")))
assert(bool({}, (d.pop(merge_kwargs({}, {}), "name", "jane") == "jane")))
d = dict({}, {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)})
local k, v = d.popitem(merge_kwargs({}, {}))
if bool({}, (k == "name")) then
    assert(bool({}, (v == "john")))
elseif bool({}, (k == 1)) then
    assert(bool({}, (v == 26)))
elseif bool({}, (k == "age")) then
    assert(bool({}, (v == 20)))
end
d = dict({}, {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)})
local v = d.setdefault(merge_kwargs({}, {}), "name", "bing")
assert(bool({}, (v == "john")))
assert(bool({}, (d[_to_null("name")] == "john")))
v = d.setdefault(merge_kwargs({}, {}), "hair", "black")
assert(bool({}, (v == "black")))
assert(bool({}, (d[_to_null("hair")] == "black")))
d = dict({}, {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)})
d.update(merge_kwargs({}, {}), dict({}, {[_to_null("age")] = _to_null(22), [_to_null("hair")] = _to_null("blond")}))
assert(bool({}, (d[_to_null("age")] == 22)))
assert(bool({}, (d[_to_null("hair")] == "blond")))
d = dict({}, {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)})
for _, v in d.values(merge_kwargs({}, {})) do
    assert(bool({}, ((v == "john") or (v == 26) or (v == 20))))
    ::loop_label_3::
end
d = dict({}, {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)})
assert(bool({}, (operator_in("name", d))))
assert(bool({}, (not operator_in("height", d))))
return {
    d = d,
    m = m,
    k, v = k, v,
    v = v,
}
