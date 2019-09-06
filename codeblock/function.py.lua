dofile('/home/manjaro/project/python-lua/pythonlua/luainit.lua')

local function move(direction, distance)
    --[[move dist to a direction]]
    print("move to direction")
    print(direction)
    print("with distance")
    print(distance)
end
move("north", 10)
local function say(word, time)
    time = time or 2
    --[[say word in time seconds]]
    print(word)
    print("wait")
    print(time)
    print("seconds")
end
say("hello python", 1)
say("hello lua", 2)
local function play(start, finish, ...)
    start = start or 0
    finish = finish or 1000
    local other = list {...}
    print(start)
    print(finish)
    for a in other do
        print(a)
    end
end
play(20, 40, "hello python", "hello lua")
local function plus_factory(plus_num)
    local function plus_func(n)
        return (n + plus_num)
    end
    return plus_func
end
print(plus_factory(10)(1))
local function output_wrapper(func)
    local function wrapper(...)
        local params = list {...}
        print("function start")
        func(unpack(params))
        print("function end")
    end
    return wrapper
end
output_wrapper(play)(10, 20, "total 10 seconds")
local function output_wrapper_with(beginning, finish)
    function output_wrapper(func)
        local function wrapper(...)
            local params = list {...}
            print(beginning)
            func(unpack(params))
            print(finish)
        end
        return wrapper
    end
    return output_wrapper
end
output_wrapper_with("hello every one", "see you again")(play)(1, 99, "all ints below 100")
local function registerClickEvent(callback)
    --[[register click event]]
    local event = dict {["id"] = "click"}
    callback(event)
end
local function callback(event)
    --[[callback function]]
    print(event["id"])
end
registerClickEvent(callback)
