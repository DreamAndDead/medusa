assert(bool({}, (("begin" + "end") == "beginend")))
--[[
# in python, these sentences below cause exception
assert 'begin' + 1 != 'begin1'
assert 'begin' + None != 'begin'
assert 'begin' + a != 'begin'
]]
local s = (mod_operator("%s %d", "hello", 10))
assert(bool({}, (s == "hello 10")))
return {
    s = s,
}
