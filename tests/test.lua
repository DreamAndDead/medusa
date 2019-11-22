local g = 10
local c = class(function(c)
    local c = 20
    local function f()
        local f = 30
        local function n()
            -- nonlocal
            local function g()

            end
        end
    end
    c.c = c
    c.f = f
    return c
end, {}, "c")
return {
    g = g,
    c = c,
}
