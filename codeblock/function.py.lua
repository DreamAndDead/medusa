dofile('/home/manjaro/project/python-lua/pythonlua/luainit.lua')

moveForward(1)
say("hello", 1)
wait(time)
test_args(1, unpack(a))
local function callback(p, q, ...)
    q = q or 2
    local a = list {...}
    --[[
    a call function
    ]]
    print(p, q)
end
callback = http_post(callback)
callback = register("api")(callback)
registerClickEvent(callback)
