dofile('./pythonlua/luainit.lua')

local Animal = class(function(Animal)
    Animal.PLANET = "Earth"
    function Animal.__init__(self, name)
        self.name = name
    end
    function Animal.say_hello(self)
        print((("Hello, my name is: " + self.name) + "!"))
    end
    return Animal
end, {})
local Dog = class(function(Dog)
    function Dog.say_hello(self)
        print((("Hello, my name is: " + self.name) + "!"))
        self.bark()
    end
    function Dog.bark(self)
        print("Bark! Bark! Bark!")
    end
    return Dog
end, {Animal})
local sparky = Animal("Sparky")
local barky = Dog("Barky")
sparky.say_hello()
barky.say_hello()
barky.bark()
print("Animal.PLANET = ", Animal.PLANET)
print("sparky.PLANET = ", sparky.PLANET)
print("barky.PLANET = ", barky.PLANET)
Animal.PLANET = "Mars"
print("Animal.PLANET = ", Animal.PLANET)
print("sparky.PLANET = ", sparky.PLANET)