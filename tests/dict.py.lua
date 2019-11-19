local d = dict {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20), [_to_null(nil)] = _to_null(nil)}
assert((d[_to_null("name")] == "john"))
assert((d[_to_null(1)] == 26))
assert((d[_to_null("age")] == 20))
assert((d[_to_null(nil)] == nil))
assert((len(d) == 4))
d = dict {[_to_null(0)] = _to_null(dict {[_to_null("a")] = _to_null(1), [_to_null("b")] = _to_null(2)}), [_to_null(1)] = _to_null(dict {[_to_null("c")] = _to_null(3), [_to_null("d")] = _to_null(4)}), [_to_null(nil)] = _to_null(dict {[_to_null(nil)] = _to_null(nil)})}
assert((d[_to_null(0)][_to_null("a")] == 1))
assert((d[_to_null(0)][_to_null("b")] == 2))
assert((d[_to_null(1)][_to_null("c")] == 3))
assert((d[_to_null(1)][_to_null("d")] == 4))
assert((d[_to_null(nil)][_to_null(nil)] == nil))
d.clear()
assert((len(d) == 0))
d = dict {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20), [_to_null(nil)] = _to_null(nil)}
local m = d.copy()
d[_to_null("name")] = "jane"
d[_to_null(nil)] = "nil"
m[_to_null("age")] = 56
assert((d[_to_null("age")] == 20))
assert((d[_to_null(nil)] == "nil"))
assert((m[_to_null("name")] == "john"))
assert((m[_to_null(nil)] == nil))
m = d.fromkeys(list {_to_null(1, 2, "height", nil)})
assert((m[_to_null(1)] == nil))
assert((m[_to_null(2)] == nil))
assert((m[_to_null("height")] == nil))
assert((m[_to_null(nil)] == nil))
m = d.fromkeys(list {_to_null(1, 2, "height", nil)}, 40)
assert((m[_to_null(1)] == 40))
assert((m[_to_null(2)] == 40))
assert((m[_to_null("height")] == 40))
assert((m[_to_null(nil)] == 40))
d = dict {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)}
assert((d.get("name") == "john"))
assert((d.get("home") == nil))
assert((d.get("home", "cn") == "cn"))
d = dict {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)}
for _, k, v in d.items() do
    if (k == "name") then
        assert((v == "john"))
    elseif (k == 1) then
        assert((v == 26))
    elseif (k == "age") then
        assert((v == 20))
    end
end
d = dict {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)}
for _, k in d.keys() do
    assert(((k == "name") or (k == 1) or (k == "age")))
end
d = dict {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)}
assert((d.pop("name") == "john"))
assert((d.pop("name", "jane") == "jane"))
d = dict {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)}
local k, v = d.popitem()
if (k == "name") then
    assert((v == "john"))
elseif (k == 1) then
    assert((v == 26))
elseif (k == "age") then
    assert((v == 20))
end
d = dict {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)}
local v = d.setdefault("name", "bing")
assert((v == "john"))
assert((d[_to_null("name")] == "john"))
v = d.setdefault("hair", "black")
assert((v == "black"))
assert((d[_to_null("hair")] == "black"))
d = dict {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)}
d.update(dict {[_to_null("age")] = _to_null(22), [_to_null("hair")] = _to_null("blond")})
assert((d[_to_null("age")] == 22))
assert((d[_to_null("hair")] == "blond"))
d = dict {[_to_null("name")] = _to_null("john"), [_to_null(1)] = _to_null(26), [_to_null("age")] = _to_null(20)}
for _, v in d.values() do
    assert(((v == "john") or (v == 26) or (v == 20)))
end
