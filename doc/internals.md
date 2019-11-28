# medusa internals

## 核心问题

medusa 是一个 transpiler。
transpile 不同于 compile，它的本质在于，要用 lua 代码实现和 python 代码相同的语义。

从语义相同的角度入手，实现一个 transpiler 就有不同的角度。

一种方法，研究 lua 语言的所有规则和 python 语言的所有规则，transpiler 所做的，就是将 python 代码视为规则集，进行规则的同义转换，用 lua 代码的规则来表示。

比如对于 if 的规则，使用的就是这一种思路。

```python
if True:
    a = 1
else:
	a = 0
```

```lua
if true then
    a = 1
else
	a = 0
end
```

另一种方法，将 python 语言看作一个完整的程序，transpiler 要做的，是用 lua 来实现 python 底层语言机制。

比如使用元表来实现 list 数据结构，使用的就是这一种思路。


在 medusa 的实现过程中，上面两种思路都有所使用。

规则转换的思路，适用于语言构架的关键字，比如 if/while/for/yield/etc。

实现底层机制的思路，适用于 lua 本身未包含的规则，比如 class/list/generator/etc。


## 实现方式


从规则转换的思路开始，对于 python 代码，先将其解析为 ast 结构，再对 ast 进行遍历，进行规则的同义转换，生成 lua 代码。

从实现底层机制的角度，还需要存在 polyfill 代码，在其中实现 lua 中本不存在的规则。

medusa 正是将这两者进行合理协调的结果。


## 语言认知

medusa 需要做的是找到和 python 代码同义的 lua 代码，而 python 语言本身不只是语法规则这么简单，主要的规则和功能都是在虚拟机中实现的。

transpiler 可以理解为运行在编译时，对于一些在虚拟机中运行时中没有办法解决的。

比如 super() （在运行时动态检测 `__mro__` 链的变化），异常机制，元编程。


### 优势

假如一个系统中，已经集成了 lua 作为上层控制语言，如果这时系统需要集成新的上层控制语言，比如 python。
使用 transpiler 是一个可以选择的方式。

因为如果从底层集成一门语言，需要在底层代码做大量工作，对接不同的 API。
而如果使用 transpile 的方式，就不需要集成语言，对于当前系统已集成 lua 语言功能，都可以用等义的 python 语言来调用，而且不用修改系统本身。

### 劣势

真实世界里，需要用到 transpiler 的地方是很少的。
很难有一种方法，将两种语言进行完整的同义转换，因为语言的设计总是不同的，总会有差异存在。


另一个方面，一旦你了解了转换的规则，那么当前支持的 python 语言就是语言混杂的产物。

比如在 python 中，调用 `math.sin()`，在没有引入 `math` 库时它是错误操作，但是 transpiler 运行在编译时，不会检测 math 是否存在，但是你知道它转换后是原封不动的，在转换后的 lua 代码中依然是 `math.sin()`，就是正确可运行的。


## 细节问题

在实现 medusa 的过程中，遇到了一些语言设计方面的异同，导致很我细节问题，在这里讨论一下。

### None 和 nil

在常量中，第一印象中我们倾向于将 None 和 nil 等价，直接进行规则层面的转换，但是这个简单的等同在后续的过程中带了不少的问题。

后续的 list/dict/etc 等结构都使用 table/metatable 来实现。

假如将 dict 和 lua table 单纯对应，在 python 中，None 可作为键，也可以作为值，

```python
d = { 'a': None, None: 1 }
assert d['a'] == None
assert d[None] == 1
```

而如果直接用 lua table 来等价

```lua
d = { ['a'] = nil, nil = 1 }
```

有两个问题，
1. table 中被赋值为 nil 等价于将这个键删除
2. table 根本不允许 nil 作为键

所以需要大量细节方面的转换来兼容 None 的情况

### 迭代器的终止条件

在 python 中，迭代器的终止条件通过 StopIteration 来实现，
而在 lua 中，终止条件是通过判断每次迭代器返回的值是否是 nil 来判断的。

比如在 python 中，


```python
for i in l:
    print(i)
```

如果进行规则转换，

```lua
for i in l do
    print(i)
end
```


如果在 l 中有 nil 值，就会提前导致迭代终止。


正确的做法是保留迭代器的判断值，在第二值遍历列表值，这也是 lua 迭代器本身的设计。

```lua
for _, i in l do
    print(i)
end
```

### 真假值的异同

在 python 中，`False "" 0 None 空list/set/etc` 都被视为 bool 假，
而在 lua 中，只有 `false nil` 被视为 bool 假。



## 遗憾之处

### 关键字的碰撞

这个问题是最有意思的，也是完全没有考虑到的。

比如 end，在 lua 中是关键字，而在 python 中不是。
假如在 python 中定义函数，


```python
def end():
    pass
```

用 lua 的函数来表示，


```python
function end()
end
```

将直接导致语法错误。

虽然目前发现了这一点，暂时还没有在 medusa 中解决。


### 键值参数

python 中的函数定义，涉及到多种参数类型。
对于位置参数，可变长参数，在 lua 中有原生的支持。

但是对于键值参数，可变长键值参数，还没有合适的方法来实现。


```python
def func(a, b=1, *c, e=2, f, **g):
    pass
```


### 简单的类

当前对于类的实现过于简单，没有实现 mro 机制。

对于其它应该是类对象的对象只用简单的函数来模拟，比如 bool, range 本应该是对象，却只用了函数来“等价”。

类是 python 语言的核心，如果没有实现同义的类结构，在后续的很多地方都是受限的，比如魔术方法，多继承，元编程等。


