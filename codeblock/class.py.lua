--[[
   lua pythonization
--]]

local string_meta = getmetatable("")
string_meta.__add = function(v1, v2)
   if type(v1) == "string" and type(v2) == "string" then
      return v1 .. v2
   end
   return v1 + v2
end

local g_real_unpack = unpack or table.unpack

unpack = function(t)
   if type(t) == "table" and t._is_list then
      return g_real_unpack(t._data)
   end
   return g_real_unpack(t)
end

--[[
builtin functions
ref: https://docs.python.org/3/library/functions.html

- abs
- all
- any
- ascii
- bin
- bool
- breakpoint
- bytearray
- bytes
- callable
- chr
- classmethod
- compile
- complex
- delattr
- dict
- dir
- divmod
- enumerate
- eval
- exec
- filter
- float
- format
- frozenset
- getattr
- globals
- hasattr
- hash
- help
- hex
- id
- input
- int
- isinstance
- issubclass
- iter
- len
- list
- locals
- map
- max
- memoryview
- min
- next
- object
- oct
- open
- ord
- pow
- print
- property
- range
- repr
- reversed
- round
- set
- setattr
- slice
- sorted
- staticmethod
- str
- sum
- super
- tuple
- type
- vars
- zip
- __import__

--]]

abs = math.abs
ascii = string.byte
chr = string.char
int = tonumber
str = tostring

function all(iterable)
   for element in iterable do
      if not element then
         return false
      end
   end
   return true
end

function any(iterable)
   for element in iterable do
      if element then
         return true
      end
   end
   return false
end

function bool(x)
   if x == false or x == nil or x == 0 then
      return false
   end

   if type(x) == "table" then
      if x._is_list or x._is_dict then
         return next(x._data) ~= nil
      end
   end

   return true
end 

function callable(x)
   local x_type = type(x)
   if x_type == "function" then
      return true
   end
   if x_type == "table" then
      local meta = getmetatable(x)
      return type(meta.__call) == "function" 
   end

   return false
end

function divmod(a, b)
   local res = { math.floor(a / b), math.fmod(a, b) }
   return unpack(res)
end

function len(t)
   if type(t._data) == "table" then
      return #t._data
   end

   return #t
end

function range(from, to, step)
   assert(from ~= nil)
   
   if to == nil then
      to = from
      from = 0        
   end

   step = step or 1

   local i = from
   
   return function()
      ret = i
      if (step > 0 and i >= to) or (step < 0 and i <= to) then
         return nil
      end
      
      i = i + step
      return ret
   end
end

function enumerate(t, start)
   start = start or 0

   local data = t
   if t._is_list then
      data = t._data
   end

   local i, v = next(data, nil)
   return function()
      local index, value = i, v
      i, v = next(data, i)

      if index == nil then
         return nil
      end

      return index + start - 1, value
   end
end


--[[
   list structure

   methods:
   - append
   - clear
   - copy
   - count
   - extend
   - index
   - insert
   - pop
   - remove
   - reverse
   - sort

   mock with lua metatable
--]]

list = {}
setmetatable(list, {
                __call = function(_, t)
                   local result = {}

                   result._is_list = true
                   result._data = {}

                   for _, v in ipairs(t) do
                      table.insert(result._data, v)
                   end
                   
                   local methods = {}

                   methods.append = function(value)
                      table.insert(result._data, value)
                   end

                   methods.clear = function()
                      result._data = {}
                   end

                   methods.copy = function()
                      return list(result._data)
                   end

                   methods.count = function(value)
                      local cnt = 0
                      for _, v in ipairs(result._data) do
                         if v == value then
                            cnt = cnt + 1
                         end
                      end

                      return cnt
                   end

                   methods.extend = function(iterable)
                      for value in iterable do
                         table.insert(result._data, value)
                      end
                   end

                   methods.index = function(value, start, end_)
                      start = start or 1
                      end_ = end_ or #result._data

                      for i = start, end_, 1 do
                         if result._data[i] == value then
                            return i - 1
                         end
                      end

                      return nil
                   end

                   methods.insert = function(index, value)
                      table.insert(result._data, index + 1, value)
                   end

                   methods.pop = function(index)
		      if index then
			 index = index + 1
		      else
			 index = #result._data
		      end
		      
                      local value = result._data[index]
                      table.remove(result._data, index)
                      return value
                   end

                   methods.remove = function(value)
                      for i, v in ipairs(result._data) do
                         if value == v then
                            table.remove(result._data, i)
                            break
                         end
                      end
                   end

                   methods.reverse = function()
                      local new_data = {}
                      for i = #result._data, 1, -1 do
                         table.insert(new_data, result._data[i])
                      end

                      result._data = new_data
                   end

                   methods.sort = function(key, reverse)
		      -- TODO: key is a callable
                      key = key or nil
                      reverse = reverse or false

                      table.sort(result._data, function(a, b)
                                    if reverse then
                                       return a > b
                                    end

                                    return a < b
                      end)
                   end

                   local iterator_index = nil

                   setmetatable(result, {
                                   __index = function(self, index)
                                      if type(index) == "number" then
                                         if index < 0 then
                                            index = #result._data + index
                                         end
                                         return rawget(result._data, index + 1)
                                      end

                                      return methods[index]
                                   end,
				   -- only number index is permitted in python
                                   __newindex = function(self, index, value)
                                      rawset(result._data, index + 1, value)
                                   end,
                                   __call = function(self, _, idx)
                                      if idx == nil and iterator_index ~= nil then
                                         iterator_index = nil
                                      end

                                      local v = nil
                                      iterator_index, v = next(result._data, iterator_index)

                                      return v
                                   end,
                   })

                   return result
                end,
})



--[[
tuple
--]]




--[[
dict structure

methods:
- clear
- copy
- fromkeys
- get
- items
- keys
- pop
- popitem
- setdefault
- update
- values
--]]

dict = {}
setmetatable(dict, {
		__call = function(_, t)
		   local result = {}

		   result._is_dict = true
		   result._data = {}

		   for k, v in pairs(t) do
		      result._data[k] = v
		   end

		   local methods = {}

		   local key_index = nil

		   methods.clear = function()
		      result._data = {}
		   end

		   methods.copy = function()
		      return dict(result._data)
		   end

		   methods.fromkeys = function(keys, value)
		      value = value or nil
		      d = {}
		      for k in keys do
			 d[k] = value
		      end

		      return dict(d)
		   end
		   
		   methods.get = function(key, default)
		      default = default or nil
		      if result._data[key] == nil then
			 return default
		      end

		      return result._data[key]
		   end

		   methods.items = function()
		      return pairs(result._data)
		   end

		   methods.keys = function()
		      return function(self, idx, _) 
			 if idx == nil and key_index ~= nil then
			    key_index = nil
			 end

			 key_index, _ = next(result._data, key_index)
			 return key_index
		      end
		   end

		   methods.pop = function(key, default)
		      default = default or nil
		      if result._data[key] ~= nil then
			 local value = result._data[key]
			 result._data[key] = nil 
			 return value
		      end

		      return default
		   end

		   -- amazing! the python pop seq is same with lua table!
		   methods.popitem = function()
		      local key, value = next(result._data)
		      if key ~= nil then
			 result._data[key] = nil
		      end

		      return key, value
		   end

		   methods.setdefault = function(key, default)
		      if result._data[key] == nil then
			 result._data[key] = default
		      end

		      return result._data[key]
		   end

		   methods.update = function(t)
		      assert(t._is_dict)

		      for k, v in t.items() do
			 result._data[k] = v
		      end
		   end

		   methods.values = function()
		      return function(self, idx, _) 
			 if idx == nil and key_index ~= nil then
			    key_index = nil
			 end

			 key_index, value = next(result._data, key_index)
			 return value
		      end
		   end
		   
		   setmetatable(result, {
				   __index = function(self, index)
				      if result._data[index] ~= nil then
					 return result._data[index]
				      end
				      return methods[index]
				   end,
				   __newindex = function(self, index, value)
				      result._data[index] = value
				   end,
				   __call = function(self, _, idx)
				      if idx == nil and key_index ~= nil then
					 key_index = nil
				      end

				      key_index, _ = next(result._data, key_index)

				      return key_index            
				   end,
		   })
		   
		   return result
		end,
})

--[[
set structure
ref: https://docs.python.org/3/library/stdtypes.html#set-types-set-frozenset

- add
- clear
- copy
- difference
- difference_update
- discard
- intersection
- intersection_update
- isdisjoint
- issubset
- issuperset
- pop
- remove
- symmetric_difference
- symmetric_difference_update
- union
- update

--]]

set = {}
setmetatable(set, {
		__call = function(_, t)
		   local result = {}

		   result._is_set = true
		   result.data = {}

		   local methods = {}

		   methods.clear = function()
		   end
		   
		end

		
})


--[[
frozenset
--]]



function staticmethod(old_fun)
   local wrapper = function(first, ...)
      return old_fun(...)
   end

   return wrapper
end

function operator_in(item, items)
   if type(items) == "table" then
      for v in items do
	 if v == item then
	    return true
	 end
      end
   elseif type(items) == "string" and type(item) == "string" then
      return string.find(items, item, 1, true) ~= nil
   end

   return false
end




--[[
classes

TODO：
- inherit
- base object，全部的类都继承于它
- magic methods
- MRO机制
- metaclass
- @property, @staticmethod, @classmethod
- super()
--]]

function super(cls, obj)
end

function class(class_init, bases)
   bases = bases or {}

   local c = {}
   
   for _, base in ipairs(bases) do
      for k, v in pairs(base) do
	 c[k] = v
      end
   end

   c._bases = bases
   
   c = class_init(c)
   
   local mt = getmetatable(c) or {}
   mt.__call = function(_, ...)
      local object = {}
      
      setmetatable(object, {
		      __index = function(tbl, idx)
			 local method = c[idx]
			 if type(method) == "function" then
			    return function(...)
			       return c[idx](object, ...) 
			    end
			 end
			 
			 return method
		      end,
      })
      
      if type(object.__init__) == "function" then
	 object.__init__(...)
      end
      
      return object
   end
   
   setmetatable(c, mt)
   
   return c
end

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
