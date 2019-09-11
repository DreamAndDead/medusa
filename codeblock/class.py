# python class
# ref: https://python-textbok.readthedocs.io/en/1.0/Object_Oriented_Programming.html

## object

class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y
        
    def reset(self):
        self.x = 0
        self.y = 0

p = Point(5, 10)

print(p.x)
print(p.y)

p.reset()

print(p.x)
print(p.y)

p.x = 5
p.y = 10

print(p.x)
print(p.y)


## class attribute

class Dog:
    # class attribute
    species = 'mammal'

    def __init__(self, name, age):
        self.name = name
        self.age = age

a = Dog('roster', 18)

print(Dog.species)
print(a.name)
print(a.age)

## composition

'''
TODO:

the rule of closure and variable strace is different in lua and python

因为在 lua 中，类的定义用匿名函数来代替，所以在定义的时候，已经绑定了变量追寻的作用域。
比如，如果下面把 Course 放在最下面，在类 Department 的 add_course 方法中就会找不到
Course 的定义。

下面的顺序是按照顺序安排好的，可以让彼此引用到彼此。
如果出现交叉引用，那还暂时没有办法解决。
'''

class Student:
    def __init__(self, name, student_number):
        self.name = name
        self.student_number = student_number
        self.classes = []

    def enrol(self, course_running):
        self.classes.append(course_running)
        course_running.add_student(self)


class CourseRunning:
    def __init__(self, course, year):
        self.course = course
        self.year = year
        self.students = []

    def add_student(self, student):
        self.students.append(student)


class Course:
    def __init__(self, description, course_code, credits, department):
        self.description = description
        self.course_code = course_code
        self.credits = credits
        self.department = department

        self.runnings = []

    def add_running(self, year):
        self.runnings.append(CourseRunning(self, year))
        return self.runnings[-1]


class Department:
    def __init__(self, name, department_code):
        self.name = name
        self.department_code = department_code
        self.courses = {}

    def add_course(self, description, course_code, credits):
        self.courses[course_code] = Course(description, course_code, credits, self)
        return self.courses[course_code]



maths_dept = Department("Mathematics and Applied Mathematics", "MAM")
mam1000w = maths_dept.add_course("Mathematics 1000", "MAM1000W", 1)
mam1000w_2013 = mam1000w.add_running(2013)

bob = Student("Bob", "Smith")
bob.enrol(mam1000w_2013)

for c in bob.classes:
    print(c.year)


## Inheritance

'''
TODO

- super()
'''

class Person:
    def __init__(self, name, surname, number):
        self.name = name
        self.surname = surname
        self.number = number


class Student(Person):
    UNDERGRADUATE, POSTGRADUATE = range(2)

    def __init__(self, student_type, *args, **kwargs):
        self.student_type = student_type
        self.classes = []
#        super(Student, self).__init__(*args, **kwargs)

    def enrol(self, course):
        self.classes.append(course)


class StaffMember(Person):
    PERMANENT, TEMPORARY = range(2)

    def __init__(self, employment_type, *args, **kwargs):
        self.employment_type = employment_type
#        super(StaffMember, self).__init__(*args, **kwargs)


class Lecturer(StaffMember):
    def __init__(self, *args, **kwargs):
        self.courses_taught = []
#        super(Lecturer, self).__init__(*args, **kwargs)

    def assign_teaching(self, course):
        self.courses_taught.append(course)


jane = Student(Student.POSTGRADUATE, "Jane", "Smith", "SMTJNX045")

bob = Lecturer(StaffMember.PERMANENT, "Bob", "Jones", "123456789")


## Multiple inheritance

### Mix-ins

class Person:
    def __init__(self, name, surname, number):
        self.name = name
        self.surname = surname
        self.number = number


class LearnerMixin:
    def __init__(self):
        self.classes = []

    def enrol(self, course):
        self.classes.append(course)


class TeacherMixin:
    def __init__(self):
        self.courses_taught = []

    def assign_teaching(self, course):
        self.courses_taught.append(course)


class Tutor(Person, LearnerMixin, TeacherMixin):
    def __init__(self, *args, **kwargs):
#        super(Tutor, self).__init__(*args, **kwargs)
        pass

jane = Tutor("Jane", "Smith", "SMTJNX045")


## Abstract classes

class Shape2D:
    def area(self):
        pass

class Shape3D:
    def volume(self):
        pass

class Square(Shape2D):
    def __init__(self, width):
        self.width = width

    def area(self):
        return self.width ** 2

s = Square(20)
print(s.area())
