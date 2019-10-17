# supported features

transpiler 支持的 python 语言以 3.4 为基准，支持大部分语言功能。

## transpile 的核心

粗略的讲，是运行得到同样的结果。

本质是用 lua 实现了 python，（这里不是 100%）

## python features supported



### Constant 常量

从含义上讲，python 中的 `True False None`，对应于 lua 中的 `true false nil`。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|布尔真|`True`|`true`|:heavy_check_mark:|
|布尔假|`False`|`false`|:x:|
|空|`None`|`nil`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[](./codeblock/constant.py)|[](./codeblock/constant.py.lua)|


### Name 变量

python lua 两者都是弱类型，变量不需要提前声明。

不同的可能在于作用域。

TODO：支持示例





### Assign 语句

python 中很多种赋值方法，后面要细细讨论。

TODO：支持示例

### Del 语句

在 python 中，del 语句用于解除一个值。
lua 中没有相应的语句，可以用赋值 nil 来模拟。


### AugAssign 语句

类似于自增的语句。

在 lua 中可以将其展开来模拟。

TODO：支持示例





### 布尔运算

|feature|python|lua|支持|
|:-:|:-:|:-:|:-:|
|与|`1 and 2`|`1 and 2`|:heavy_check_mark:|
|或|`1 or 2`|`1 or 2`|:heavy_check_mark:|
|非|`not 1`|`not 1`|:heavy_check_mark:|

python 语言和 lua 语言本身都支持 and or 二元运算，并且都为短路求值，且 and or 的优先级（and 高于 or 先结合）相同。

同时两者都支持 not 一元运算，返回 True/False(python) true/false(lua)。

所以从某种意义上，布尔运算可以无缝转换。


### 算术运算

|feature|python|lua|支持|
|:-:|:-:|:-:|:-:|
|加法|`1 + 2`|`1 + 2`|:heavy_check_mark:|
|减法|`1 - 2`|`1 - 2`|:heavy_check_mark:|
|乘法|`1 * 2`|`1 * 2`|:heavy_check_mark:|
|除法|`1 / 2`|`1 / 2`|:heavy_check_mark:，同时都是浮点除法|
|地板除法|`1 // 2`|`floordiv(1, 2)`|:heavy_check_mark:，通过 function 模拟|
|余数|`10 % 3`|`10 % 3`|:heavy_check_mark:|
|指数|`2 ** 2`|`2 ^ 2`|:heavy_check_mark:|
|正数|`+2`|`2`|:heavy_check_mark:|
|负数|`-2`|`-2`|:heavy_check_mark:|


### 位运算

|feature|python|lua|支持|
|:-:|:-:|:-:|:-:|
|左移|`1 << 2`|`lshift(1, 2)`|:heavy_check_mark:，通过 function 模拟|
|右移|`1 >> 2`|`rshift(1, 2)`|:heavy_check_mark:，通过 function 模拟|
|与|`1 & 2`|`bitand(1, 2)`|:heavy_check_mark:，通过 function 模拟|
|或|`1 \| 2`|`bitor(1, 2)`|:heavy_check_mark:，通过 function 模拟|
|取反|`~1`|`bitinvert(1)`|:heavy_check_mark:，通过 function 模拟|
|异或|`1 ^ 2`|`bitxor(1, 2)`|:heavy_check_mark:，通过 function 模拟|


### 比较运算

|feature|python|lua|支持|
|:-:|:-:|:-:|:-:|
|相同|`1 == 2`|`1 == 2`|:heavy_check_mark:|
|不相同|`1 != 2`|`1 ~= 2`|:heavy_check_mark:|
|小于|`1 < 2`|`1 < 2`|:heavy_check_mark:|
|小于等于|`1 <= 2`|`1 <= 2`|:heavy_check_mark:|
|大于|`1 > 2`|`1 > 2`|:heavy_check_mark:|
|大于等于|`1 >= 2`|`1 >= 2`|:heavy_check_mark:|
|is|`1 is 2`|` `|不:heavy_check_mark:|
|is not|`1 is not 2`|` `|不:heavy_check_mark:|
|in|`1 in {}`|` `|不:heavy_check_mark:|
|not in|`1 not in {}`|` `|不:heavy_check_mark:|






### dict 字面量

dict 是 python 中内建的数据结构，应用广泛。
在 lua 中没有相应的结构，需要编写相应的 lua 代码来做模拟。

创建 dict 有两种方式，字面量 `d = {}` 和函数 `d = dict()` 的方式，这里指的是字面量的方式。

TODO：支持示例

### set 字面量

同 dict，set 也是 python 内建的数据结构。
在 lua 中需要编写相应代码来模拟。

TODO：支持示例

### list 字面量

list 是 python 内建的数据结构。
在 lua 中需要编写相应代码来模拟。

TODO：支持示例


### tuple 字面量

tuple 是 python 内建的数据结构。
在 lua 中需要编写相应代码来模拟。

TODO：支持示例

### Subscript

python 中有 3 种下标，Index, Slice 和 ExtSlice。
在 lua 中，默认只有 Index 对应的概念，`d[1]`。

TODO：支持示例







### If 语句

同 while，if 是一个比较协同的概念。

elif 和 else if 等价。

TODO：支持示例


### For 语句

for in 是 python 中常用的迭代方法。
lua 中也有 for 写法，需要模拟迭代器。

TODO：支持示例

### While 语句

while 语句在 python 和 lua 中概念相似。

TODO：支持示例

### Pass 语句

在 python 中需要用来占位，但是 lua 中不需要，对应空语句

### Break 语句

在 python 和 lua 中相同，用于跳出循环。

### Continue 语句

也许难以相信，lua 不支持 Continue 语句，很难模拟 :(







### lambda 表达式

在 python 中，lambda 是匿名函数，但是其中只能包含一个简单的返回值。
而在 lua 中，天生支持匿名函数，且其中的语句没有限制。

TODO: 支持示例


### 函数定义

python 的函数定义有装饰器，普通参数，默认值参数，vararg，键值参数，kwarg

相比之下，lua 的函数定义就更加纯粹。如果需要同样的效果就要更多的代码工作。

TODO：支持示例


### Starred

`*d` 存在在 python 中的许多地方。
在 lua 中没有相应的概念，需要再思考。

TODO：支持示例

### Call 函数调用

函数调用在 python lua 以及其它语言中是一个通用概念。

TODO：支持示例

在 python 的函数调用中，除了普通函数，还有 列表参数和字典参数。

### Return 语句

return 语句的概念是相同的


### Yield

不支持

虽然 lua 中有协程，但是和 python 中的 yield 不是一个概念。


### 类定义

类是 python 中的关键概念。
lua 中不存在类的概念，只能用 table 和 metatable 来模拟。

TODO：支持示例

### 属性

python 中一切都是对象，获取对象的属性是常用操作。
在 lua 中，没有对象的概念，对应的 `.` 是索引的概念。

TODO：支持示例








### if 表达式

python 从 perl 借鉴来的语法，将 if 判断作为表达式，而不是语句块。
而在 lua 中，没有这种类型的语法，只能将其转化为普通的 if 语句块来运行。


TODO：支持示例

### list 生成式

list 生成式也是 python 中的创新，用表达式来生成列表，本质是循环（+判断）的表达式写法。
在 lua 中没有相应结构，需要用函数调用来模拟。

TODO：支持示例

### set 生成式

TODO：支持示例

### dict 生成式

TODO：支持示例

### 生成表达式

语法和列表生成类似，不过使用的是 () ，得到一个 generator 对象，而不是即时的列表。




### With 语句

上下文操作，暂时不支持。

### Raise， Try

lua 中不支持异常。

### Assert

不支持

### Import ImportFrom

需要配合 Module 概念的引入，将单个文件作为一个 Module。

如果后续可以兼容大部分库的话。

### Global Nonlocal

涉及到作用域的问题






## python newer than 3.4

在 python 3.4 版本之后（3.5, 3.6, 3.7）添加的 `新语法和 builtin 函数`，当前**不支持**。

[python 3.5](https://docs.python.org/3/whatsnew/3.5.html)
- 新增了 async, await 语法
- 新的矩阵乘法操作符 `a @ b`
- 在函数调用中，不限制 `* **` 解压的数量，同时 tuple list set dict 都支持解压

[python 3.6](https://docs.python.org/3/whatsnew/3.6.html)
- 添加新的字符串字面量 formatted string literals `f"He said his name"`
- 增加了变量类型提示 type hints
- 数字字面量支持 _ 
- 异步的生成器 await + yield
- 异步的生成表达式 await + for

[python 3.7](https://docs.python.org/3/whatsnew/3.7.html)
- type hints 的延时执行
- builtin breakpoint
