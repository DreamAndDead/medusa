dofile('./polyfill/pypolyfill.lua')
local Point = class(function(Point)
    function Point.__init__(self, x, y)
        self.x = x
        self.y = y
    end
    function Point.reset(self)
        self.x = 0
        self.y = 0
    end
    return Point
end, {})
local p = Point(5, 10)
print(p.x)
print(p.y)
p.reset()
print(p.x)
print(p.y)
p.x = 5
p.y = 10
print(p.x)
print(p.y)
local Dog = class(function(Dog)
    Dog.species = "mammal"
    function Dog.__init__(self, name, age)
        self.name = name
        self.age = age
    end
    return Dog
end, {})
local a = Dog("roster", 18)
print(Dog.species)
print(a.name)
print(a.age)
--[[
TODO:

the rule of closure and variable strace is different in lua and python

因为在 lua 中，类的定义用匿名函数来代替，所以在定义的时候，已经绑定了变量追寻的作用域。
比如，如果下面把 Course 放在最下面，在类 Department 的 add_course 方法中就会找不到
Course 的定义。

下面的顺序是按照顺序安排好的，可以让彼此引用到彼此。
如果出现交叉引用，那还暂时没有办法解决。
]]
--[[
TODO

- super()
]]
