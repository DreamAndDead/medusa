dofile('./pythonlua/luainit.lua')

do
    local output_file = open("output")
    output_file.write(input_file.read())
end