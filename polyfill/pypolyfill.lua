--[[---------------
   LuaBit v0.4
   -------------------
   a bitwise operation lib for lua.

   http://luaforge.net/projects/bit/

   How to use:
   -------------------
   bit.bnot(n) -- bitwise not (~n)
   bit.band(m, n) -- bitwise and (m & n)
   bit.bor(m, n) -- bitwise or (m | n)
   bit.bxor(m, n) -- bitwise xor (m ^ n)
   bit.brshift(n, bits) -- right shift (n >> bits)
   bit.blshift(n, bits) -- left shift (n << bits)
   bit.blogic_rshift(n, bits) -- logic right shift(zero fill >>>)
   
   Please note that bit.brshift and bit.blshift only support number within
   32 bits.

   2 utility functions are provided too:
   bit.tobits(n) -- convert n into a bit table(which is a 1/0 sequence)
   -- high bits first
   bit.tonumb(bit_tbl) -- convert a bit table into a number 
   -------------------

   Under the MIT license.

   copyright(c) 2006~2007 hanzhao (abrash_han@hotmail.com)
--]]---------------

------------------------
-- bit lib implementions

local function check_int(n)
   -- checking not float
   if(n - math.floor(n) > 0) then
      error("trying to use bitwise operation on non-integer!")
   end
end

local function to_bits(n)
   check_int(n)
   if(n < 0) then
      -- negative
      print(n)
      return to_bits(bit.bnot(math.abs(n)) + 1)
   end
   -- to bits table
   local tbl = {}
   local cnt = 1
   while (n > 0) do
      local last = math.mod(n,2)
      if(last == 1) then
	 tbl[cnt] = 1
      else
	 tbl[cnt] = 0
      end
      n = (n-last)/2
      cnt = cnt + 1
   end

   return tbl
end

local function tbl_to_number(tbl)
   local n = table.getn(tbl)

   local rslt = 0
   local power = 1
   for i = 1, n do
      if i == 32 then
	 rslt = rslt - tbl[i]*power
      else
	 rslt = rslt + tbl[i]*power
      end
      
      power = power*2
   end
   
   return rslt
end

local function expand(tbl_m, tbl_n)
   local big = {}
   local small = {}
   if(table.getn(tbl_m) > table.getn(tbl_n)) then
      big = tbl_m
      small = tbl_n
   else
      big = tbl_n
      small = tbl_m
   end
   -- expand small
   for i = table.getn(small) + 1, table.getn(big) do
      small[i] = 0
   end

end

local function bit_or(m, n)
   local tbl_m = to_bits(m)
   local tbl_n = to_bits(n)
   expand(tbl_m, tbl_n)

   local tbl = {}
   local rslt = math.max(table.getn(tbl_m), table.getn(tbl_n))
   for i = 1, rslt do
      if(tbl_m[i]== 0 and tbl_n[i] == 0) then
	 tbl[i] = 0
      else
	 tbl[i] = 1
      end
   end
   
   return tbl_to_number(tbl)
end

local function bit_and(m, n)
   local tbl_m = to_bits(m)
   local tbl_n = to_bits(n)
   expand(tbl_m, tbl_n) 

   local tbl = {}
   local rslt = math.max(table.getn(tbl_m), table.getn(tbl_n))
   for i = 1, rslt do
      if(tbl_m[i]== 0 or tbl_n[i] == 0) then
	 tbl[i] = 0
      else
	 tbl[i] = 1
      end
   end

   return tbl_to_number(tbl)
end

local function bit_not(n)
   
   local tbl = to_bits(n)
   local size = math.max(table.getn(tbl), 32)
   for i = 1, size do
      if(tbl[i] == 1) then 
	 tbl[i] = 0
      else
	 tbl[i] = 1
      end
   end
   return tbl_to_number(tbl)
end

local function bit_xor(m, n)
   local tbl_m = to_bits(m)
   local tbl_n = to_bits(n)
   expand(tbl_m, tbl_n) 

   local tbl = {}
   local rslt = math.max(table.getn(tbl_m), table.getn(tbl_n))
   for i = 1, rslt do
      if(tbl_m[i] ~= tbl_n[i]) then
	 tbl[i] = 1
      else
	 tbl[i] = 0
      end
   end
   
   --table.foreach(tbl, print)

   return tbl_to_number(tbl)
end

local function bit_rshift(n, bits)
   check_int(n)
   
   local high_bit = 0
   if(n < 0) then
      -- negative
      n = bit_not(math.abs(n)) + 1
      high_bit = 2147483648 -- 0x80000000
   end

   for i=1, bits do
      n = n/2
      n = bit_or(math.floor(n), high_bit)
   end
   return math.floor(n)
end

-- logic rightshift assures zero filling shift
local function bit_logic_rshift(n, bits)
   check_int(n)
   if(n < 0) then
      -- negative
      n = bit_not(math.abs(n)) + 1
   end
   for i=1, bits do
      n = n/2
   end
   return math.floor(n)
end

local function bit_lshift(n, bits)
   check_int(n)
   
   if(n < 0) then
      -- negative
      n = bit_not(math.abs(n)) + 1
   end

   for i=1, bits do
      n = n*2
   end
   return bit_and(n, 4294967295) -- 0xFFFFFFFF
end

local function bit_xor2(m, n)
   local rhs = bit_or(bit_not(m), bit_not(n))
   local lhs = bit_or(m, n)
   local rslt = bit_and(lhs, rhs)
   return rslt
end

------------------------
-- bit lib interface

bit = {
   -- bit operations
   bnot = bit_not,
   band = bit_and,
   bor  = bit_or,
   bxor = bit_xor,
   brshift = bit_rshift,
   blshift = bit_lshift,
   bxor2 = bit_xor2,
   blogic_rshift = bit_logic_rshift,

   -- utility func
   tobits = to_bits,
   tonumb = tbl_to_number,
}


-- bit lib interface end
------------------------






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
   list methods:
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

		   local py_to_lua_idx = function(i, size)
		      if i >= 0 then
			 i = i + 1
			 if i > size then
			    i = size
			 end
		      else
			 i = i + size + 1
			 if i < 1 then
			    i = 1
			 end
		      end
		      return i
		   end
		   
                   
                   local methods = {}

		   -- L.append(object) -> None -- append object to end
                   methods.append = function(value)
                      table.insert(result._data, value)
                   end

		   -- L.clear() -> None -- remove all items from L
                   methods.clear = function()
                      result._data = {}
                   end

		   -- L.copy() -> list -- a shallow copy of L
                   methods.copy = function()
                      return list(result._data)
                   end

		   -- L.count(value) -> integer -- return number of occurrences of value
                   methods.count = function(value)
                      local cnt = 0
                      for _, v in ipairs(result._data) do
                         if v == value then
                            cnt = cnt + 1
                         end
                      end

                      return cnt
                   end

		   -- L.extend(iterable) -> None -- extend list by appending elements from the iterable
                   methods.extend = function(iterable)
                      for value in iterable do
                         table.insert(result._data, value)
                      end
                   end

		   -- L.index(value, [start, [stop]]) -> integer -- return first index of value.
		   -- 相当于在 L[start:stop] 中寻找 value
		   -- 当 start stop 超过开始/结束的界限，算作界限本身
                   methods.index = function(value, start, stop)
		      local size = #result._data
		      
		      if not start then
			 start = 1
		      else
			 start = py_to_lua_idx(start, size)
		      end

		      if not stop then
			 stop = size
		      else
			 stop = py_to_lua_idx(stop, size)
		      end

		      if start >= stop then
			 return nil
		      end
		      
                      for i = start, stop-1, 1 do
                         if result._data[i] == value then
                            return i - 1
                         end
                      end
                   end

		   -- L.insert(index, object) -- insert object before index
                   methods.insert = function(index, value)
		      local size = #result._data

		      if index + 1 > size then
			 index = size + 1
		      else
			 index = py_to_lua_idx(index, #result._data)
		      end
		      
                      table.insert(result._data, index, value)
                   end

		   -- L.pop([index]) -> item -- remove and return item at index (default last).
                   methods.pop = function(index)
		      local size = #result._data
		      
		      if not index then
			 index = size
		      else
			 -- out of range, index error
			 if index + 1 > size or index + 1 + size < 1 then
			    return nil
			 else
			    index = py_to_lua_idx(index, size)
			 end
		      end
		      
                      local value = result._data[index]
                      table.remove(result._data, index)
		      
                      return value
                   end

		   -- L.remove(value) -> None -- remove first occurrence of value.
                   methods.remove = function(value)
                      for i, v in ipairs(result._data) do
                         if value == v then
                            table.remove(result._data, i)
                            break
                         end
                      end
                   end

		   -- L.reverse() -- reverse *IN PLACE*
                   methods.reverse = function()
                      local new_data = {}
                      for i = #result._data, 1, -1 do
                         table.insert(new_data, result._data[i])
                      end

                      result._data = new_data
                   end

		   -- L.sort(key=None, reverse=False) -> None -- stable sort *IN PLACE*
		   -- TODO: sort 的参数是键值参数，目前暂时不支持，所以还无法传递 key 和 reverse
		   -- TODO: key is a callable
                   methods.sort = function(key, reverse)
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
