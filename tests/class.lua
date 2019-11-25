local Point = class(function(Point)
    local function __init__(self, x, y)
        self.x = x
        self.y = y
    end
    local function get_x(self)
        return self.x
    end
    local function get_y(self)
        return self.y
    end
    Point.__init__ = __init__
    Point.get_x = get_x
    Point.get_y = get_y
    return Point
end, {}, "Point")
local p = Point(5, 10)
assert((p.get_x() == 5))
assert((p.get_y() == 10))
assert((p.x == 5))
assert((p.y == 10))
local Dog = class(function(Dog)
    local species = "mammal"
    local function __init__(self, name, age)
        self.name = name
        self.age = age
    end
    Dog.species = species
    Dog.__init__ = __init__
    return Dog
end, {}, "Dog")
local d = Dog("roster", 18)
assert((Dog.species == "mammal"))
assert((d.name == "roster"))
assert((d.age == 18))
local Person = class(function(Person)
    local function __init__(self, name, age)
        self.name = name
        self.age = age
    end
    local function talk(self)
        return "person talks"
    end
    Person.__init__ = __init__
    Person.talk = talk
    return Person
end, {}, "Person")
local Chinese = class(function(Chinese)
    local function __init__(self, name, age, country)
        Person.__init__(self, name, age)
        self.country = country
    end
    local function walk(self)
        return "chinese walks"
    end
    Chinese.__init__ = __init__
    Chinese.walk = walk
    return Chinese
end, {Person}, "Chinese")
local American = class(function(American)
    local function talk(self)
        return "I love talk show"
    end
    American.talk = talk
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
return {
    Point = Point,
    p = p,
    Dog = Dog,
    d = d,
    Person = Person,
    Chinese = Chinese,
    American = American,
    c = c,
    a = a,
}
