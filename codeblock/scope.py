# scopy 作用域

## def scope
g = 10

def outer():
    e = 20

    def inner():
        l = 30
        assert g == 10
        assert e == 20
        assert l == 30

    inner()

    assert g == 10
    assert e == 20

outer()

assert g == 10


## class scope
g = 10

class o():
    e = 20

    class i():
        l = 30

        assert g == 10
        # class can't create enclosure scope
        # next line raise exception
        # assert e == 20
        assert l == 30

    assert g == 10
    assert e == 20

assert g == 10


## lambda scope

g = 10

l = lambda e: lambda l: g + e + l

assert l(20)(30) == 60


## generator scope





# ## global
# 
# g = 10
# 
# def outer():
#     g = 20
#     assert g == 20
#     
# outer()
# assert g == 10
# 
# def outer():
#     global g
#     g = 20
#     assert g == 20
# 
# outer()
# assert g == 20
