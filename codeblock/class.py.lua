dofile('./pypolyfill.lua')

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
local Student = class(function(Student)
    function Student.__init__(self, name, student_number)
        self.name = name
        self.student_number = student_number
        self.classes = list {}
    end
    function Student.enrol(self, course_running)
        self.classes.append(course_running)
        course_running.add_student(self)
    end
    return Student
end, {})
local CourseRunning = class(function(CourseRunning)
    function CourseRunning.__init__(self, course, year)
        self.course = course
        self.year = year
        self.students = list {}
    end
    function CourseRunning.add_student(self, student)
        self.students.append(student)
    end
    return CourseRunning
end, {})
local Course = class(function(Course)
    function Course.__init__(self, description, course_code, credits, department)
        self.description = description
        self.course_code = course_code
        self.credits = credits
        self.department = department
        self.runnings = list {}
    end
    function Course.add_running(self, year)
        self.runnings.append(CourseRunning(self, year))
        return self.runnings[-1]
    end
    return Course
end, {})
local Department = class(function(Department)
    function Department.__init__(self, name, department_code)
        self.name = name
        self.department_code = department_code
        self.courses = dict {}
    end
    function Department.add_course(self, description, course_code, credits)
        self.courses[course_code] = Course(description, course_code, credits, self)
        return self.courses[course_code]
    end
    return Department
end, {})
local maths_dept = Department("Mathematics and Applied Mathematics", "MAM")
local mam1000w = maths_dept.add_course("Mathematics 1000", "MAM1000W", 1)
local mam1000w_2013 = mam1000w.add_running(2013)
local bob = Student("Bob", "Smith")
bob.enrol(mam1000w_2013)
for c in bob.classes do
    print(c.year)
end
--[[
TODO

- super()
]]
local Person = class(function(Person)
    function Person.__init__(self, name, surname, number)
        self.name = name
        self.surname = surname
        self.number = number
    end
    return Person
end, {})
Student = class(function(Student)
    Student.UNDERGRADUATE, POSTGRADUATE = range(2)
    function Student.__init__(self, student_type, ...)
        local args = list {...}
        self.student_type = student_type
        self.classes = list {}
    end
    function Student.enrol(self, course)
        self.classes.append(course)
    end
    return Student
end, {Person})
local StaffMember = class(function(StaffMember)
    StaffMember.PERMANENT, TEMPORARY = range(2)
    function StaffMember.__init__(self, employment_type, ...)
        local args = list {...}
        self.employment_type = employment_type
    end
    return StaffMember
end, {Person})
local Lecturer = class(function(Lecturer)
    function Lecturer.__init__(self, ...)
        local args = list {...}
        self.courses_taught = list {}
    end
    function Lecturer.assign_teaching(self, course)
        self.courses_taught.append(course)
    end
    return Lecturer
end, {StaffMember})
local jane = Student(Student.POSTGRADUATE, "Jane", "Smith", "SMTJNX045")
bob = Lecturer(StaffMember.PERMANENT, "Bob", "Jones", "123456789")
Person = class(function(Person)
    function Person.__init__(self, name, surname, number)
        self.name = name
        self.surname = surname
        self.number = number
    end
    return Person
end, {})
local LearnerMixin = class(function(LearnerMixin)
    function LearnerMixin.__init__(self)
        self.classes = list {}
    end
    function LearnerMixin.enrol(self, course)
        self.classes.append(course)
    end
    return LearnerMixin
end, {})
local TeacherMixin = class(function(TeacherMixin)
    function TeacherMixin.__init__(self)
        self.courses_taught = list {}
    end
    function TeacherMixin.assign_teaching(self, course)
        self.courses_taught.append(course)
    end
    return TeacherMixin
end, {})
local Tutor = class(function(Tutor)
    function Tutor.__init__(self, ...)
        local args = list {...}
    end
    return Tutor
end, {Person, LearnerMixin, TeacherMixin})
jane = Tutor("Jane", "Smith", "SMTJNX045")
local Shape2D = class(function(Shape2D)
    function Shape2D.area(self)

    end
    return Shape2D
end, {})
local Shape3D = class(function(Shape3D)
    function Shape3D.volume(self)

    end
    return Shape3D
end, {})
local Square = class(function(Square)
    function Square.__init__(self, width)
        self.width = width
    end
    function Square.area(self)
        return (math.pow(self.width, 2))
    end
    return Square
end, {Shape2D})
local s = Square(20)
print(s.area())
