# scopy 作用域

## normal

g = 10

def outer():
    o = 20
    assert g == 10

    def inner():
        assert g == 10
        assert o == 20

    inner()

outer()


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
