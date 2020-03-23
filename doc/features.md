# supported features

medusa 支持转译的 python 语言以 3.4 为基准，支持大部分语言功能。
转译为 lua 语言 5.1 版本（除了 goto label 部分）。

## python features

### Constant 常量

从语义上讲，python 中的 `True False None`，对应于 lua 中的 `true false nil`。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|布尔真|`True`|`true`|:heavy_check_mark:|
|布尔假|`False`|`false`|:heavy_check_mark:|
|空|`None`|`nil`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[constant.py](./../tests/constant.py)|[constant.lua](./../tests/constant.lua)|


### Variable 变量

python 和 lua 都是弱类型语言，变量没有类型。

变量第一次出现的时候，变量前面需要加上 `local`，限定变量的作用域；在变量同一作用域再使用的时候，不再需要 `local`。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|变量|`var`|`[local] var`|:heavy_check_mark:|

|python示例代码|lua转换代码|
|:-:|:-:|
|[variable.py](./../tests/variable.py)|[variable.lua](./../tests/variable.lua)|

### Assign 语句

python 中多种赋值方法，都可以转化为相应的 lua 代码来实现。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|单变量赋值|`a = 1`|`local a = 1`|:heavy_check_mark:|
|多变量赋相同值|`a = b = 1`|`local a = 1; local b = 1`|:heavy_check_mark:|
|多变量同时赋值|`a, b = b, a`|`a, b = b, a`|:heavy_check_mark:|

*TODO: 除了上面描述的情况，python 中还存在其它的赋值方法，目前仍未完全支持，具体可参见示例代码中的注释*

|python示例代码|lua转换代码|
|:-:|:-:|
|[assign.py](./../tests/assign.py)|[assign.lua](./../tests/assign.lua)|


### Del 语句

python 中 del 语句用于解除一个值，lua 中没有 del 的概念，可以用赋值 nil 来进行同义模拟。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|del|`del v`|`v = nil`|:heavy_check_mark:|

|python示例代码|lua转换代码|
|:-:|:-:|
|[del.py](./../tests/del.py)|[del.lua](./../tests/del.lua)|


### AugAssign 语句

自赋值，是一种简便的写法。
在 python 中，任何二元运算都有相应的自赋值写法，比如 `a += 1`，`b *= 3`。
在 lua 中没有相应的概念，但是可以将赋值的右侧展开进行同义模拟。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|augassign|`a += 1`|`a = a + 1`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[augassign.py](./../tests/augassign.py)|[augassign.lua](./../tests/augassign.lua)|


### Bool 布尔运算

python 和 lua 本身都支持 and or 二元运算，都为短路求值，且 and or 的优先级（and 高于 or，先结合）相同。
同时两者都支持 not 一元运算，返回 True/False(python) true/false(lua)。

布尔运算可以无缝转换。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|与|`1 and 2`|`1 and 2`|:heavy_check_mark:|
|或|`1 or 2`|`1 or 2`|:heavy_check_mark:|
|非|`not 1`|`not 1`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[bool.py](./../tests/bool.py)|[bool.lua](./../tests/bool.lua)|


### Arithmetic 算术运算

几乎所有语言都内建基本的算术运算，python lua 也不例外。
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
|[arithmetic.py](./../tests/arithmetic.py)|[arithmetic.lua](./../tests/arithmetic.lua)|


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
|[bit.py](./../tests/bit.py)|[bit.lua](./../tests/bit.lua)|


### Compare 比较运算

对于大于，等于，小于，属于编程语言中通用的元素，python 和 lua 都支持（重载的情况另外讨论）。
对于 is，在 python 中使用底层的内存模型来判断，在 lua 中没有那么准确。
对于 in, 涉及到迭代器，用于判断一个对象是否在可迭代对象中。

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
|[compare.py](./../tests/compare.py)|[compare.lua](./../tests/compare.lua)|


### List 列表

list 是 python 内建的数据结构，应用广泛。
lua 中不存在相应的概念，需要编写相应代码来模拟（元表实现类和对象）。

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
|in|`0 in l`|`operator_in(0, l)`|:heavy_check_mark:|
|not in|`0 not in l`|`not operator_in(0, l)`|:heavy_check_mark:|
|`+`|`l1 + l2`|`l1 + l2`|:heavy_check_mark:|
|`*`|`l * 5`|`l * 5`|:heavy_check_mark:|
|索引|`l[0]`|`l[0]`|:heavy_check_mark:|
|索引|`l[0:3]`|`l[slice(0, 3)]`|:heavy_check_mark:|
|索引|`l[0:5:2]`|`l[slice(0, 5, 2)]`|:heavy_check_mark:|
|索引赋值|`l[0] = 1`|`l[0] = 1`|:heavy_check_mark:|
|索引赋值|`l[0:3] = [0]`|`l[slice(0, 3)] = list {0}`|:heavy_check_mark:|
|索引赋值|`l[0:5:2] = [1,2,3]`|`l[slice(0, 5, 2)] = list {1,2,3}`|:heavy_check_mark:|
|删除索引|`del l[0]`|` `|:x:，目前和 `l[0] = None` 相冲突|
|删除索引|`del l[0:2]`|`l[slice(0,2)] = nil`|:heavy_check_mark:|
|删除索引|`del l[0:5:2]`|`l[slice(0,5,2)] = nil`|:heavy_check_mark:|

|python示例代码|lua转换代码|
|:-:|:-:|
|[list.py](./../tests/list.py)|[list.lua](./../tests/list.lua)|


### Dict 字典

dict 是 python 中内建的数据结构，使用非常广泛。
在 lua 中没有内建相应的结构，需要编写相应的 lua 代码来做模拟（元表实现）。

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
|in|`0 in d`|`operator_in(0, d)`|:heavy_check_mark:|
|not in|`0 not in d`|`not operator_in(0, d)`|:heavy_check_mark:|
|索引`[k]`|`d[k]`|`d[k]`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[dict.py](./../tests/dict.py)|[dict.lua](./../tests/dict.lua)|


### Tuple 元组

tuple 可看作是只读的 list，但是在 python 中 tuple 的存在广泛，比如多变量赋值，多返回值，都作为 tuple 来处理。
所以对于 tuple 的字面量的多种情况很难保持统一的转换，故暂时不支持字面量创建 tuple，只支持函数创建。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|tuple字面量|`t = (1, 2, 3)`|`[local] t = tuple {1, 2, 3}`|:x:|
|tuple函数|`t = tuple([1, 2, 3])`|`[local] t = tuple([1, 2, 3])`|:heavy_check_mark:|
|`count`|`t.count(4)`|`t.count(4)`|:heavy_check_mark:|
|`index`|`t.index(4)`|`t.index(4)`|:heavy_check_mark:|
|in|`0 in t`|`operator_in(0, t)`|:heavy_check_mark:|
|not in|`0 not in t`|`not operator_in(0, t)`|:heavy_check_mark:|
|`+`|`t1 + t2`|`t1 + t2`|:heavy_check_mark:|
|`*`|`t * 5`|`t * 5`|:heavy_check_mark:|
|索引|`t[0]`|`t[0]`|:heavy_check_mark:|
|索引|`t[0:3]`|`t[slice(0, 3)]`|:heavy_check_mark:|
|索引|`t[0:5:2]`|`t[slice(0, 5, 2)]`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[tuple.py](./../tests/tuple.py)|[tuple.lua](./../tests/tuple.lua)|


### Set 集合

set 同样是 python 中内建的数据结构。
在 lua 中没有内建相应的结构，需要编写相应的 lua 代码来做模拟（元表实现）。

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
|in|`0 in s`|`operator_in(0, s)`|:heavy_check_mark:|
|not in|`0 not in s`|`not operator_in(0, s)`|:heavy_check_mark:|
|`\|`|`s1 \| s2`|`bit.bor(s1, s2)`|:heavy_check_mark:|
|`&`|`s1 & s2`|`bit.band(s1, s2)`|:heavy_check_mark:|
|`-`|`s1 - s2`|`s1 - s2`|:heavy_check_mark:|
|`^`|`s1 ^ s2`|`bit.bxor(s1, s2)`|:heavy_check_mark:|


python示例代码|lua转换代码|
|:-:|:-:|
|[set.py](./../tests/set.py)|[set.lua](./../tests/set.lua)|


### FrozenSet 只读集合

frozenset 同样是 python 中内建的数据结构，和 set 的区别在于它是只读的。
在 lua 中没有内建相应的结构，需要编写相应的 lua 代码来做模拟（元表实现）。

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
|in|`0 in s`|`operator_in(0, s)`|:heavy_check_mark:|
|not in|`0 not in s`|`not operator_in(0, s)`|:heavy_check_mark:|
|`\|`|`s1 \| s2`|`bit.bor(s1, s2)`|:heavy_check_mark:|
|`&`|`s1 & s2`|`bit.band(s1, s2)`|:heavy_check_mark:|
|`-`|`s1 - s2`|`s1 - s2`|:heavy_check_mark:|
|`^`|`s1 ^ s2`|`bit.bxor(s1, s2)`|:heavy_check_mark:|


python示例代码|lua转换代码|
|:-:|:-:|
|[frozenset.py](./../tests/frozenset.py)|[frozenset.lua](./../tests/frozenset.lua)|


### Subscript 下标

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
|[subscript.py](./../tests/subscript.py)|[subscript.lua](./../tests/subscript.lua)|


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
|[if.py](./../tests/if.py)|[if.lua](./../tests/if.lua)|


### For 语句

for in 是 python 中常用的迭代方法，其核心是迭代器。
lua 中也有 for in 的语法，和 python 的实现非常类似，只不过底层对于迭代器的工作机制有些许差异。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|for in list|`for i in [1, 2]`|`for i in list {1, 2}`|:heavy_check_mark:|
|for in dict|`for k, v in d.items()`|`for k, v in d.items()`|:heavy_check_mark:|
|for in range|`for i in range(1, 10, 2)`|`for i in range(1, 10, 2)`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[for.py](./../tests/for.py)|[for.lua](./../tests/for.lua)|


### While 语句

while 语句也是一个通用概念，在 python 和 lua 中也是相似的。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|while true|`while True: ...`|`while true do ... end`|:heavy_check_mark:|
|while condition|`while condition: ...`|`while condition do ... end`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[while.py](./../tests/while.py)|[while.lua](./../tests/while.lua)|


### Break 语句

break 的含义在 python 和 lua 中相同，用于跳出最内层的循环。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|break|`break`|`break`|:heavy_check_mark:|

|python示例代码|lua转换代码|
|:-:|:-:|
|[break.py](./../tests/break.py)|[break.lua](./../tests/break.lua)|


### Continue 语句

也许难以相信，lua5.1 不支持 continue 语句，在 lua5.2（包括 luajit） 之后引入了 goto 和 label，可以使用其来进行模拟。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|continue|`continue`|`goto ::label::`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[continue.py](./../tests/continue.py)|[continue.lua](./../tests/continue.lua)|


### Pass 语句

在 python 中空的语句块需要 pass 来占位，没有任何含义。
但是 lua 中不需要，对应空语句。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|pass|`pass`|` `|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[pass.py](./../tests/pass.py)|[pass.lua](./../tests/pass.lua)|


### Function and Call 函数定义和调用

python 中的函数定义很复杂，有 位置参数，默认值参数，可变长参数，键值参数，可变长键值参数，装饰器。
相比之下，lua 的函数定义就更加简单，只有位置参数和可变长参数。
如果需要实现同样的效果就要更多的代码工作。

至于函数调用在 python lua 以及其它语言中是一个通用概念，使用已经定义的函数。
在 python 的函数调用中，除了位置参数，也使用键值参数，以及`*args` `**kwargs` 的自展开参数。

对于位置参数，可变长参数和默认值参数，在 lua 中相对容易实现，而键值参数之类，还没有合适的方法，也是一个遗憾。

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
|[function.py](./../tests/function.py)|[function.lua](./../tests/function.lua)|


### Return 语句

return 语句在 python 和 lua 中作用相同，从函数中返回值。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|返回空值|`return`|`return`|:heavy_check_mark:|
|返回单个值|`return m`|`return m`|:heavy_check_mark:|
|返回多个值|`return m, n`|`return m, n`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[return.py](./../tests/return.py)|[return.lua](./../tests/return.lua)|


### Lambda 表达式

在 python 中，lambda 是匿名函数，但是其中不能包含语句，只能包含一个简单的返回值。
而在 lua 中，天生支持匿名函数，并且其中的语句没有限制，在这一点，lua 优于 python。

lambda 虽然是简单的匿名函数，但是参数定义和 function 定义中相统一。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|匿名函数，位置参数|`lambda x: x + 1`|`function(x) return (x + 1) end`|:heavy_check_mark:|
|匿名函数，默认值参数|`lambda x=1: x + 1`|`function(x) x = x or 1; return (x + 1) end`|:heavy_check_mark:|
|匿名函数，可变长参数|`lambda *n: n`|`function(...) local n = list {...}; return n end`|:heavy_check_mark:|
|匿名函数，键值参数|`lambda *n, a=1: n[0] + a`|`function(...) local n = list {...}; return n[0] + a end`|:x:，同函数定义，键值参数的部分被过滤|
|匿名函数，可变长键值参数|`lambda *args, **kwargs: args`|`function(...) local args = list {...}; return args end`|:x:，同函数定义，键值参数的部分被过滤|


|python示例代码|lua转换代码|
|:-:|:-:|
|[lambda.py](./../tests/lambda.py)|[lambda.lua](./../tests/lambda.lua)|


### Yield 协程

在 python 中，yield 有很多应用，从简单的 generator 到交换控制权的协程。
python 中的 yield 是对称性协程机制，而 lua 中的协程机制是非对称的，需要相应的模板代码来和 python 协程的使用保持一致。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|generator 机制|`yield i`|`coroutine.yield(i)`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[yield.py](./../tests/yield.py)|[yield.lua](./../tests/yield.lua)|


### Class 类

在 python 中一切都是对象，类是 python 中的关键概念。
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
|[class.py](./../tests/class.py)|[class.lua](./../tests/class.lua)|


### Attribute 属性

python 中一切都是对象，获取对象的属性是常用操作。
在 lua 中，没有对象的概念，只有 `.` 索引。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|属性|`p.x`|`p.x`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[attribute.py](./../tests/attribute.py)|[attribute.lua](./../tests/attribute.lua)|


### If 表达式

python 从 perl 借鉴来的语法，将 if 判断作为表达式，而不是语句块，很像 C 语言中的三元表达式。
而 lua 中，没有这种类型的语法，可以通过二元逻辑的短路特性来模拟。


|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|if 表达式|`1 if True else 0`|`true and 1 or 0`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[if-expr.py](./../tests/if-expr.py)|[if-expr.lua](./../tests/if-expr.lua)|


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
|[list-expr.py](./../tests/list-expr.py)|[list-expr.lua](./../tests/list-expr.lua)|


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
|[dict-expr.py](./../tests/dict-expr.py)|[dict-expr.lua](./../tests/dict-expr.lua)|


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
|[set-expr.py](./../tests/set-expr.py)|[set-expr.lua](./../tests/set-expr.lua)|


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
|[generator.py](./../tests/generator.py)|[generator.lua](./../tests/generator.lua)|


### Builtin 内建函数

python 语言环境中除了引用标准库，其中有不少有用的[内建函数](https://docs.python.org/3.4/library/functions.html)。
这些函数都需要在 lua 中进行同义模拟。

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
|[builtin.py](./../tests/builtin.py)|[builtin.lua](./../tests/builtin.lua)|


### Assert 断言

python 和 lua 都内建了 assert 函数，进行真值的断言，如果为假，则程序 exit，附加 assert message。
medusa 的所有测试就是通过 assert 来实现的。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|断言|`assert 1 == 1`|`assert((1 == 1))`|:heavy_check_mark:|
|断言+消息|`assert 1 == 1, "one always one"`|`assert((1 == 1), "one always one")`|:heavy_check_mark:|

|python示例代码|lua转换代码|
|:-:|:-:|
|[assert.py](./../tests/assert.py)|[assert.lua](./../tests/assert.lua)|


### With 语句

python 中独有的上下文操作，当前不支持。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|with 上下文|`with ...:`|` `|:x:|


### Raise， Try

lua 中不支持异常，而且这一特性很难模拟。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|异常操作|`raise, try`|` `|:x:|


### Import ImportFrom

import 的实现需要配合 module 概念的引入，将单个文件作为一个 module。
lua 中也有 module 的概念，在文件内部使用局部变量，最终使用 `return` 返回一个 table，其中存储模块的对应关系。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|`import`|`import module`|`local module = require('module')`|:heavy_check_mark:|
|`import as`|`import module as m`|`local m = require('module')`|:heavy_check_mark:|
|`from import`|`from module import func`|`local func = require('module').func`|:heavy_check_mark:|
|`from import as`|`from module import func as f`|`local f = require('module').func`|:heavy_check_mark:|


|python示例代码|lua转换代码|
|:-:|:-:|
|[import.py](./../tests/import.py)|[import.lua](./../tests/import.lua)|
|[module.py](./../tests/module.py)|[module.lua](./../tests/module.lua)|
|[module_2.py](./../tests/module_2.py)|[module_2.lua](./../tests/module_2.lua)|


### Global Nonlocal

global 和 nonlocal 关键字，核心涉及到 python 的作用域问题。python 的作用域和 lua 是有些不同的。

python 中的作用域遵循 `L E G B` 原则，即 局部作用域，闭包作用域，全局作用域，内建作用域。
当使用 def/lambda/class/generator，开启一个新的作用域。

在 python 中，最顶层是全局作用域，在内部嵌套的作用域可以访问全局作用域的变量，但是如果对其进行修改，
需要用 global 来声明。

def 可以开启闭包作用域，class 不能。使用 nonlocal 进行的是从 L 出发进行 E 查找，不会的查找非闭包作用域的符号。

而 lua 本身遵循由内到外的查找方式，每个 `... end` 定义一个块，每个块中有自己的 local 作用域，搜索过程中从内向外的，直到最外层 global。
并且对于找到的变量可以直接修改，不像 python 需要 global, nonlocal 声明。

正因为搜索的中途可能有和 global 相同的符号存在，所以不支持 global 关键字。
也正因为向上查找的特性，为 nonlocal 的实现提供了可能。

有趣的是，python 会在语法层面检测 nonlocal 的正确性。如果使用 nonlocal 和一个不在外部 enclosure 的变量，会出现语法错误。

|feature|python|lua|supported|
|:-:|:-:|:-:|:-:|
|`nonlocal`|`nonlocal n`|`[means n is in enclosure scope]`|:heavy_check_mark:|
|`global`|`global g`|` `|:x:|


### Python newer than 3.4

在 python 3.4 版本之后（3.5, 3.6, 3.7）添加的 `新语法和 builtin 函数`，当前不支持。

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

