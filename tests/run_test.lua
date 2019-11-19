local code, error_msg = loadfile(arg[1])

if code == nil then
   error("loadfile error: " .. error_msg)
end

local polyfill, e = loadfile('./polyfill.lua')

if polyfill == nil then
   error("load polyfill error: " .. e)
end

local env = polyfill()
setmetatable(env, {__index = _G})
setfenv(code, env)
code()
