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
assert(bool((p.get_x() == 5)))
assert(bool((p.get_y() == 10)))
assert(bool((p.x == 5)))
assert(bool((p.y == 10)))
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
assert(bool((Dog.species == "mammal")))
assert(bool((d.name == "roster")))
assert(bool((d.age == 18)))
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
assert(bool((c.name == "john")))
assert(bool((c.age == 18)))
assert(bool((c.country == "China")))
assert(bool((c.talk() == "person talks")))
assert(bool((c.walk() == "chinese walks")))
local a = American("jane", 24)
assert(bool((a.name == "jane")))
assert(bool((a.age == 24)))
assert(bool((a.talk() == "I love talk show")))
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
