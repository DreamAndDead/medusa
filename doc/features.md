# supported features

transpiler 支持的 python 语言以 3.4 为基准，支持大部分语言功能。

## transpile 的核心

粗略的讲，是运行得到同样的结果。

本质是用 lua 实现了 python，（这里不是 100%），表达同样的语义。


## python features supported

### Constant 常量

从语义上讲，python 中的 `True False None`，对应于 lua 中的 `true false nil`。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|布尔真|`True`|`true`|:heavy_check_mark:|
|布尔假|`False`|`false`|:heavy_check_mark:|
|空|`None`|`nil`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[constant.py](./../codeblock/constant.py)|[constant.py.lua](./../codeblock/constant.py.lua)|


### Variable 变量

python 和 lua 都是弱类型语言，变量没有类型。

可能存在区别的在于**作用域**，这一点到后面详细讨论。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|变量|`var`|`[local] var`|:heavy_check_mark:|

变量第一次出现的时候，变量前面需要加上 `local`，限定变量的作用域；在变量后面再使用的时候，不再需要 `local`。

虽然弱类型语言的变量不需要先声明再使用，但是还是存在一个隐性的声明过程，就是变量第一次被赋值的时候。

比如 python 中，直接使用一个变量

```python
a = a + 1
```

运行会引发运行错误

	NameError: name 'a' is not defined

如果转化为 lua 代码

```lua
local a = (a + 1)
```

运行同样会引发错误

	attempt to perform arithmetic on global 'a' (a nil value)

所以在这一点，两个语言是一致的。

正确的做法需要先给 a 赋初始值，当作 a 的声明。

```python
a = 0
a = a + 1
```

转化为 lua

```lua
local a = 0
a = (a + 1)
```

|python示例代码|lua转换代码|
|:-:|:-:|
|[variable.py](./../codeblock/variable.py)|[variable.py.lua](./../codeblock/variable.py.lua)|


### Assign 语句

python 中多种赋值方法，都可以转化为相应的 lua 代码来实现。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|单变量赋值|`a = 1`|`local a = 1`|:heavy_check_mark:|
|多变量赋相同值|`a = b = 1`|`local a = 1; local b = 1`|:heavy_check_mark:|
|多变量同时赋值|`a, b = b, a`|`a, b = b, a`|:heavy_check_mark:|

*TODO: 除了上面描述的情况，python 中会出现其它的赋值方法，目前仍未完全支持，具体的讨论可以参见示例代码中的注释*

|python示例代码|lua转换代码|
|:-:|:-:|
|[assign.py](./../codeblock/assign.py)|[assign.py.lua](./../codeblock/assign.py.lua)|


### Del 语句

python 中 del 语句用于解除一个值，lua 中没有 del 的概念，可以用赋值 nil 来进行同义模拟。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|del|`del v`|`v = nil`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[del.py](./../codeblock/del.py)|[del.py.lua](./../codeblock/del.py.lua)|


### AugAssign 语句

自赋值，是一种简便的写法。
在 python 中，任何二元运算都有相应的自赋值写法，比如 `a += 1`，`b *= 3`。
在 lua 中没有相应的概念，但是可以将赋值的右侧展开进行同义模拟。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|augassign|`a += 1`|`a = a + 1`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[augassign.py](./../codeblock/augassign.py)|[augassign.py.lua](./../codeblock/augassign.py.lua)|



---


### Bool 布尔运算

python 和 lua 本身都支持 and or 二元运算，都为短路求值，且 and or 的优先级（and 高于 or，先结合）相同。
同时两者都支持 not 一元运算，返回 True/False(python) true/false(lua)。

从某种意义上，布尔运算可以无缝转换。

|feature|python|lua|支持|
|:-:|:-:|:-:|:-:|
|与|`1 and 2`|`1 and 2`|:heavy_check_mark:|
|或|`1 or 2`|`1 or 2`|:heavy_check_mark:|
|非|`not 1`|`not 1`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[bool.py](./../codeblock/bool.py)|[bool.py.lua](./../codeblock/bool.py.lua)|


### Arithmetic 算术运算

几乎所有语言都有内建基本的算术运算，python lua 也不例外。
因为算术运算在数学概念上是统一的，所以含义相同。

*对于 lua 没有的算术运算符，用函数来模拟*

|feature|python|lua|支持|
|:-:|:-:|:-:|:-:|
|加法|`1 + 2`|`1 + 2`|:heavy_check_mark:|
|减法|`1 - 2`|`1 - 2`|:heavy_check_mark:|
|乘法|`1 * 2`|`1 * 2`|:heavy_check_mark:|
|浮点除法|`1 / 2`|`1 / 2`|:heavy_check_mark:|
|地板除法|`1 // 2`|`math.floor(1 / 2)`|:heavy_check_mark:|
|余数|`10 % 3`|`math.fmod(10, 3)`|:heavy_check_mark:|
|指数|`2 ** 2`|`math.pow(2, 2)`|:heavy_check_mark:|
|正数|`+2`|`2`|:heavy_check_mark:|
|负数|`-2`|`(-2)`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[arithmetic.py](./../codeblock/arithmetic.py)|[arithmetic.py.lua](./../codeblock/arithmetic.py.lua)|


### Bit 位运算

**FIXME: 这部分函数的运行结果还在调整，以期和 python 的表现相同（python 的底层不仅是 32 位的，从 << 可以看出来）**

python 同时内建了位运算，在 lua 5.1 版本，无论是内建还是标准库，都不包含位运算，所以需要函数来模拟。

|feature|python|lua|支持|
|:-:|:-:|:-:|:-:|
|左移|`1 << 2`|`bit.lshift(1, 2)`|:heavy_check_mark:|
|右移|`1 >> 2`|`bit.rshift(1, 2)`|:heavy_check_mark:|
|与|`1 & 2`|`bit.and(1, 2)`|:heavy_check_mark:|
|或|`1 \| 2`|`bit.or(1, 2)`|:heavy_check_mark:|
|取反|`~1`|`bit.invert(1)`|:heavy_check_mark:|
|异或|`1 ^ 2`|`bit.xor(1, 2)`|:heavy_check_mark:|

|python示例代码|lua转换代码|
|:-:|:-:|
|[bit.py](./../codeblock/bit.py)|[bit.py.lua](./../codeblock/bit.py.lua)|

### Compare 比较运算

对于大于，等于，小于，属于编程语言中通用的元素，python 和 lua 都支持（对于不同的数据类型可能有重载）。

is 是 python 中特别的比较运算，用于判断对象是否在底层相同（python 中一切都是对象），在 lua 这一方面就相对比较难模拟了。

in 在 python 中，含义是属于，这一点在 lua 中可能通过函数来模拟，暂时不支持。

|feature|python|lua|支持|
|:-:|:-:|:-:|:-:|
|相同|`1 == 2`|`1 == 2`|:heavy_check_mark:|
|不相同|`1 != 2`|`1 ~= 2`|:heavy_check_mark:|
|小于|`1 < 2`|`1 < 2`|:heavy_check_mark:|
|小于等于|`1 <= 2`|`1 <= 2`|:heavy_check_mark:|
|大于|`1 > 2`|`1 > 2`|:heavy_check_mark:|
|大于等于|`1 >= 2`|`1 >= 2`|:heavy_check_mark:|
|is|`1 is 2`|:x:|:x:|
|is not|`1 is not 2`|:x:|:x:|
|in|`1 in {}`|:x:|:x:|
|not in|`1 not in {}`|:x:|:x:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[compare.py](./../codeblock/compare.py)|[compare.py.lua](./../codeblock/compare.py.lua)|



-----


### List 字面量

list 是 python 内建的数据结构，应用广泛。
lua 中不存在相应的概念，需要编写相应代码来模拟（用元表来模拟魔术方法）。

创建 list 有两种方式，字面量 `l = []` 和函数 `l = list()` 的方式，这里指的是字面量的方式，`list()` 被当作函数对待。

创建得到的 list 是一个对象，其中包含自己的数据和方法。

|feature|python|lua|支持|
|:-:|:-:|:-:|:-:|
|初始化|`l = [1, 2, 3]`|`[local] l = list {1, 2, 3}`|:heavy_check_mark:|
|`append`|`l.append(4)`|`l.append(4)`|:heavy_check_mark:|
|`clear`|`l.clear()`|`l.clear()`|:heavy_check_mark:|
|`copy`|`l.copy()`|`l.copy()`|:heavy_check_mark:|
|`count`|`l.count(4)`|`l.count(4)`|:heavy_check_mark:|
|`extend`|`l.extend([5, 6, 7])`|`l.extend(list {5, 6, 7})`|:heavy_check_mark:|
|`index`|`l.index(4)`|`l.index(4)`|:heavy_check_mark:|
|`insert`|`l.insert(0, -1)`|`l.insert(0, -1)`|:heavy_check_mark:|
|`pop`|`l.pop()`|`l.pop()`|:heavy_check_mark:|
|`remove`|`l.remove(-1)`|`l.remove(-1)`|:heavy_check_mark:|
|`reverse`|`l.reverse()`|`l.reverse()`|:heavy_check_mark:|
|`sort`|`l.sort()`|`l.sort()`|:heavy_check_mark:，因为当前函数不支持键值参数，所以 key 和 reverse 参数无法传递，有待调整|
|索引`[n]`|`l[0]`|`l[0]`|:heavy_check_mark:|
|切片`[m:n]`|`l[0:3]`|` `|:x:|
|重载`==`|`[] == []`|` `|:x:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[list.py](./../codeblock/list.py)|[list.py.lua](./../codeblock/list.py.lua)|


### Dict 字面量

dict 是 python 中内建的数据结构，使用非常广泛。
在 lua 中没有内建相应的结构，需要编写相应的 lua 代码来做模拟（用元表来模拟魔术方法）。

创建 dict 有两种方式，字面量 `d = {}` 和函数 `d = dict()` 的方式，这里指的是字面量的方式，`dict()` 被当作函数对待。

创建得到的 dict 是一个对象，其中包含自己的数据和方法。

|feature|python|lua|支持|
|:-:|:-:|:-:|:-:|
|创建字典|`d = {'name': 'john', 1: 26}`|`[local] d = dict {['name'] = 'john', [1] = 26}`|:heavy_check_mark:|
|`clear`|`d.clear()`|`d.clear()`|:heavy_check_mark:|
|`copy`|`d.copy()`|`d.copy()`|:heavy_check_mark:|
|`fromkeys`|`d.fromkeys(['height'], 40)`|`d.fromkeys(['height'], 40)`|:heavy_check_mark:|
|`get`|`d.get('home', 'cn')`|`d.get('home', 'cn')`|:heavy_check_mark:|
|`items`|`d.items()`|`d.items()`|:heavy_check_mark:|
|`keys`|`d.keys()`|`d.keys()`|:heavy_check_mark:|
|`pop`|`d.pop('name', 'jane')`|`d.pop('name', 'jane')`|:heavy_check_mark:|
|`popitem`|`d.popitem()`|`d.popitem()`|:heavy_check_mark:|
|`setdefault`|`d.setdefault('hair', 'black')`|`d.setdefault('hair', 'black')`|:heavy_check_mark:|
|`update`|`d.update({'age': 22})`|`d.update(dict {['age'] = 22})`|:heavy_check_mark:|
|`values`|`d.values()`|`d.values()`|:heavy_check_mark:|
|索引`[k]`|`d[k]`|`d[k]`|:heavy_check_mark:|
|重载`==`|`{} == {}`|` `|:x:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[dict.py](./../codeblock/dict.py)|[dict.py.lua](./../codeblock/dict.py.lua)|


### Tuple 字面量

tuple 是 python 内建的数据结构。
在 lua 中需要编写相应代码来模拟。

TODO：支持示例



<!--

|python示例代码|lua转换代码|
|:-:|:-:|
|[tuple.py](./../codeblock/tuple.py)|[tuple.py.lua](./../codeblock/tuple.py.lua)|
-->


### Set 字面量

同 dict，set 也是 python 内建的数据结构。
在 lua 中需要编写相应代码来模拟。

TODO：支持示例


<!--

python示例代码|lua转换代码|
|:-:|:-:|
|[set.py](./../codeblock/set.py)|[set.py.lua](./../codeblock/set.py.lua)|

-->


### Subscript

python 中有 3 种下标，Index, Slice 和 ExtSlice。
在 lua 中，默认只有 Index 对应的概念，`d[1]`。

TODO：支持示例

<!--

|python示例代码|lua转换代码|
|:-:|:-:|
|[subscript.py](./../codeblock/subscript.py)|[subscript.py.lua](./../codeblock/subscript.py.lua)|

-->



------



### If 语句

分支在编程语言中是一个通用概念，而且几乎所有语言的分支关键字都是 if。

python 和 lua 的分支结构是非常相似的。

|feature|python|lua|支持|
|:-:|:-:|:-:|:-:|
|if...|`if True: ...`|`if true then end`|:heavy_check_mark:|
|if...else...|`if True: ... else: ...`|`if true then else end`|:heavy_check_mark:|
|if...elif...|`if True: ... elif True: ...`|`if true then else if true end`|:heavy_check_mark:|
|if...elif...else...|`if True: ... elif True: ... else: ...`|`if true then else if true then else end end`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[if.py](./../codeblock/if.py)|[if.py.lua](./../codeblock/if.py.lua)|


### For 语句

for in 是 python 中常用的迭代方法，其核心是迭代器。
lua 中也有 for in 的语法，和 python 的实现非常类似。

|feature|python|lua|支持|
|:-:|:-:|:-:|:-:|
|for in list|`for i in [1, 2]`|`for i in list {1, 2}`|:heavy_check_mark:|
|for in dict|`for k, v in d.items()`|`for k, v in d.items()`|:heavy_check_mark:|
|for in range|`for i in range(1, 10, 2)`|`for i in range(1, 10, 2)`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[for.py](./../codeblock/for.py)|[for.py.lua](./../codeblock/for.py.lua)|


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




### Assert 断言

python 和 lua 都内建了 assert 函数，进行真值的断言，如果为假，则程序 exit，附加 assert message。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|断言|`assert 1 == 1`|`assert((1 == 1))`|:heavy_check_mark:|
|断言+消息|`assert 1 == 1, "one always one"`|`assert((1 == 1), "one always one")`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[assert.py](./../codeblock/assert.py)|[assert.py.lua](./../codeblock/assert.py.lua)|

### With 语句

上下文操作，暂时不支持。

### Raise， Try

lua 中不支持异常。

### Import ImportFrom

需要配合 Module 概念的引入，将单个文件作为一个 Module。

如果后续可以兼容大部分库的话。

### Global Nonlocal

涉及到作用域的问题


### Builtin 内建函数

python 语言环境中除了引用标准库，其中有不少有用的内建函数。
这些函数都需要在 lua 中进行同义模拟。


|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|`len`|`len([1, 2])`|`len(list {1, 2})`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[builtin.py](./../codeblock/builtin.py)|[builtin.py.lua](./../codeblock/builtin.py.lua)|



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
