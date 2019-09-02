dofile('./pythonlua/luainit.lua')

local book = dict {["title"] = "Harry Potter and the philosopher's stone", ["author"] = "J. K. Rowling", ["year"] = 1997}
local k = 0
for i in book do
    k = (k + 1)
    if (k > 1) then
        break
    end
    ::loop_label_6::
end
for i in book do
    ::loop_label_7::
end