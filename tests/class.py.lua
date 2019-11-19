local Point = class(function(Point)
    function Point.__init__(self, x, y)
        self.x = x
        self.y = y
    end
    function Point.get_x(self)
        return self.x
    end
    function Point.get_y(self)
        return self.y
    end
    return Point
end, {}, "Point")
local p = Point(5, 10)
assert((p.get_x() == 5))
assert((p.get_y() == 10))
assert((p.x == 5))
assert((p.y == 10))
local Dog = class(function(Dog)
    Dog.species = "mammal"
    function Dog.__init__(self, name, age)
        self.name = name
        self.age = age
    end
    return Dog
end, {}, "Dog")
local d = Dog("roster", 18)
assert((Dog.species == "mammal"))
assert((d.name == "roster"))
assert((d.age == 18))
local Person = class(function(Person)
    function Person.__init__(self, name, age)
        self.name = name
        self.age = age
    end
    function Person.talk(self)
        return "person talks"
    end
    return Person
end, {}, "Person")
local Chinese = class(function(Chinese)
    function Chinese.__init__(self, name, age, country)
        Person.__init__(self, name, age)
        self.country = country
    end
    function Chinese.walk(self)
        return "chinese walks"
    end
    return Chinese
end, {Person}, "Chinese")
local American = class(function(American)
    function American.talk(self)
        return "I love talk show"
    end
    return American
end, {Person}, "American")
local c = Chinese("john", 18, "China")
assert((c.name == "john"))
assert((c.age == 18))
assert((c.country == "China"))
assert((c.talk() == "person talks"))
assert((c.walk() == "chinese walks"))
local a = American("jane", 24)
assert((a.name == "jane"))
assert((a.age == 24))
assert((a.talk() == "I love talk show"))
