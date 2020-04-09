# Class 类

## normal class
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def get_x(self):
        return self.x

    def get_y(self):
        return self.y

## normal object
p = Point(5, 10)

assert p.get_x() == 5
assert p.get_y() == 10
assert p.x == 5
assert p.y == 10


## class attribute
class Dog:
    species = 'mammal'

    def __init__(self, name, age):
        self.name = name
        self.age = age

d = Dog('roster', 18)

assert Dog.species == 'mammal'
assert d.name == 'roster'
assert d.age == 18


## inheritance
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
        
    def talk(self):
        return "person talks"

class Chinese(Person):
    def __init__(self, name, age, country):
        # use parent class constructor
        Person.__init__(self, name, age)
        self.country = country
        
    # add new method in subclass
    def walk(self):
        return "chinese walks"

class American(Person):
    # substitute parent class method
    def talk(self):
        return "I love talk show"

## TODO: super()

c = Chinese('john', 18, 'China')

assert c.name == 'john'
assert c.age == 18
assert c.country == 'China'
assert c.talk() == "person talks"
assert c.walk() == "chinese walks"

a = American('jane', 24)

assert a.name == 'jane'
assert a.age == 24
assert a.talk() == "I love talk show"




## Multiple inheritance

## Mix-ins

## Abstract classes

## composition


#FIXME:
#the rule of closure and variable strace is different in lua and python

#因为在 lua 中，类的定义用匿名函数来代替，所以在定义的时候，已经绑定了变量追寻的作用域。
#比如，如果下面把 Course 放在最下面，在类 Department 的 add_course 方法中就会找不到
#Course 的定义。

#下面的顺序是按照顺序安排好的，可以让彼此引用到彼此。
#如果出现交叉引用，那还暂时没有办法解决。

