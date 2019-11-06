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
   ref: https://docs.python.org/3.4/library/functions.html

   todo:
   - ascii
   - bin
   - bytearray
   - bytes
   - chr
   - classmethod
   - compile
   - complex
   - delattr
   - dict
   - dir
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

-- abs(number) -> number
-- return the absolute value of the argument.
abs = math.abs

-- all(iterable) -> bool
-- return true if bool(x) is true for all values x in the iterable.
-- if the iterable is empty, return True.
function all(iterable)
   for element in iterable do
      if not bool(element) then
         return false
      end
   end
   return true
end

-- any(iterable) -> bool
-- return true if bool(x) is true for any x in the iterable.
-- if the iterable is empty, return False.
function any(iterable)
   for element in iterable do
      if bool(element) then
         return true
      end
   end
   return false
end

-- ascii(object) -> string
-- as repr(), return a string containing a printable representation of an
-- object, but escape the non-ASCII characters in the string returned by
-- repr() using \x, \u or \U escapes.  This generates a string similar
-- to that returned by repr() in Python 2.
function ascii(obj)
   -- todo
end

-- bin(number) -> string
-- return the binary representation of an integer.
-- >>> bin(2796202)
-- '0b1010101010101010101010'
function bin(num)
   assert(type(num) == 'number', 'num is not a number in bin()')
   assert(math.floor(num) == num, 'num is a float in bin()')

   local prefix = '0b'

   local b = ''
   local m = 0
   repeat
      num, m = divmod(num, 2)
      b = tostring(m) .. b
   until num == 0

   return prefix .. b
end

-- bool(x) -> bool
-- returns True when the argument x is true, False otherwise.
-- the builtins True and False are the only two instances of the class bool.
-- the class bool is a subclass of the class int, and cannot be subclassed.
function bool(x)
   if x == false or x == nil or x == 0 or x == '' then
      return false
   end

   if type(x) == "table" then
      if x._is_list or x._is_dict then
         return next(x._data) ~= nil
      end
   end

   return true
end 

-- callable(object) -> bool
-- return whether the object is callable (i.e., some kind of function).
-- note that classes are callable, as are instances of classes with a
-- __call__() method.
function callable(obj)
   local obj_type = type(obj)
   if obj_type == "function" then
      return true
   end
   if obj_type == "table" then
      if obj._is_list or obj._is_dict then
	 return false
      end
      
      local meta = getmetatable(obj)
      return type(meta.__call) == "function" 
   end

   return false
end

-- divmod(x, y) -> (div, mod)
-- return the tuple ((x-x%y)/y, x%y).  Invariant: div*y + mod == x.
function divmod(a, b)
   local d = math.floor(a / b)
   local m = a - d * b
   return d, m
end


-- enumerate(iterable[, start]) -> iterator for index, value of iterable
-- return an enumerate object.  iterable must be another object that supports
-- iteration.  The enumerate object yields pairs containing a count (from
-- start, which defaults to zero) and a value yielded by the iterable argument.
-- enumerate is useful for obtaining an indexed list:
--     (0, seq[0]), (1, seq[1]), (2, seq[2]), ...
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


-- filter(function or None, iterable) --> filter object
-- return an iterator yielding those items of iterable for which function(item)
-- is true. If function is None, return the items that are true.
function filter(func, iterable)
   func = func or bool
   -- fixme: use list for now, no lazy
   local l = list {}
   for item in iterable do
      if func(item) then
	 l.append(item)
      end
   end
   return l
end



-- float(x) -> floating point number
-- convert a string or number to a floating point number, if possible.
function float(x)
   local n = tonumber(x)
   assert(n ~= nil, "could not convert string to float " .. tostring(x))
   return n
end


-- hex(number) -> string
-- return the hexadecimal representation of an integer.
--   >>> hex(3735928559)
--   '0xdeadbeef'
function hex(num)
   assert(type(num) == 'number', 'num is not a number in hex(num)')
   assert(math.floor(num) == num, 'num is a float in hex(num)')

   local int_hex_map = {
      [0] = '0',
      [1] = '1',
      [2] = '2',
      [3] = '3',
      [4] = '4',
      [5] = '5',
      [6] = '6',
      [7] = '7',
      [8] = '8',
      [9] = '9',
      [10] = 'a',
      [11] = 'b',
      [12] = 'c',
      [13] = 'd',
      [14] = 'e',
      [15] = 'f',
   }

   local prefix = '0x'
   local m = 0
   local h = ''
   repeat
      num, m = divmod(num, 16)
      h = int_hex_map[m] .. h
   until num == 0

   return prefix .. h
end


-- int(x=0) -> integer
-- int(x, base=10) -> integer
-- convert a number or string to an integer, or return 0 if no arguments
-- are given.  If x is a number, return x.__int__().  For floating point
-- numbers, this truncates towards zero.
-- if x is not a number or if base is given, then x must be a string,
-- bytes, or bytearray instance representing an integer literal in the
-- given base.
-- the literal can be preceded by '+' or '-' and be surrounded
-- by whitespace. The base defaults to 10.  Valid bases are 0 and 2-36.
-- base 0 means to interpret the base from the string as an integer literal.
--   >>> int('0b100', base=0)
--   4
function int(x, base)
   if x == nil then
      return 0
   end

   if type(x) == 'number' then
      if x >= 0 then
	 return math.floor(x)
      else
	 return math.ceil(x)
      end
   end

   assert(type(x) == 'string', "int() can't convert non-string with explicit base")

   base = base or 10

   if base == 0 then
      local is_neg = string.find(x, '-') ~= nil
      local pos = string.gsub(x, '-', '')

      if string.find(x, '0x') then
	 base = 16
	 pos = string.gsub(pos, '0x', '')
      elseif string.find(x, '0b') then
	 base = 2
	 pos = string.gsub(pos, '0b', '')
      else
	 base = 10
      end
      
      local n = tonumber(pos, base)

      assert(n ~= nil, "invalid literal for int(): " .. x)

      if is_neg then
	 n = -n
      end

      return n
   else
      assert(base >= 2 and base <= 40, "int() base must be >= 2 and <= 36")
      
      local is_neg = string.find(x, '-') ~= nil
      local pos = string.gsub(x, '-', '')
      local n = tonumber(pos, base)

      assert(n ~= nil, "invalid literal for int(): " .. x)

      if is_neg then
	 n = -n
      end

      return n
   end
    
end




-- len(object)
-- return the number of items of a sequence or collection.
function len(t)
   if type(t._data) == "table" then
      local l = 0
      for k, v in pairs(t._data) do
	 l = l + 1
      end
      return l
   end

   return #t
end


-- list() -> new empty list
-- list(iterable) -> new list initialized from iterable's items
list = {}
setmetatable(list, {
                __call = function(_, t)
                   local result = {}

                   result._is_list = true
                   result._data = {}

		   if t ~= nil then
		      if t.__iter__ then
			 -- iterable
			 for v in t do
			    table.insert(result._data, v)
			 end
		      else
			 -- list literal
			 for _, v in ipairs(t) do
			    table.insert(result._data, v)
			 end
		      end
		   else
		      -- list()
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
                   methods.append = function(self, value)
                      table.insert(result._data, value)
                   end

		   -- L.clear() -> None -- remove all items from L
                   methods.clear = function(self)
                      result._data = {}
                   end

		   -- L.copy() -> list -- a shallow copy of L
                   methods.copy = function(self)
                      return list(result._data)
                   end

		   -- L.count(value) -> integer -- return number of occurrences of value
                   methods.count = function(self, value)
                      local cnt = 0
                      for _, v in ipairs(result._data) do
                         if v == value then
                            cnt = cnt + 1
                         end
                      end

                      return cnt
                   end

		   -- L.extend(iterable) -> None -- extend list by appending elements from the iterable
                   methods.extend = function(self, iterable)
                      for value in iterable do
                         table.insert(result._data, value)
                      end
                   end

		   -- L.index(value, [start, [stop]]) -> integer -- return first index of value.
		   -- 相当于在 L[start:stop] 中寻找 value
		   -- 当 start stop 超过开始/结束的界限，算作界限本身
                   methods.index = function(self, value, start, stop)
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
                   methods.insert = function(self, index, value)
		      local size = #result._data

		      if index + 1 > size then
			 index = size + 1
		      else
			 index = py_to_lua_idx(index, #result._data)
		      end
		      
                      table.insert(result._data, index, value)
                   end

		   -- L.pop([index]) -> item -- remove and return item at index (default last).
                   methods.pop = function(self, index)
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
                   methods.remove = function(self, value)
                      for i, v in ipairs(result._data) do
                         if value == v then
                            table.remove(result._data, i)
                            break
                         end
                      end
                   end

		   -- L.reverse() -- reverse *IN PLACE*
                   methods.reverse = function(self)
                      local new_data = {}
                      for i = #result._data, 1, -1 do
                         table.insert(new_data, result._data[i])
                      end

                      result._data = new_data
                   end

		   -- L.sort(key=None, reverse=False) -> None -- stable sort *IN PLACE*
		   -- TODO: sort 的参数是键值参数，目前暂时不支持，所以还无法传递 key 和 reverse
		   -- TODO: key is a callable
                   methods.sort = function(self, key, reverse)
                      key = key or function (itself) return itself end
                      reverse = reverse or false

                      table.sort(result._data, function(a, b)
                                    if reverse then
                                       return key(a) > key(b)
                                    end

                                    return key(a) < key(b)
                      end)
                   end


		   -- __iter__
		   -- delegate to metatable __call
		   methods.__iter__ = function(self)
		      return result
		   end
		   
                   local iterator_index = 0

                   setmetatable(result, {
                                   __index = function(self, index)
                                      if type(index) == "number" then
                                         if index < 0 then
                                            index = #result._data + index
                                         end
                                         return rawget(result._data, index + 1)
                                      end

                                      return function(...)
					 return methods[index](self, ...)
				      end
                                   end,
				   -- only number index is permitted in python
                                   __newindex = function(self, index, value)
                                      rawset(result._data, index + 1, value)
                                   end,
                                   __call = function(self, _, idx)
                                      if idx == nil then
                                         iterator_index = 0
                                      end

				      iterator_index = iterator_index + 1
				      
                                      local v = result._data[iterator_index]
				      
                                      return v
                                   end,
                   })

                   return result
                end,
})


-- map(func, *iterables) --> map object
-- make an iterator that computes the function using arguments from
-- each of the iterables.  Stops when the shortest iterable is exhausted.
function map(func, ...)
   local iterables = list {...}
   local lists = list {}
   
   local iter_num = len(iterables)
   local min_len = math.huge

   for it in iterables do
      lists.append(list(it))
      
      local l = len(list(it))
      if l < min_len then
	 min_len = l
      end
   end
   
   local res = list {}
   for nth in range(min_len) do
      local param = {}
      for ith in range(iter_num) do
	 param[#param+1] = lists[ith][nth]
      end
      res.append(func(unpack(param)))
   end

   return res
end



-- oct(number) -> string
-- return the octal representation of an integer.
--    >>> oct(342391)
--    '0o1234567'
function oct(num)
   assert(type(num) == 'number', 'num is not a number in hex()')
   assert(math.floor(num) == num, 'num is a float in hex()')

   local prefix = '0o'

   local b = ''
   local m = 0
   repeat
      num, m = divmod(num, 8)
      b = tostring(m) .. b
   until num == 0

   return prefix .. b
end



-- max(iterable, *[, default=obj, key=func]) -> value
-- max(arg1, arg2, *args, *[, key=func]) -> value
-- with a single iterable argument, return its biggest item. The
-- default keyword-only argument specifies an object to return if
-- the provided iterable is empty.
-- with two or more arguments, return the largest argument.
function max(arg1, ...)
   local rest = list {...}
   local iterable = arg1
   if len(rest) ~= 0 then
      rest.append(arg1)
      iterable = rest
   end

   local default = nil
   if len(iterable) == 0 then
      return default
   end

   local m = nil
   for item in iterable do
      if m == nil then
	 m = item
      else
	 if item > m then
	    m = item
	 end
      end
   end

   return m
end


function memoryview(object)
   -- not support
end


-- min(iterable, *[, default=obj, key=func]) -> value
-- min(arg1, arg2, *args, *[, key=func]) -> value
-- with a single iterable argument, return its smallest item. The
-- default keyword-only argument specifies an object to return if
-- the provided iterable is empty.
-- with two or more arguments, return the smallest argument.
function min(arg1, ...)
   local rest = list {...}
   local iterable = arg1
   if len(rest) ~= 0 then
      rest.append(arg1)
      iterable = rest
   end

   local default = nil
   if len(iterable) == 0 then
      return default
   end

   local m = nil
   for item in iterable do
      if m == nil then
	 m = item
      else
	 if item < m then
	    m = item
	 end
      end
   end

   return m
end



-- range(stop) -> range object
-- range(start, stop[, step]) -> range object
-- return a sequence of numbers from start to stop by step.
function range(start, stop, step)
   assert(start ~= nil, 'range() expected 1 arguments, got 0')
   
   if stop == nil then
      stop = start
      start = 0        
   end

   step = step or 1
   assert(step ~= 0, 'range() arg 3 must not be zero')

   local i = start
   
   return function()
      ret = i
      if (step > 0 and i >= stop) or (step < 0 and i <= stop) then
         return nil
      end
      
      i = i + step
      return ret
   end
end


-- reduce(function, sequence[, initial]) -> value
-- apply a function of two arguments cumulatively to the items of a sequence,
-- from left to right, so as to reduce the sequence to a single value.
-- for example, reduce(lambda x, y: x+y, [1, 2, 3, 4, 5]) calculates
-- ((((1+2)+3)+4)+5).  If initial is present, it is placed before the items
-- of the sequence in the calculation, and serves as a default when the
-- sequence is empty.
function reduce(func, seq, init)
   if len(seq) == 0 then
      return init
   end

   local r = init
   for e in seq do
      if init == nil then
	 r = e
	 init = true -- not nil
      else
	 r = func(r, e)
      end
   end

   return r
end


-- reversed(sequence) -> reverse iterator over values of the sequence
-- return a reverse iterator
function reversed(seq)
   local l = list(seq)
   l.reverse()
   return l
end




--[[
   tuple
--]]




-- dict() -> new empty dictionary
-- dict(mapping) -> new dictionary initialized from a mapping object's
--     (key, value) pairs
-- dict(iterable) -> new dictionary initialized as if via:
--     d = {}
--     for k, v in iterable:
--         d[k] = v
-- dict(**kwargs) -> new dictionary initialized with the name=value pairs
--     in the keyword argument list.  For example:  dict(one=1, two=2)
dict = {}
setmetatable(dict, {
		__call = function(_, t)
		   local result = {}

		   result._is_dict = true
		   result._data = {}

		   if t ~= nil then
		      if t._is_dict then
			 -- dict(d)
			 for k, v in t.items() do
			    result._data[k] = v
			 end
		      elseif t.__iter__ then
			 -- dict(iterable)
			 for k, v in t do
			    result._data[k] = v
			 end
		      else
			 -- dict literal
			 for k, v in pairs(t) do
			    result._data[k] = v
			 end
		      end
		   else
		      -- dict()
		   end
		   

		   local methods = {}

		   local key_index = nil

		   -- D.clear() -> None.  Remove all items from D.
		   methods.clear = function(self)
		      result._data = {}
		   end

		   -- D.copy() -> a shallow copy of D
		   methods.copy = function(self)
		      return dict(result._data)
		   end

		   -- d.fromkeys(iterable, value=None, /)
		   -- returns a new dict with keys from iterable and values equal to value.
		   methods.fromkeys = function(self, keys, value)
		      value = value or nil
		      d = {}
		      for k in keys do
			 d[k] = value
		      end

		      return dict(d)
		   end

		   -- D.get(k[,d]) -> D[k] if k in D, else d.  d defaults to None.
		   methods.get = function(self, key, default)
		      value = result._data[key] or default or nil
		      return value
		   end

		   -- D.items() -> a set-like object providing a view on D's items
		   methods.items = function(self)
		      return pairs(result._data)
		   end

		   -- D.keys() -> a set-like object providing a view on D's keys
		   methods.keys = function(self)
		      return function(_, idx) 
			 if idx == nil and key_index ~= nil then
			    key_index = nil
			 end

			 key_index, _ = next(result._data, key_index)
			 return key_index
		      end
		   end

		   -- D.pop(k[,d]) -> v, remove specified key and return the corresponding value.
		   -- if key is not found, d is returned if given, otherwise KeyError is raised

		   methods.pop = function(self, key, default)
		      value = result._data[key] or default or nil
		      result._data[key] = nil

		      return value
		   end

		   -- D.popitem() -> (k, v), remove and return some (key, value) pair as a
		   -- 2-tuple; but raise KeyError if D is empty.
		   methods.popitem = function(self)
		      local key, value = next(result._data)
		      if key ~= nil then
			 result._data[key] = nil
		      end

		      return key, value
		   end

		   -- D.setdefault(k[,d]) -> D.get(k,d), also set D[k]=d if k not in D
		   methods.setdefault = function(self, key, default)
		      if result._data[key] == nil then
			 result._data[key] = default
		      end

		      return result._data[key]
		   end

		   -- D.update([E, ]**F) -> None.  Update D from dict/iterable E and F.
		   -- if E is present and has a .keys() method, then does:  for k in E: D[k] = E[k]
		   -- if E is present and lacks a .keys() method, then does:  for k, v in E: D[k] = v
		   -- in either case, this is followed by: for k in F:  D[k] = F[k]
		   methods.update = function(self, t)
		      if not t._is_dict then
			 return
		      end

		      for k, v in t.items() do
			 result._data[k] = v
		      end
		   end

		   -- D.values() -> an object providing a view on D's values
		   methods.values = function(self)
		      return function(_, idx) 
			 if idx == nil and key_index ~= nil then
			    key_index = nil
			 end

			 key_index, value = next(result._data, key_index)
			 return value
		      end
		   end

		   -- __iter__()
		   -- delegate to dict __call
		   methods.__iter__ = function(self)
		      return result
		   end
		   
		   setmetatable(result, {
				   __index = function(self, index)
				      if result._data[index] ~= nil then
					 return result._data[index]
				      end
				      if methods[index] ~= nil then
					 -- method
					 return function(...)
					    return methods[index](self, ...)
					 end
				      end
				      return nil
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




-- object class
local object = {}
object.__name__ = 'object'
object.__base__ = nil
object.__mro__ = list {object}



-- pow(x, y[, z]) -> number
-- with two arguments, equivalent to x**y.  With three arguments,
-- equivalent to (x**y) % z, but may be more efficient (e.g. for ints).
function pow(x, y, z)
   local p = math.pow(x, y)
   if z == nil then
      return p
   else
      return math.fmod(p, z)
   end
end


-- round(number[, ndigits]) -> number
-- round a number to a given precision in decimal digits (default 0 digits).
-- this returns an int when called with one argument, otherwise the
-- same type as the number. ndigits may be negative.
function round(number, ndigits)
   ndigits = ndigits or 0

   local shift = math.pow(10, ndigits)
   local n = number * shift
   local i, f = math.modf(n)
   if f >= 0.5 then
      i = i + 1
   end

   n = i / shift
   return n
end


-- sorted(iterable, key=None, reverse=False) --> new sorted list
function sorted(iterable, key, reverse)
   local l = list(iterable)
   l.sort(key, reverse)
   return l
end


-- sum(iterable[, start]) -> value
-- return the sum of an iterable of numbers (NOT strings) plus the value
-- of parameter 'start' (which defaults to 0).  When the iterable is
-- empty, return start.
function sum(iterable, start)
   local start = start or 0
   local s = 0

   for i in iterable do
      s = s + i
   end

   return s + start
end







------------------------------------------------


--[[
   class

   TODO：
   - MRO机制
   - object class
   - magic methods
   - metaclass
   - @property, @staticmethod, @classmethod
   - multi inherit
--]]
function class(class_init, bases, class_name)
   bases = bases or {}

   local c = {}
   
   for _, base in ipairs(bases) do
      for k, v in pairs(base) do
	 c[k] = v
      end
   end
   
   c.__name__ = class_name
   c.__base__ = bases
   -- todo: __mro__ ?
   -- https://www.python.org/download/releases/2.3/mro/
   
   c = class_init(c)
   
   local mt = getmetatable(c) or {}
   mt.__call = function(_, ...)
      local obj = {}
      
      setmetatable(obj, {
		      __index = function(tbl, idx)
			 local attr = c[idx]
			 if type(attr) == "function" then
			    return function(...)
			       -- attr is function, obj is self
			       return c[idx](obj, ...) 
			    end
			 end

			 -- attr is attribute
			 return attr
		      end,
      })

      obj.__class__ = c
      
      -- search in the metatable
      if type(obj.__init__) == "function" then
	 obj.__init__(...)
      end
      
      return obj
   end
   
   setmetatable(c, mt)
   
   return c
end


function isinstance(obj, cls)
   local c = obj.__class__

   -- if cls in c's parent classes
   -- base on __mro__
end

function issubclass()
end

--[[
super() -> same as super(__class__, <first argument>)
super(type) -> unbound super object
super(type, obj) -> bound super object; requires isinstance(obj, type)
super(type, type2) -> bound super object; requires issubclass(type2, type)

Typical use to call a cooperative superclass method:
class C(B):
    def meth(self, arg):
        super().meth(arg)

This works for class methods too:
class C(B):
    @classmethod
    def cmeth(cls, arg):
        super().cmeth(arg)
--]]
function super(cls, obj)
end


-- zip(iter1 [,iter2 [...]]) --> zip object
-- return a zip object whose .__next__() method returns a tuple where
-- the i-th element comes from the i-th iterable argument.  The .__next__()
-- method continues until the shortest iterable in the argument sequence
-- is exhausted and then it raises StopIteration.
function zip(iter1, ...)
   local iters = list {...}
   iters.insert(0, iter1)

   local lists = list {}
   local iters_num = len(iters)
   local min_iter_len = math.huge

   for it in iters do
      lists.append(list(it))
      local l = len(list(it))
      if l < min_iter_len then
	 min_iter_len = l
      end
   end

   local res = list {}
   for nth in range(min_iter_len) do
      local item = list {}
      for ith in range(iters_num) do
	 item.append(lists[ith][nth])
      end
      res.append(item)
   end

   return res
end

