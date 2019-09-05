# if, for, while

# # lua: for i = 1, 10 do end
# for i in range(1, 10):
#     print(i)
# 
# # lua : for in do end
# for i in [1, 2, 3]:
#     print(i)
# 
# 

# # if
# if True:
#     print("true")
#     
# if True:
#     print("true")
# else:
#     print("false")
# 
# # 本质上，下面两种写法是等价的
# if 1:
#     print(1)
# elif 2:
#     print(2)
# elif 3:
#     print(3)
# else:
#     print(4)
# 
# if 1:
#     print(1)
# else:
#     if 2:
#         print(2)
#     else:
#         if 3:
#             print(3)
#         else:
#             print(4)

# while, there's no do until in python
while True:
    print("while")
    if True:
        break
