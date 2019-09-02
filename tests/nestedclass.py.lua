dofile('./pythonlua/luainit.lua')

local Foo = class(function(Foo)
    Foo.Bar = class(function(Bar)
        function Bar.__init__(self)
            print("__init__ from Bar")
        end
        return Bar
    end, {})
    function Foo.__init__(self)
        print("__init__ from Foo")
        Foo.Bar()
    end
    return Foo
end, {})
Foo()
Foo.Bar()