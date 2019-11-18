dofile('./polyfill/pypolyfill.lua')
local b = 0
if true then
    b = 1
end
assert((b == 1))
b = 0
if (b == 0) then
    b = 1
else
    b = 2
end
assert((b == 1))
if (b == 0) then
    b = 1
else
    b = 2
end
assert((b == 2))
b = 0
if (b == 0) then
    b = 1
elseif (b == 1) then
    b = 2
end
assert((b == 1))
if (b == 0) then
    b = 1
elseif (b == 1) then
    b = 2
end
assert((b == 2))
b = 0
if (b == 0) then
    b = 1
elseif (b == 1) then
    b = 2
else
    b = 3
end
assert((b == 1))
if (b == 0) then
    b = 1
elseif (b == 1) then
    b = 2
else
    b = 3
end
assert((b == 2))
if (b == 0) then
    b = 1
elseif (b == 1) then
    b = 2
else
    b = 3
end
assert((b == 3))
