#!/usr/bin/env lua5.1



for i = 1, 10, 1 do
   local code = "a = " .. tostring(i)
   
   local tmpfile = os.tmpname()
   local prog = io.popen('./dist/py2lua > ' .. tmpfile, 'w')
   if nil == prog then
      print("open prog failed")
      os.exit()
   end

   prog:write(code)
   prog:close()
   
   local tmp = io.open(tmpfile)
   output = tmp:read("*a")
   tmp:close()

   local res, error_msg = os.remove(tmpfile)
   if res == nil then
      print(error_msg)
   end

   print(output)
end


