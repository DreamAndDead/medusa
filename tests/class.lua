local Point = class(function(Point)
    local function __init__(kvs, self, x, y)
        self = get_posarg(kvs, 'self', self, nil, '__init__')
        x = get_posarg(kvs, 'x', x, nil, '__init__')
        y = get_posarg(kvs, 'y', y, nil, '__init__')
        self.x = x
        self.y = y
    end
    local function get_x(kvs, self)
        self = get_posarg(kvs, 'self', self, nil, 'get_x')
        return self.x
    end
    local function get_y(kvs, self)
        self = get_posarg(kvs, 'self', self, nil, 'get_y')
        return self.y
    end
    Point.__init__ = __init__
    Point.get_x = get_x
    Point.get_y = get_y
    return Point
end, {}, "Point")
local p = Point(merge_kwargs({}, {}), 5, 10)
assert(bool({}, (p.get_x(merge_kwargs({}, {})) == 5)))
assert(bool({}, (p.get_y(merge_kwargs({}, {})) == 10)))
assert(bool({}, (p.x == 5)))
assert(bool({}, (p.y == 10)))
local Dog = class(function(Dog)
    local species = "mammal"
    local function __init__(kvs, self, name, age)
        self = get_posarg(kvs, 'self', self, nil, '__init__')
        name = get_posarg(kvs, 'name', name, nil, '__init__')
        age = get_posarg(kvs, 'age', age, nil, '__init__')
        self.name = name
        self.age = age
    end
    Dog.species = species
    Dog.__init__ = __init__
    return Dog
end, {}, "Dog")
local d = Dog(merge_kwargs({}, {}), "roster", 18)
assert(bool({}, (Dog.species == "mammal")))
assert(bool({}, (d.name == "roster")))
assert(bool({}, (d.age == 18)))
local Person = class(function(Person)
    local function __init__(kvs, self, name, age)
        self = get_posarg(kvs, 'self', self, nil, '__init__')
        name = get_posarg(kvs, 'name', name, nil, '__init__')
        age = get_posarg(kvs, 'age', age, nil, '__init__')
        self.name = name
        self.age = age
    end
    local function talk(kvs, self)
        self = get_posarg(kvs, 'self', self, nil, 'talk')
        return "person talks"
    end
    Person.__init__ = __init__
    Person.talk = talk
    return Person
end, {}, "Person")
local Chinese = class(function(Chinese)
    local function __init__(kvs, self, name, age, country)
        self = get_posarg(kvs, 'self', self, nil, '__init__')
        name = get_posarg(kvs, 'name', name, nil, '__init__')
        age = get_posarg(kvs, 'age', age, nil, '__init__')
        country = get_posarg(kvs, 'country', country, nil, '__init__')
        Person.__init__(merge_kwargs({}, {}), self, name, age)
        self.country = country
    end
    local function walk(kvs, self)
        self = get_posarg(kvs, 'self', self, nil, 'walk')
        return "chinese walks"
    end
    Chinese.__init__ = __init__
    Chinese.walk = walk
    return Chinese
end, {Person}, "Chinese")
local American = class(function(American)
    local function talk(kvs, self)
        self = get_posarg(kvs, 'self', self, nil, 'talk')
        return "I love talk show"
    end
    American.talk = talk
    return American
end, {Person}, "American")
local c = Chinese(merge_kwargs({}, {}), "john", 18, "China")
assert(bool({}, (c.name == "john")))
assert(bool({}, (c.age == 18)))
assert(bool({}, (c.country == "China")))
assert(bool({}, (c.talk(merge_kwargs({}, {})) == "person talks")))
assert(bool({}, (c.walk(merge_kwargs({}, {})) == "chinese walks")))
local a = American(merge_kwargs({}, {}), "jane", 24)
assert(bool({}, (a.name == "jane")))
assert(bool({}, (a.age == 24)))
assert(bool({}, (a.talk(merge_kwargs({}, {})) == "I love talk show")))
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
