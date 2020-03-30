local b = 0
if bool({}, true) then
    b = 1
end
assert(bool({}, (b == 1)))
if bool({}, (false or 0 or "" or nil)) then
    assert(bool({}, false), "this line shouldn't be executed.")
end
b = 0
if bool({}, (b == 0)) then
    b = 1
else
    b = 2
end
assert(bool({}, (b == 1)))
if bool({}, (b == 0)) then
    b = 1
else
    b = 2
end
assert(bool({}, (b == 2)))
b = 0
if bool({}, (b == 0)) then
    b = 1
elseif bool({}, (b == 1)) then
    b = 2
end
assert(bool({}, (b == 1)))
if bool({}, (b == 0)) then
    b = 1
elseif bool({}, (b == 1)) then
    b = 2
end
assert(bool({}, (b == 2)))
b = 0
if bool({}, (b == 0)) then
    b = 1
elseif bool({}, (b == 1)) then
    b = 2
else
    b = 3
end
assert(bool({}, (b == 1)))
if bool({}, (b == 0)) then
    b = 1
elseif bool({}, (b == 1)) then
    b = 2
else
    b = 3
end
assert(bool({}, (b == 2)))
if bool({}, (b == 0)) then
    b = 1
elseif bool({}, (b == 1)) then
    b = 2
else
    b = 3
end
assert(bool({}, (b == 3)))
return {
    b = b,
}
