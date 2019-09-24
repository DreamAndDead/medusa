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

local function print_list(l)
    for e in l do
        print(e)
    end
end
local l = list {1, 2, 3}
print_list(l)
l[0] = 10
print_list(l)
l.append(4)
print_list(l)
local l_copy = l.copy()
l[0] = 1
print_list(l)
print_list(l_copy)
print(l.count(2))
print(l.count(4))
l.extend(l_copy)
print_list(l)
print(l.index(2))
print(l.index(10))
print(l.index(2, 3))
l.insert(0, 9)
print_list(l)
l.pop()
print_list(l)
l.pop(2)
print_list(l)
l.remove(1)
print_list(l)
l.remove(3)
print_list(l)
l.reverse()
print_list(l)
l.sort()
print_list(l)
local function print_dict(d)
    for k, v in d.items() do
        print(k)
        print(v)
    end
end
local d = dict {["name"] = "d", ["size"] = 8}
print_dict(d)
local d_copy = d.copy()
d_copy["name"] = "d_copy"
print_dict(d)
print_dict(d_copy)
local f = d.fromkeys(list {"a", "b"}, 2)
print_dict(f)
print(d.get("name"))
print(d.get("age", 18))
for k, v in d.items() do
    print(k)
    print(v)
end
for k in d.keys() do
    print(k)
end
local v = d.pop("name")
print(v)
v = d.pop("age", 18)
print(v)
d["tel"] = "+86"
d["age"] = 81
local k, v = d.popitem()
print(k)
print(v)
v = d.setdefault("tel", "+00")
print(v)
v = d.setdefault("home", "cn")
print(v)
d.update(dict {["tel"] = "+186...", ["home"] = "us", ["height"] = 180})
print(d["tel"])
print(d["height"])