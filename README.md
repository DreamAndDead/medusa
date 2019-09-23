# python to lua rules

第一步，我们先反向行动，用 python 表达出目前 codeblock 图块所能表达的东西。

其中有这些要点
- pure function call (maybe function def as parameter)
- repeat until
- for i=i, 10 do end
- for in do end
- while
- if then
- assignment
- binop, unaryop
- _G global

先从这些部分开始

## pure function call

with out class and attribute things

理论上，lua 普通的 function call，python 都可以支持。
而且形式不用发生变化。

无论参数是 数字，字符串，还是变量。

比如

``` lua
moveForward(1, 0.5)
say("hello", 1)
wait(time)
```

lua 中可能出现 ... 作为参数的情况，可以用 python 中的 *arg 来模拟，
因为 ... 在 lua 中用变量 arg 来存储，数组形式，但是它还有一个键值为 n=，记录了参数的个数。

这里先不讨论，因为我们最终的目的是用 lua 表达 python，而不是用 python 表达 lua。
所以关注的问题应该是，python 中出现 *arg 应该如何用 lua 来表达。


### function as parameter

在 python 中，如果多次定义同样名称的函数，
后面定义的会覆盖之前的定义，这样就可以在需要 callback 的时候就定义相应函数
不用担心与其它地方相冲突
在 lua 中，也会使用同样的机制，后定义的函数覆盖之前的定义，
这样就使得回调函数转化的代码可以通用


