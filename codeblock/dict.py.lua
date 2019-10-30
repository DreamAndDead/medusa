dofile('./polyfill/pypolyfill.lua')
local d = dict {["name"] = "john", [1] = 26, ["age"] = 20}
assert((d["name"] == "john"))
assert((d[1] == 26))
assert((d["age"] == 20))
assert((len(d) == 3))
d = dict {[0] = dict {["a"] = 1, ["b"] = 2}, [1] = dict {["c"] = 3, ["d"] = 4}}
assert((d[0]["a"] == 1))
assert((d[0]["b"] == 2))
assert((d[1]["c"] == 3))
assert((d[1]["d"] == 4))
d.clear()
assert((len(d) == 0))
d = dict {["name"] = "john", [1] = 26, ["age"] = 20}
local m = d.copy()
d["name"] = "jane"
m["age"] = 56
assert((d["age"] == 20))
assert((m["name"] == "john"))
m = d.fromkeys(list {1, 2, "height"})
assert((m[1] == nil))
assert((m[2] == nil))
assert((m["height"] == nil))
m = d.fromkeys(list {1, 2, "height"}, 40)
assert((m[1] == 40))
assert((m[2] == 40))
assert((m["height"] == 40))
d = dict {["name"] = "john", [1] = 26, ["age"] = 20}
assert((d.get("name") == "john"))
assert((d.get("home") == nil))
assert((d.get("home", "cn") == "cn"))
d = dict {["name"] = "john", [1] = 26, ["age"] = 20}
for k, v in d.items() do
    if (k == "name") then
        assert((v == "john"))
    elseif (k == 1) then
        assert((v == 26))
    elseif (k == "age") then
        assert((v == 20))
    end
end
d = dict {["name"] = "john", [1] = 26, ["age"] = 20}
for k in d.keys() do
    assert(((k == "name") or (k == 1) or (k == "age")))
end
d = dict {["name"] = "john", [1] = 26, ["age"] = 20}
assert((d.pop("name") == "john"))
assert((d.pop("name", "jane") == "jane"))
d = dict {["name"] = "john", [1] = 26, ["age"] = 20}
local k, v = d.popitem()
if (k == "name") then
    assert((v == "john"))
elseif (k == 1) then
    assert((v == 26))
elseif (k == "age") then
    assert((v == 20))
end
d = dict {["name"] = "john", [1] = 26, ["age"] = 20}
local v = d.setdefault("name", "bing")
assert((v == "john"))
assert((d["name"] == "john"))
v = d.setdefault("hair", "black")
assert((v == "black"))
assert((d["hair"] == "black"))
d = dict {["name"] = "john", [1] = 26, ["age"] = 20}
d.update(dict {["age"] = 22, ["hair"] = "blond"})
assert((d["age"] == 22))
assert((d["hair"] == "blond"))
d = dict {["name"] = "john", [1] = 26, ["age"] = 20}
for v in d.values() do
    assert(((v == "john") or (v == 26) or (v == 20)))
end
