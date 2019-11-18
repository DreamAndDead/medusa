# supported features

py2lua 支持的 python 语言以 3.4 为基准，支持大部分语言功能。
转换为 lua 语言 5.1 版本。

## transpile 的核心

transpile 的本质在于，用 lua 实现 python 语言所表现的语义，相当于用 lua 实现了 python。

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

存在区别的在于**作用域**，这一点到后面详细讨论。

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

|feature|python|lua|supported|
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
对于 lua 没有的算术运算符，用函数来模拟。

|feature|python|lua|supported|
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

在 python 底层，整数是无限精度的，随着整数的变大，底层拓展使用更多的字节来存储。而 lua 底层不包含如此的机制，默认 lua 使用 IEEE 64bit 浮点来存储，极值为 2^1024（可能随着编译选项而不同），整数精度为 2^52。

**对于位运算，这里只模拟 32 位的情况。**

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|左移|`1 << 2`|`bit.blshift(1, 2)`|:heavy_check_mark:|
|右移|`1 >> 2`|`bit.brshift(1, 2)`|:heavy_check_mark:|
|与|`1 & 2`|`bit.band(1, 2)`|:heavy_check_mark:|
|或|`1 \| 2`|`bit.bor(1, 2)`|:heavy_check_mark:|
|取反|`~1`|`bit.bnot(1)`|:heavy_check_mark:|
|异或|`1 ^ 2`|`bit.bxor(1, 2)`|:heavy_check_mark:|

|python示例代码|lua转换代码|
|:-:|:-:|
|[bit.py](./../codeblock/bit.py)|[bit.py.lua](./../codeblock/bit.py.lua)|


### Compare 比较运算

对于大于，等于，小于，属于编程语言中通用的元素，python 和 lua 都支持（对于不同的数据类型可能有重载）。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|相同|`1 == 2`|`1 == 2`|:heavy_check_mark:|
|不相同|`1 != 2`|`1 ~= 2`|:heavy_check_mark:|
|小于|`1 < 2`|`1 < 2`|:heavy_check_mark:|
|小于等于|`1 <= 2`|`1 <= 2`|:heavy_check_mark:|
|大于|`1 > 2`|`1 > 2`|:heavy_check_mark:|
|大于等于|`1 >= 2`|`1 >= 2`|:heavy_check_mark:|
|is|`1 is 2`|`operator_is(1, 2)`|:heavy_check_mark:|
|is not|`1 is not 2`|`not operator_is(1, 2)`|:heavy_check_mark:|
|in|`1 in {1, 2}`|`operator_in(1, set {1, 2})`|:heavy_check_mark:|
|not in|`1 not in {1, 2}`|`not operator_in(1, set {1, 2})`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[compare.py](./../codeblock/compare.py)|[compare.py.lua](./../codeblock/compare.py.lua)|


-----


### List

list 是 python 内建的数据结构，应用广泛。
lua 中不存在相应的概念，需要编写相应代码来模拟。

创建 list 有两种方式，字面量 `l = []` 和函数 `l = list()` 的方式。

创建得到的 list 是一个对象，其中包含自己的数据和方法。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|list字面量|`l = [1, 2, 3]`|`[local] l = list {1, 2, 3}`|:heavy_check_mark:|
|list函数|`l = list(iterable)`|`[local] l = list(iterable)`|:heavy_check_mark:|
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

|python示例代码|lua转换代码|
|:-:|:-:|
|[list.py](./../codeblock/list.py)|[list.py.lua](./../codeblock/list.py.lua)|


### Dict

dict 是 python 中内建的数据结构，使用非常广泛。
在 lua 中没有内建相应的结构，需要编写相应的 lua 代码来做模拟。

创建 dict 有两种方式，字面量 `d = {}` 和函数 `d = dict()` 的方式。

创建得到的 dict 是一个对象，其中包含自己的数据和方法。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|dict字面量|`d = {'name': 'john', 1: 26}`|`[local] d = dict {['name'] = 'john', [1] = 26}`|:heavy_check_mark:|
|dict函数|`d = dict(m)`|`[local] d = dict(m)`|:heavy_check_mark:|
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


|python示例代码|lua转换代码|
|:-:|:-:|
|[dict.py](./../codeblock/dict.py)|[dict.py.lua](./../codeblock/dict.py.lua)|


### Tuple

tuple 是 list 有只读形式，但是在 python 中 tuple 的存在广泛，比如多变量赋值，多返回值，都作为 tuple 来处理。

所以对于 tuple 的字面量有多种情况，而且和 lua 的表示相冲突，故暂时不支持字面量初始化 tuple 的形式，只支持函数的形式。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|tuple字面量|`t = (1, 2, 3)`|`[local] t = tuple {1, 2, 3}`|:x:|
|tuple函数|`t = tuple([1, 2, 3])`|`[local] t = tuple([1, 2, 3])`|:heavy_check_mark:|
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


|python示例代码|lua转换代码|
|:-:|:-:|
|[tuple.py](./../codeblock/tuple.py)|[tuple.py.lua](./../codeblock/tuple.py.lua)|


### Set

set 同样是 python 中内建的数据结构。
在 lua 中没有内建相应的结构，需要编写相应的 lua 代码来做模拟。

创建 set 有两种方式，字面量 `s = {1, 2, 1}` 和函数 `s = set([1, 2, 3])` 的方式。
创建得到的 set 是一个对象，其中包含自己的数据和方法。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|set字面量|`s = {1, 2, 1}`|`s = set {1, 2, 1}`|:heavy_check_mark:|
|set函数|`s = set([1, 2, 1])`|`s = set(list {1, 2, 1})`|:heavy_check_mark:|
|`add`|`s.add(3)`|`s.add(3)`|:heavy_check_mark:|
|`clear`|`s.clear()`|`s.clear()`|:heavy_check_mark:|
|`copy`|`s.copy()`|`s.copy()`|:heavy_check_mark:|
|`difference`|`s = s.difference(s1, s2)`|`s = s.difference(s1, s2)`|:heavy_check_mark:|
|`difference_update`|`s.difference_update(s1, s2)`|`s.difference_update(s1, s2)`|:heavy_check_mark:|
|`discard`|`s.discard(3)`|`s.discard(3)`|:heavy_check_mark:|
|`intersection`|`s = s.intersection(s1, s2)`|`s = s.intersection(s1, s2)`|:heavy_check_mark:|
|`intersection_update`|`s.intersection_update(s1, s2)`|`s.intersection_update(s1, s2)`|:heavy_check_mark:|
|`isdisjoint`|`s.isdisjoint(s1)`|`s.isdisjoint(s1)`|:heavy_check_mark:|
|`issubset`|`s.issubset(s1)`|`s.issubset(s1)`|:heavy_check_mark:|
|`issuperset`|`s.issuperset(s1)`|`s.issuperset(s1)`|:heavy_check_mark:|
|`pop`|`s.pop()`|`s.pop()`|:heavy_check_mark:|
|`remove`|`s.remove(3)`|`s.remove(3)`|:heavy_check_mark:|
|`symmetric_difference`|`s = s.symmetric_difference(s1)`|`s = s.symmetric_difference(s1)`|:heavy_check_mark:|
|`symmetric_difference_update`|`s.symmetric_difference_update(s1)`|`s.symmetric_difference_update(s1)`|:heavy_check_mark:|
|`union`|`s = s.union(s1, s2)`|`s = s.union(s1, s2)`|:heavy_check_mark:|
|`update`|`s.update(s1, s2)`|`s.update(s1, s2)`|:heavy_check_mark:|


python示例代码|lua转换代码|
|:-:|:-:|
|[set.py](./../codeblock/set.py)|[set.py.lua](./../codeblock/set.py.lua)|


### FrozenSet

frozenset 同样是 python 中内建的数据结构，和 set 的区别在于它是只读的。
在 lua 中没有内建相应的结构，需要编写相应的 lua 代码来做模拟。

创建 frozenset 没有字面量方式，只有函数方式 `s = frozenset([1, 2, 3])`。
创建得到的 frozenset 是一个对象，其中包含自己的数据和方法。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|frozenset函数|`s = frozenset([1, 2, 1])`|`s = frozenset(list {1, 2, 1})`|:heavy_check_mark:|
|`copy`|`s.copy()`|`s.copy()`|:heavy_check_mark:|
|`difference`|`s = s.difference(s1, s2)`|`s = s.difference(s1, s2)`|:heavy_check_mark:|
|`intersection`|`s = s.intersection(s1, s2)`|`s = s.intersection(s1, s2)`|:heavy_check_mark:|
|`isdisjoint`|`s.isdisjoint(s1)`|`s.isdisjoint(s1)`|:heavy_check_mark:|
|`issubset`|`s.issubset(s1)`|`s.issubset(s1)`|:heavy_check_mark:|
|`issuperset`|`s.issuperset(s1)`|`s.issuperset(s1)`|:heavy_check_mark:|
|`symmetric_difference`|`s = s.symmetric_difference(s1)`|`s = s.symmetric_difference(s1)`|:heavy_check_mark:|
|`union`|`s = s.union(s1, s2)`|`s = s.union(s1, s2)`|:heavy_check_mark:|


python示例代码|lua转换代码|
|:-:|:-:|
|[frozenset.py](./../codeblock/frozenset.py)|[frozenset.py.lua](./../codeblock/frozenset.py.lua)|



### Subscript

python 中有 3 种下标，Index, Slice 和 ExtSlice，分别对应于
- `l[1]`
- `l[1:4:2]`
- `l[1:2, 3]`

在 lua 中，默认只有 Index 对应的概念，`l[1]`（对应于 lua 中的 `__index`），其它需要用函数来模拟。


|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|Index|`l[1]`|`l[1]`|:heavy_check_mark:|
|Slice|`l[1:3]`|`l[1:3]`|:heavy_check_mark:|
|ExtSlice|`l[1:2, 3]`|` `|:x:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[subscript.py](./../codeblock/subscript.py)|[subscript.py.lua](./../codeblock/subscript.py.lua)|

------


### If 语句

分支在编程语言中是一个通用概念，而且几乎所有语言的分支关键字都是 if。

python 和 lua 的分支结构是非常相似的。

|feature|python|lua|supported|
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

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|for in list|`for i in [1, 2]`|`for i in list {1, 2}`|:heavy_check_mark:|
|for in dict|`for k, v in d.items()`|`for k, v in d.items()`|:heavy_check_mark:|
|for in range|`for i in range(1, 10, 2)`|`for i in range(1, 10, 2)`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[for.py](./../codeblock/for.py)|[for.py.lua](./../codeblock/for.py.lua)|


### While 语句

同样的，while 语句也是一个通用概念，在 python 和 lua 中非常相似。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|while true|`while True: ...`|`while true do ... end`|:heavy_check_mark:|
|while condition|`while condition: ...`|`while condition do ... end`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[while.py](./../codeblock/while.py)|[while.py.lua](./../codeblock/while.py.lua)|


### Break 语句

break 的含义在 python 和 lua 中相同，用于跳出最内层的循环。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|break|`break`|`break`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[break.py](./../codeblock/break.py)|[break.py.lua](./../codeblock/break.py.lua)|


### Continue 语句

也许难以相信，lua5.1 不支持 Continue 语句，而且这一特性很难模拟 :scream:


|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|continue|`continue`|` `|:x:|


### Pass 语句

在 python 中空的语句块需要 pass 来占位，没有任何含义。
但是 lua 中不需要，对应空语句。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|pass|`pass`|` `|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[pass.py](./../codeblock/pass.py)|[pass.py.lua](./../codeblock/pass.py.lua)|


---


### Function and Call 函数定义和调用

python 的函数定义的关键有 位置参数，默认值参数，vararg，键值参数，kwarg，装饰器。
相比之下，lua 的函数定义就更加简单，只有位置参数。
如果需要同样的效果就要更多的代码工作。

而函数调用在 python lua 以及其它语言中是一个通用概念，使用已经定义的函数。
在 python 的函数调用中，除了位置参数，还有列表参数和字典参数。


|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|函数定义|`def func(): ...`|`function func() do ... end`|:heavy_check_mark:|
|函数调用|`func()`|`func()`|:heavy_check_mark:|
|函数定义，位置参数|`def func(m, n): ...`|`function func(m, n) do ... end`|:heavy_check_mark:|
|函数调用，位置参数|`func(10, 20)`|`func(10, 20)`|:heavy_check_mark:|
|函数定义，默认值参数|`def func(m, n=30): ...`|`function func(m, n) do local n = n or 30 ... end`|:heavy_check_mark:|
|函数调用，默认值参数|`func(10[, 40])`|`func(10[, 40])`|:heavy_check_mark:|
|函数定义，可变长参数|`def func(m, n, *rest): ...`|`function func(m, n, ...) do local rest = list {...} ... end`|:heavy_check_mark:|
|函数调用，可变长参数|`func(10, 20[, 30, 40])`|`func(10, 20[, 30, 40])`|:heavy_check_mark:|
|函数定义，键值参数|`def func(*args, a=1, b=2): ...`|`function func(...) do local args = list {...} ... end`|:x:，目前函数定义不支持键值参数，所有键值参数会被过滤|
|函数调用，键值参数|`func(a=2, b=3)`|` `|:x:|
|函数定义，可变长键值参数|`def func(*args, **kwargs): ...`|`function func(...) do local args = list {...} ... end`|:x:，所有可变长键值参数会被过滤|
|函数调用，可变长键值参数|`func(10, 20, a=30, b=40)`|` `|:x:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[function.py](./../codeblock/function.py)|[function.py.lua](./../codeblock/function.py.lua)|


### Return 语句

return 语句在 python 和 lua 中是相同的，用于从函数中返回值。


|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|返回空值|`return`|`return`|:heavy_check_mark:|
|返回单个值|`return m`|`return m`|:heavy_check_mark:|
|返回多个值|`return m, n`|`return m, n`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[return.py](./../codeblock/return.py)|[return.py.lua](./../codeblock/return.py.lua)|


### Lambda 表达式

在 python 中，lambda 是匿名函数，但是其中不能包含语句，只能包含一个简单的返回值。
而在 lua 中，天生支持匿名函数，并且其中的语句没有限制，在这一点，lua 优于 python。

这一点让人惊奇，lambda 虽然是简单的函数，但是也支持复杂的参数定义，像 Function 定义一样。


|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|匿名函数，位置参数|`lambda x: x + 1`|`function(x) return (x + 1) end`|:heavy_check_mark:|
|匿名函数，默认值参数|`lambda x=1: x + 1`|`function(x) x = x or 1; return (x + 1) end`|:heavy_check_mark:|
|匿名函数，可变长参数|`lambda *n: n`|`function(...) local n = list {...}; return n end`|:heavy_check_mark:|
|匿名函数，键值参数|`lambda *n, a=1: n[0] + a`|`function(...) local n = list {...}; return n[0] + a end`|:x:，同函数定义，键值参数的部分被过滤|
|匿名函数，可变长键值参数|`lambda *args, **kwargs: args`|`function(...) local args = list {...}; return args end`|:x:，同函数定义，键值参数的部分被过滤|


|python示例代码|lua转换代码|
|:-:|:-:|
|[lambda.py](./../codeblock/lambda.py)|[lambda.py.lua](./../codeblock/lambda.py.lua)|


### Yield

在 python 中，yield 有很多应用，从简单的 generator 到交换控制权的协程。
python 中的 yield 是对称性协程机制，而 lua 中的协程机制是非对称的，需要相应的模板代码来和 python 协程的使用保持一致。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|generator 机制|`yield i`|`coroutine.yield(i)`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[yield.py](./../codeblock/yield.py)|[yield.py.lua](./../codeblock/yield.py.lua)|

-----


### Class 类的定义和使用

在 python 中一切都是对象，类是 python 中的关键概念，所有其它的功能几乎都可以用类功能重写。
lua 中不存在类的概念，对于类只能用 table 和 metatable 来模拟。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|类定义|`class Point:`|`class(function(Point) end, {}, "Point")`|:heavy_check_mark:|
|成员方法|`def get_x(self):`|`function Point.get_x(self) end`|:heavy_check_mark:|
|`__init__`|`def __init__(self):`|`function Point.__init__(self) end`|:heavy_check_mark:|
|成员属性|`self.x`|`self.x`|:heavy_check_mark:|
|类属性|`Point.x`|`Point.x`|:heavy_check_mark:|
|类继承|`class Chinese(Person):`|`class(function(Chinese) end, {Person}, "Chinese")`|:heavy_check_mark:|
|`super()`|`super()`|` `|:x:|
|`__mro__`|`Chinese.__mro__`|``|:x:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[class.py](./../codeblock/class.py)|[class.py.lua](./../codeblock/class.py.lua)|


### 属性

python 中一切都是对象，获取对象的属性是常用操作。
在 lua 中，没有对象的概念，对应的 `.` 是索引的概念。

所以属性的核心在于 lua 中如何实现 python 中的对象。


|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|属性|`p.x`|`p.x`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[attribute.py](./../codeblock/attribute.py)|[attribute.py.lua](./../codeblock/attribute.py.lua)|

---

### If 表达式

python 从 perl 借鉴来的语法，将 if 判断作为表达式，而不是语句块，很像 C 语言中的三元表达式。
而在 lua 中，没有这种类型的语法，可以通过二元逻辑的短路特性来模拟。


|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|if 表达式|`1 if True else 0`|`true and 1 or 0`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[if-expr.py](./../codeblock/if-expr.py)|[if-expr.py.lua](./../codeblock/if-expr.py.lua)|


### List 生成式

list 生成式也是 python 中的创新，用表达式来生成列表，本质是循环（+判断）的表达式写法。
在 lua 中没有相应结构，需要用函数调用来模拟。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|list 生成式|`[i + 1 for i in a]`|`(function() local result = list {} for i in a do result.append((i + 1)) end return result end)()`|:heavy_check_mark:|
|配合if，作为map|`[i if i%2 == 1 else 0 for i in a]`|见示例代码|:heavy_check_mark:|
|配合if，作为filter|`[i for i in a if i%2 == 1]`|见示例代码|:heavy_check_mark:|
|多个 list|`[m+n for m in a for n in b]`|见示例代码|:heavy_check_mark:|
|嵌套 list|`[j for i in a for j in i]`|见示例代码|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[list-expr.py](./../codeblock/list-expr.py)|[list-expr.py.lua](./../codeblock/list-expr.py.lua)|


### Dict 生成式

dict 生成式和 list 生成式相似，只不过使用 `k: v` 形式来生成。
在 lua 中没有相应结构，需要用函数调用来模拟。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|dict 生成式|`{ k: v for k, v in d.items() }`|`(function() local result = dict {} for k, v in d.items() do result[k] = v end return result end)()`|:heavy_check_mark:|
|配合if，作为map|`{ k: v if k % 2 == 1 else 10 for k, v in d.items() }`|见示例代码|:heavy_check_mark:|
|配合if，作为filter|`{ k: v for k, v in d.items() if k > 1 }`|见示例代码|:heavy_check_mark:|
|多个 list 生成|`{ k: v for k in l for v in a }`|见示例代码|:heavy_check_mark:|
|嵌套 dict|`{ nk: nv for k, v in d.items() for nk, nv in v.items() }`|见示例代码|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[dict-expr.py](./../codeblock/dict-expr.py)|[dict-expr.py.lua](./../codeblock/dict-expr.py.lua)|



### Set 生成式

set 生成式类似 list 生成式，只不过生成 set 对象。
在 lua 中没有相应结构，需要用函数调用来模拟。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|set 生成式|`{i + 1 for i in s}`|`(function() local result = set {} for i in s do result.add((i + 1)) end return result end)()`|:heavy_check_mark:|
|配合if，作为map|`[i if i%2 == 1 else 0 for i in s]`|见示例代码|:heavy_check_mark:|
|配合if，作为filter|`[i for i in s if i%2 == 1]`|见示例代码|:heavy_check_mark:|
|多个 set|`[m+n for m in s for n in t]`|见示例代码|:heavy_check_mark:|

|python示例代码|lua转换代码|
|:-:|:-:|
|[set-expr.py](./../codeblock/set-expr.py)|[set-expr.py.lua](./../codeblock/set-expr.py.lua)|



### Generator 生成式

语法和列表生成式类似，不过使用的是 () ，得到一个惰性的 generator 对象，而不是即时的列表。
在 lua 中通过 coroutine 非对称性协程可以实现惰性生成式。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|generator 生成式|`(i + 1 for i in a)`|`coroutine.wrap(function() for i in a do coroutine.yield(i + 1)) end end)()`|:heavy_check_mark:|
|配合if，作为map|`(i if i%2 == 1 else 0 for i in a)`|见示例代码|:heavy_check_mark:|
|配合if，作为filter|`(i for i in a if i%2 == 1)`|见示例代码|:heavy_check_mark:|
|多个 list|`(m+n for m in a for n in b)`|见示例代码|:heavy_check_mark:|
|嵌套 list|`(j for i in a for j in i)`|见示例代码|:heavy_check_mark:|



|python示例代码|lua转换代码|
|:-:|:-:|
|[generator.py](./../codeblock/generator.py)|[generator.py.lua](./../codeblock/generator.py.lua)|


----


### Builtin 内建函数

python 语言环境中除了引用标准库，其中有不少有用的[内建函数](https://docs.python.org/3.4/library/functions.html)。
这些函数都需要在 lua 中进行同义模拟。

*TODO：完善更多内建函数*

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|`abs`|`abs(-10)`|`abs(-10)`|:heavy_check_mark:|
|`all`|`all([1, 2])`|`all(list {1, 2})`|:heavy_check_mark:|
|`any`|`any([0, 1])`|`any(list {0, 1})`|:heavy_check_mark:|
|`ascii`|`todo`|` `|:x:|
|`bin`|`bin(10)`|`bin(10)`|:heavy_check_mark:|
|`bool`|`bool(True)`|`bool(true)`|:heavy_check_mark:|
|`bytearray`|` `|` `|:x:，涉及底层二进制编码对象，不支持|
|`bytes`|` `|` `|:x:，涉及底层二进制编码对象，不支持|
|`callable`|`callable(all)`|`callable(all)`|:heavy_check_mark:|
|`chr`|`todo`|` `|:x:|
|`classmethod`|`todo`|` `|:x:|
|`compile`|`compile()`|` `|:x:，python 底层编译原理的上层接口，不支持|
|`complex`|`todo`|` `|:x:|
|`delattr`|` `|` `|:x:|
|`dict`|`dict({1: 'a'})`|`dict({1: 'a'})`|:heavy_check_mark:|
|`dir`|`dir()`|` `|:x:，python 用来 inspect 对象属性的方法，因为 lua 底层并没有完全用对象模式来模拟，所以不支持|
|`divmod`|`divmod(10, 3)`|`divmod(10, 3)`|:heavy_check_mark:|
|`enumerate`|`for i, n in enumerate([1, 2]):`|`for i, n in enumerate(list {1, 2})`|:heavy_check_mark:|
|`eval`|`eval()`|` `|:x:，动态执行 python 代码，属于元编程的范畴，难以支持|
|`exec`|`exec()`|` `|:x:，和 `eval` 类似，难以支持|
|`filter`|`filter(bool, l)`|`filter(bool, l)`|:heavy_check_mark:|
|`float`|`float('10.4')`|`float('10.4')`|:heavy_check_mark:|
|`format`|`todo`|` `|:x:|
|`frozenset`|`todo`|` `|:x:|
|`getattr`|`todo`|` `|:x:|
|`globals`|`globals()`|` `|:x:，返回全局作用域下的变量信息|
|`hasattr`|`todo`|` `|:x:|
|`hash`|`hash()`|` `|:x:，python 底层根据对象值的一种哈希方法|
|`help`|`help()`|` `|:x:，不支持|
|`hex`|`hex(10)`|`hex(10)`|:heavy_check_mark:|
|`id`|`id()`|` `|:x:，python 底层用于标识对象的唯一标识符|
|`input`|`todo`|` `|:x:|
|`int`|`int()`|`int()`|:heavy_check_mark:|
|`isinstance`|`todo`|` `|:x:|
|`issubclass`|`todo`|` `|:x:|
|`iter`|`todo`|` `|:x:|
|`len`|`len([1, 2])`|`len(list {1, 2})`|:heavy_check_mark:|
|`list`|`list([1, 2])`|`list(list {1, 2})`|:heavy_check_mark:|
|`locals`|`locals()`|` `|:x:，返回当前作用域下所有局部变量的信息|
|`map`|`map(bool, l)`|`map(bool, l)`|:heavy_check_mark:|
|`max`|`max(1, 2, 3)`|`max(1, 2, 3)`|:heavy_check_mark:|
|`memoryview`|`memoryview()`|` `|:x:，涉及底层内存分布，不支持|
|`min`|`min(1, 2, 3)`|`min(1, 2, 3)`|:heavy_check_mark:|
|`next`|`todo`|` `|:x:|
|`object`|`todo`|` `|:x:|
|`oct`|`oct(10)`|`oct(10)`|:heavy_check_mark:|
|`open`|`todo`|` `|:x:|
|`ord`|`todo`|` `|:x:|
|`pow`|`pow(2, 10)`|`pow(2, 10)`|:heavy_check_mark:|
|`print`|`todo`|` `|:x:|
|`property`|`todo`|` `|:x:|
|`range`|`for i in range(1, 10):`|`for i in range(1, 10):`|:heavy_check_mark:|
|`reduce`|`reduce(add, [1, 2, 3])`|`reduce(add, list {1, 2, 3})`|:heavy_check_mark:|
|`repr`|`todo`|` `|:x:|
|`reversed`|`reversed(l)`|`reversed(l)`|:heavy_check_mark:|
|`round`|`round(10.49)`|`round(10.49)`|:heavy_check_mark:|
|`set`|`set([1, 2, 1])`|`set([1, 2, 1])`|:heavy_check_mark:|
|`setattr`|`todo`|` `|:x:|
|`slice`|`slice(1, 4, 2)`|`slice(1, 4, 2)`|:heavy_check_mark:|
|`sorted`|`sort(l)`|`sort(l)`|:heavy_check_mark:|
|`staticmethod`|`todo`|` `|:x:|
|`str`|`todo`|` `|:x:|
|`sum`|`sum([1, 2, 3])`|`sum(list {1, 2, 3})`|:heavy_check_mark:|
|`super`|`todo`|` `|:x:|
|`tuple`|`tuple([1, 2, 3])`|`tuple(list {1, 2, 3})`|:heavy_check_mark:|
|`type`|`type()`|` `|:x:，python 类体系中的顶层核心，不支持|
|`vars`|`vars()`|` `|:x:，返回相应作用域下变量信息，和 `locals` 相似|
|`zip`|`zip(l1, l2)`|`zip(l1, l2)`|:heavy_check_mark:|
|`__import__`|`__import__()`|` `|:x:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[builtin.py](./../codeblock/builtin.py)|[builtin.py.lua](./../codeblock/builtin.py.lua)|



---


### Assert 断言

python 和 lua 都内建了 assert 函数，进行真值的断言，如果为假，则程序 exit，附加 assert message。
transpile 的测试就是通过 assert 来实现的。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|断言|`assert 1 == 1`|`assert((1 == 1))`|:heavy_check_mark:|
|断言+消息|`assert 1 == 1, "one always one"`|`assert((1 == 1), "one always one")`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[assert.py](./../codeblock/assert.py)|[assert.py.lua](./../codeblock/assert.py.lua)|


### With 语句

python 中独有的上下文操作，目前不支持。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|with 上下文|`with ...:`|` `|:x:|


### Raise， Try

和 continue 一样遗憾的是，lua 中不支持异常。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|异常操作|`raise, try`|` `|:x:|


### Import ImportFrom

import 的实现需要配合 module 概念的引入，将单个文件作为一个 module。
lua 中也有 module 的概念，需要将其与 python 的 module 写法相适配。

暂时不支持。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|`import`|`import module`|` `|:x:|


### Global Nonlocal

Global 和 Nonlocal 关键字，核心涉及到 python 的作用域问题。
python 的作用域和 lua 是有些不同的。

在 python 中，最顶层是全局作用域，在内部嵌套的作用域可以访问全局作用域的变量，但是如果对其进行修改，
需要用 global 来声明。

其次，由于作用域可能有多重嵌套，使用 nonlocal 可以在内部作用域修改外部作用域的变量，顺着嵌套的层次一路向上查找，而不是像 global 一样直接找到全局作用域。

python 中的作用域遵循 `L E G B` 原则，即 局部作用域，闭包作用域，全局作用域，内建作用域。
当使用 def/lambda/class/generator，开启一个新的作用域。

def 可以开启闭包作用域，class 不能。使用 nonlocal 同样进行的是从 L 出发的 E G B 的查找，如果没有开启闭包作用域，即使使用 nonlocal 也是不行的。

因为 lambda 和 generator 只能使用一行表达式，无法作用赋值，在新的作用域中作用有限，意义最大在于它不会和已有的上层作用域相冲突。

因为 lua 本身遵循由内到外的查找方式，其中 `_G` 是整个语言的全局变量，而不是当前模块的最顶层，所以 global 关键字无法支持。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|`global`|`global g`|` `|:x:|
|`nonlocal`|`nonlocal n`|` `|:x:|

----


### Python newer than 3.4

在 python 3.4 版本之后（3.5, 3.6, 3.7）添加的 `新语法和 builtin 函数`，当前都不支持。


#### [python 3.5](https://docs.python.org/3/whatsnew/3.5.html)

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|async, await异步|`async/await`|` `|:x:|
|矩阵乘法操作|`a @ b`|` `|:x:|
|在函数调用中，不限制 `* **` 解压的数量，同时 tuple list set dict 都支持解压|`f(*args1, *args2)`|` `|:x:|

#### [python 3.6](https://docs.python.org/3/whatsnew/3.6.html)

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|格式化字面量|`f"He said his name"`|` `|:x:|
|变量类型提示 type hints|`captain: str`|` `|:x:|
|数字字面量支持 `_`|`1_000_000`|` `|:x:|
|异步生成器|`await and yield`|` `|:x:|
|异步生成表达式|`await and for`|` `|:x:|

#### [python 3.7](https://docs.python.org/3/whatsnew/3.7.html)

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|type hints 的延时执行|` `|` `|:x:|
|builtin breakpoint()|`breakpoint()`|` `|:x:|

