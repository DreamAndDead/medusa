# py2lua internals

how to do transpiling work?




也是编译时，至于虚拟机运行时是没有办法的


transpiler 运行在编译层面，运行时出现的问题它也不能解决。

用另一种语言实现语言。

不需要集成语言，而进行翻译，可以使用大部分已知的系统的功能。

https://docs.python.org/3.5/library/stdtypes.html



单纯的转换和实现是不同的
自然语言的翻译类比
实际编程语言是一种程序




扩展了原有系统的功能

比如 math.pow()，你知道它转换后是原封不动的，就可以在 python 中这样写。



错误的对应关系。



做标准解释器做的事情。



将代码看作文本，进行规则集的操作



两种语言的异同



transpile 的本质在于，用 lua 实现 python 语言所表现的语义，相当于用 lua 实现了 python。


遗憾之处

类过于简单，没有 python 的核心


迭代器重写
None 作用键值的失误
